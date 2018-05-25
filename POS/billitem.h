#ifndef BILLITEM_H
#define BILLITEM_H

#include <QObject>

class BillItem : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString itemCode READ itemCode WRITE setItemCode NOTIFY itemCodeChanged)
    Q_PROPERTY(QString unitCode READ unitCode WRITE setUnitCode NOTIFY unitCodeChanged)
    Q_PROPERTY(QString itemName READ itemName WRITE setItemName NOTIFY itemNameChanged)
    Q_PROPERTY(qint32 count READ count WRITE setCount NOTIFY countChanged)
    Q_PROPERTY(qint32 price READ price WRITE setPrice NOTIFY priceChanged)
    Q_PROPERTY(qint32 total READ total WRITE setTotal NOTIFY totalChanged)
    Q_PROPERTY(bool isParentItem READ isParentItem WRITE setIsParentItem NOTIFY parentStatusChanged)
    Q_PROPERTY(int lineNumber READ lineNumber WRITE setLineNumber NOTIFY lineNumberChanged)
    Q_PROPERTY(int parentLineNumber READ parentLineNumber WRITE setParentLineNumber NOTIFY parentLineNumberChanged)
    Q_PROPERTY(int status READ status WRITE setStatus NOTIFY statusChanged)


public:
    explicit BillItem(QObject *parent = 0);
//    BillItem(QString itemCode, QString unitCode, qint32 count, QObject *parent = 0);

    QString itemCode() const;
    QString unitCode() const;
    QString itemName() const;
    qint32 count() const;
    qint32 price() const;
    qint32 total() const;
    bool isParentItem() const;
    int lineNumber() const;
    int parentLineNumber() const;
    int status() const;

    void setItemCode(QString itemCode);
    void setUnitCode(QString unitCode);
    void setItemName(QString itemName);
    void setCount(qint32 count);
    void setPrice(qint32 price);
    void setTotal(qint32 total);
    void setIsParentItem(bool parent);
    void setLineNumber(int lineNumber);
    void setParentLineNumber(int parentLineNumber);
    void setStatus(int status);
signals:

    void itemCodeChanged(QString itemCode);
    void unitCodeChanged(QString unitcode);
    void itemNameChanged(QString itemName);
    void countChanged(qint32 count);
    void priceChanged(qint32 price);
    void totalChanged(qint32 total);
    void parentStatusChanged(bool parent);
    void lineNumberChanged(int lineNumber);
    void parentLineNumberChanged(int parentLineNumber);
    void statusChanged(int status);

public slots:

private:
    QString mItemCode;
    QString mUnitCode;
    QString mItemName;
    qint32 mCount;
    double mPrice;
    double mTotal;
    bool mIsParentItem;
    int mLineNumber;
    int mParentLineNumber;
    int mStatus;
};

#endif // BILLITEM_H
