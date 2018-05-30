#include "printmanager.h"
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>
#include <QPrinter>
#include <QPrintDialog>
#include <QQuickTextDocument>
#include "settingsmodel.h"
#include <ctime>

PrintManager::PrintManager(QObject *parent) : QObject(parent)
{

}

void PrintManager::appendSpace(QString &data, int count)
{
    for (int i = 0; i < count; i++)
    {
        data.append(' ');
    }

    return;
}

QString PrintManager::appendName(QString name)
{
    QString itemData;
    int nameLen = name.length();

    if (nameLen < 23)
    {
        itemData.append(name);
        appendSpace(itemData, 22-nameLen);
    }
    else
    {
        itemData.append(name.mid(0, 21));
        appendSpace(itemData, 1);
    }

    return itemData;
}

void PrintManager::appendQuantity(QString &itemData, QString quantity)
{
    int qtyLen = quantity.length();

    if (qtyLen < 5)
    {
        QString space;
        appendSpace(space, 4 - qtyLen);
        itemData.append(space);
        itemData.append(quantity);
        appendSpace(itemData, 1);
    }

    return;
}

void PrintManager::appendPrice(QString &itemData, QString price)
{
    int priceLen = price.length();

    if (priceLen < 11)
    {
        QString space;
        appendSpace(space, 10 - priceLen);
        itemData.append(space);
        itemData.append(price);
        appendSpace(itemData, 1);
    }

    return;
}

void PrintManager::appendAmount(QString &itemData, QString amount)
{
    int amountLen = amount.length();

    if (amountLen < 11)
    {
        QString space;
        appendSpace(space, 10 - amountLen);
        itemData.append(space);
        itemData.append(amount);
        appendSpace(itemData, 1);
    }

    return;
}

QString PrintManager::addItem(QString name, QString quantity, QString price, QString total)
{
    QString itemData;
    itemData = appendName(name);
    appendQuantity(itemData, quantity);
    appendPrice(itemData, price);
    appendAmount(itemData, total);
    itemData.append('\n');
    return itemData;
}

QVariantMap PrintManager::printBill(qint32 billNumber)
{
    qDebug() << Q_FUNC_INFO << "Invoked" << billNumber;
    QVariantMap result;
    bool status = false;
    QString errorMessage;

    QString printData;

    QSqlQuery query;

    QString name, quantityStr, priceStr, totalStr;
    qint32 quantity = 0, price = 0, isParentItem = 0, total = 0;
    float monetaryUnitFraction = SettingsModel::getInstance().monetaryUnitFraction();

    if (query.exec("SELECT Name, Quantity, Price, IsParentItem FROM BillItems "
                   "WHERE Bill = '"+ QString::number(billNumber) + "' ORDER BY LineNumber ASC"))
    {
        while (query.next())
        {
            name = query.value(0).toString();
            quantity = query.value(1).toInt();
            price = query.value(2).toInt();
            isParentItem = query.value(3).toInt();
            total = quantity * price;
            quantityStr = QString::number(quantity);
            priceStr = QString::number(price/monetaryUnitFraction);
            totalStr = QString::number(total/monetaryUnitFraction);
            printData.append(addItem(name, quantityStr, priceStr, totalStr));
        }
    }
    else
    {
        errorMessage = query.lastError().text();
    }

    time_t now = time(0);

    QString dt = ctime(&now);

    QString header, body, footer, htmlString;

        header = "<html>"
                          "<head>"
                          "<style>"
                          "table { border-collapse: collapse;"
                             " width: 100%; }"

                          "th, td {"
                              "padding: 8px;"
                              "text-align: left;"
                              "border-bottom: 1px solid #ddd; }"

                         " tr:hover { background-color:#f5f5f5; }"
                         "</style>"
                         "</script></tr>"
                         "</head>"
                         "<table>"
                         "<tr> <td></td> <td></td><h2>Hotal</h2></tr>"
                         "<tr>-----</tr>"
                         "<tr> <th> Bill Number</th><td></td><th> "+ QString::number(billNumber) + " </th> </tr>"
                         "<tr> <th> Date:</th><td></td><td>"+ dt +"</td> </tr>"
                         "<tr> </tr>"
                         "<tr> <th>Name</th> "
                               "<th>Quantity</th> "
                               "<th>Price</th> "
                               "<th>Total </th>"
                         "</tr>";
    htmlString.append(header);

    if (query.exec("SELECT Name, Quantity, Price, IsParentItem FROM BillItems "
                   "WHERE Bill = '"+ QString::number(billNumber) + "' ORDER BY LineNumber ASC"))
    {
        while (query.next())
        {
            name = query.value(0).toString();
            quantity = query.value(1).toInt();
            price = query.value(2).toInt();
            isParentItem = query.value(3).toInt();
            total = quantity * price;
            quantityStr = QString::number(quantity);
            priceStr = QString::number(price/monetaryUnitFraction);
            totalStr = QString::number(total/monetaryUnitFraction);

        body = "<tr> "
                     "<td>"+name+"</td> "
                     "<td>"+QString::number(quantity)+"</td> "
                     "<td>"+QString::number(price)+"</td> "
                     "<td>"+QString::number(total)+"</td> "
               "</tr>";
        htmlString.append(body);
        }
    }

//    QString totalAmount;
    qint32 totalAmount;
    QSqlQuery query1;
    query1.exec("SELECT Total FROM 'BILLHEADER' WHERE billNumber = " + QString::number(billNumber) + "");
    query1.next();
    totalAmount = query1.value(0).toInt();

    qint32 SGST,CGST;
    QString SGSTTotal,CGSTtotal,TotalAmt;
    QSqlQuery query2;
    query2.exec("SELECT SGST,CGST FROM 'TAX'");
    query2.next();
    SGST = query2.value(0).toInt();
    CGST = query2.value(1).toInt();

    SGSTTotal = QString::number((totalAmount*SGST)/monetaryUnitFraction);
    CGSTtotal = QString::number((totalAmount*CGST)/monetaryUnitFraction);

 //   TotalAmt = QString::number(CGST+totalAmount);

    footer = "<tr><th>Ticket Total</th> <td></td> <td></td> <th>"+ QString::number(totalAmount) + "</th> </tr>"
                  "<tr><td>TAX: CGST</td> <td></td> <td>"+QString::number(SGST)+"%</td> <th>"+ SGSTTotal +"</th> </tr>"
                  "<tr><td>TAX: SGST</td> <td></td> <td>"+QString::number(CGST)+"%</td> <th> "+ CGSTtotal +" </th> </tr>"
                  "<tr><th>Total</th> <td></td> <td></td> <th> "+ TotalAmt +"  </th> </tr>"
                  "</table></html>";
    htmlString.append(footer);

    QTextDocument doc;
    doc.setHtml(htmlString);

    QPrinter printer;
    printer.setPrinterName("printer name");
    QPrintDialog dialog(&printer);
    if(dialog.exec() == QDialog::Accepted)
        doc.print(&printer);


    qDebug() << Q_FUNC_INFO << "data to print " << printData;

    qDebug() << Q_FUNC_INFO << "Exits" << status << errorMessage;
    result.insert("status", status);
    result.insert("message", errorMessage);
    return result;
}
