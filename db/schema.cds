@cds.search: { PRODUCTSTANDARDID, PRODUCT, CATEGORY, MANUFACTURERNUMBER, SALESORG, CREATIONDATE, PRODUCTDESCRIPTION_EN, SIZEUOM }
@cds.persistence.exists
// entity ITEMMASTER 
// {
//     key PRODUCT                 : String(7)     @title: '{{ITEMMASTER.PRODUCT}}';
//     key SALESORG                : String(4)     @title: 'Sales Org';
//         CREATIONDATE            : String(8)     @title: 'Creation Date';
//         DIN                     : String(70)    @title: 'DIN';
//         GST_APPLICABLE          : String(1)     @title: 'GST Applicable';
//         LOT_CONTROL_YN          : String(1)     @title: 'Lot Control Y/N';
//         NARCOTIC_YN             : String(1)     @title: 'Narcotic Y/N';
//         CATEGORY                : String(20)    @title: 'Category' @Search.defaultSearchElement;
//         PRODUCTDESCRIPTION_EN   : String(40)    @title: 'Product Desc.';
//         PRODUCTDESCRIPTION_FR   : String(40)    @title: 'Special Handling';
//         PST_APPLICABLE          : String(1)     @title: 'PST Applicable';
//         REFRIGERATED            : String(1)     @title: 'Refridgerated';
//         UNITS_PER_CASE          : Decimal(5,0)  @title: 'Units Per Case';
//         SIZEUOM                 : String(80)    @title: 'Size';
//         PRODUCTSTANDARDID       : String(18)    @title: 'EAN/UPC/GTIN';
//         MANUFACTURERNUMBER      : String(10)    @title: 'Manufacturer #';
//         MFRNR_PART_NUMBER       : String(40)    @title: 'Product Code';
//         MFRNR_NAME              : String(35)    @title: 'Manufacturer Name'
// }
entity ITEMMASTER 
{
    key PRODUCT               : String(7)     @title: '{i18n>ITEMMASTER.PRODUCT}';
    key SALESORG              : String(4)     @title: '{i18n>ITEMMASTER.SALESORG}';
        CREATIONDATE          : String(8)     @title: '{i18n>ITEMMASTER.CREATIONDATE}';
        DIN                   : String(70)    @title: '{i18n>ITEMMASTER.DIN}';
        GST_APPLICABLE        : String(1)     @title: '{i18n>ITEMMASTER.GST_APPLICABLE}';
        LOT_CONTROL_YN        : String(1)     @title: '{i18n>ITEMMASTER.LOT_CONTROL_YN}';
        NARCOTIC_YN           : String(1)     @title: '{i18n>ITEMMASTER.NARCOTIC_YN}';
        CATEGORY              : String(20)    @title: '{i18n>ITEMMASTER.CATEGORY}' @Search.defaultSearchElement;
        PRODUCTDESCRIPTION_EN : String(40)    @title: '{i18n>ITEMMASTER.PRODUCTDESCRIPTION_EN}';
        PRODUCTDESCRIPTION_FR : String(40)    @title: '{i18n>ITEMMASTER.PRODUCTDESCRIPTION_FR}';
        PST_APPLICABLE        : String(1)     @title: '{i18n>ITEMMASTER.PST_APPLICABLE}';
        REFRIGERATED          : String(1)     @title: '{i18n>ITEMMASTER.REFRIGERATED}';
        UNITS_PER_CASE        : Decimal(5,0)  @title: '{i18n>ITEMMASTER.UNITS_PER_CASE}';
        SIZEUOM               : String(80)    @title: '{i18n>ITEMMASTER.SIZEUOM}';
        PRODUCTSTANDARDID     : String(18)    @title: '{i18n>ITEMMASTER.PRODUCTSTANDARDID}';
        MANUFACTURERNUMBER    : String(10)    @title: '{i18n>ITEMMASTER.MANUFACTURERNUMBER}';
        MFRNR_PART_NUMBER     : String(40)    @title: '{i18n>ITEMMASTER.MFRNR_PART_NUMBER}';
        MFRNR_NAME            : String(35)    @title: '{i18n>ITEMMASTER.MFRNR_NAME}';
        STPRS                 : Decimal(11,2) @title: '{i18n>ITEMMASTER.STPRS}';
}



define view ITEMMASPD as
    select from ITEMMASTER distinct {
        key PRODUCTDESCRIPTION_EN,
        MANUFACTURERNUMBER
};
define view ITEMMASP as
    select from ITEMMASTER distinct {
        key PRODUCT,
        MANUFACTURERNUMBER 
};

define view ITEMMASMFRNRNAME as
    select from ITEMMASTER distinct {
        key MFRNR_NAME,
        MANUFACTURERNUMBER @UI.Hidden
};
define view ITEMMASPSID as
    select from ITEMMASTER distinct {
        key MFRNR_PART_NUMBER,
        MANUFACTURERNUMBER @UI.Hidden
};
define view ITEMMASCATEGORY as
    select from ITEMMASTER distinct {
        key CATEGORY,
        MANUFACTURERNUMBER @UI.Hidden
};
define view ITEMMASMFRNR as
    select from ITEMMASTER distinct {
        key MANUFACTURERNUMBER
};
define view ITEMMASSALESORG as
    select from ITEMMASTER distinct {
        key SALESORG,
        MANUFACTURERNUMBER @UI.Hidden
};
@cds.search: { SKU_MATNR, PRODUCT_CODE, SIZE, MANUFACTURER_MFRPN, PRODUCT_DESCRIPTION, VKBUR }
@cds.persistence.exists
entity INVENTORYSTATUS 
{
    key SKU_MATNR            : String(7)      @title: '{i18n>INVENTORYSTATUS.SKU_MATNR}';
        PRODUCT_CODE         : String(40)     @title: '{i18n>INVENTORYSTATUS.PRODUCT_CODE}';
        SIZE                 : String(70)     @title: '{i18n>INVENTORYSTATUS.SIZE}';
        PRODUCT_DESCRIPTION  : String(40)     @title: '{i18n>INVENTORYSTATUS.PRODUCT_DESCRIPTION}';
        OPEN_STOCK           : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.OPEN_STOCK}';
        QUARANTINE           : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.QUARANTINE}';
        DAMAGE_DESTRUCTION   : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.DAMAGE_DESTRUCTION}';
        RETAINS              : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.RETAINS}';
        QUALITY_HOLD         : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.QUALITY_HOLD}';
        RETURNS_CAL          : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.RETURNS_CAL}';
        RECALLS              : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.RECALLS}';
        INVENTORY_HOLD       : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.INVENTORY_HOLD}';
        RELABEL_QTY          : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.RELABEL_QTY}';
        SAMPLE_QTY           : Decimal(38,2)        @title: '{i18n>INVENTORYSTATUS.SAMPLE_QTY}';
        UNIT                 : String(3)      @title: '{i18n>INVENTORYSTATUS.UNIT}';
    key VKBUR                : String(4)      @title: '{i18n>INVENTORYSTATUS.VKBUR}';
        MANUFACTURER_MFRNR   : String(40)     @title: '{i18n>INVENTORYSTATUS.MANUFACTURER_MFRNR}';
        MFRNR_NAME           : String(35)     @title: '{i18n>INVENTORYSTATUS.MFRNR_NAME}';
    key PLANT                : String(4)      @title: '{i18n>INVENTORYSTATUS.PLANT}';
        PLANT_NAME           : String(30)     @title: '{i18n>INVENTORYSTATUS.PLANT_NAME}';

}
define view INVSTATUSPRODUCTCODE as
    select from INVENTORYSTATUS distinct {
        key PRODUCT_CODE,
        MANUFACTURER_MFRNR
    };
define view INVSTATUSMFRNR as
    select from INVENTORYSTATUS distinct {
        key MANUFACTURER_MFRNR
};

define view INVSTATUSPLANTNAME as
    select from INVENTORYSTATUS distinct {
        key PLANT_NAME,
        MANUFACTURER_MFRNR
};
define view INVSTATUSMFRNRNAME as
    select from INVENTORYSTATUS distinct {
        key MFRNR_NAME,
        MANUFACTURER_MFRNR 
};
define view INVSTATUSVKBUR as
    select from INVENTORYSTATUS distinct {
        key VKBUR,
        MANUFACTURER_MFRNR
};
@cds.search: { MATNR, MAKTX, POSTING_DATE, CHARG, WAREHOUSE_STATUS, KUNNR, CUSTOMER_NAME, INV_MATDOC_ITEM, WERKS, LGORT, MFRNR, NAME1_PLANT }
@cds.persistence.exists
entity INVENTORYAUDITTRAIL 
{
    key MATNR               : String(7)     @title: '{i18n>INVENTORYAUDITTRAIL.MATNR}';
        MAKTX               : String(40)    @title: '{i18n>INVENTORYAUDITTRAIL.MAKTX}';
        MENGE               : Decimal(13,0) @title: '{i18n>INVENTORYAUDITTRAIL.MENGE}';
    key CHARG               : String(10)    @title: '{i18n>INVENTORYAUDITTRAIL.CHARG}';
    key KUNNR               : String(10)    @title: '{i18n>INVENTORYAUDITTRAIL.KUNNR}';
        CUSTOMER_NAME       : String(35)    @title: '{i18n>INVENTORYAUDITTRAIL.CUSTOMER_NAME}';
        MFRNR               : String(10)    @title: '{i18n>INVENTORYAUDITTRAIL.MFRNR}';
    key WAREHOUSE_STATUS    : String(40)    @title: '{i18n>INVENTORYAUDITTRAIL.WAREHOUSE_STATUS}';
    key WERKS               : String(4)     @title: '{i18n>INVENTORYAUDITTRAIL.WERKS}';
        LGORT               : String(4)     @title: '{i18n>INVENTORYAUDITTRAIL.LGORT}';
        MFRNR_PROD_CODE     : String(40)    @title: '{i18n>INVENTORYAUDITTRAIL.MFRNR_PROD_CODE}';
        MEINS               : String(3)     @title: '{i18n>INVENTORYAUDITTRAIL.MEINS}';
        PLANT_NAME         : String(30)     @title: '{i18n>INVENTORYAUDITTRAIL.NAME1_PLANT}';
        TRAN_TYPE           : String(40)    @title: '{i18n>INVENTORYAUDITTRAIL.TRAN_TYPE}';
    key INV_MATDOC_ITEM     : String(15)    @title: '{i18n>INVENTORYAUDITTRAIL.INV_MATDOC_ITEM}';
        SHELF_LIFE_EXP_DT   : String(8)     @title: '{i18n>INVENTORYAUDITTRAIL.SHELF_LIFE_EXP_DT}';
        CURRENT             : String(3)     @title: '{i18n>INVENTORYAUDITTRAIL.CURRENT}';
        DIN                 : String(8)     @title: '{i18n>INVENTORYAUDITTRAIL.DIN}';
        POSTING_DATE        : Date          @title: '{i18n>INVENTORYAUDITTRAIL.POSTING_DATE}';
        RBTXT               : String(20)    @title: '{i18n>INVENTORYAUDITTRAIL.RBTXT}';
        TBTXT               : String(60)    @title: '{i18n>INVENTORYAUDITTRAIL.TBTXT}';
        MFRNR_NAME          : String(35)    @title: '{i18n>INVENTORYAUDITTRAIL.MFRNR_NAME}';
        SALES_ORG           : String(4)     @title: '{i18n>INVENTORYAUDITTRAIL.SALES_ORG}';
        NARCOTICS_IND       : String(3)     @title: '{i18n>INVENTORYAUDITTRAIL.NARCOTICS_IND}';
        
}

define view IATPLANTNAME as
    select from INVENTORYAUDITTRAIL distinct {
        key PLANT_NAME,
        MFRNR 
};
define view IATTRANTYPE as
    select from INVENTORYAUDITTRAIL distinct {
        key TRAN_TYPE,
        MFRNR @UI.Hidden
};

define view IATPRODUCTCODE as
    select from INVENTORYAUDITTRAIL distinct {
        key MFRNR_PROD_CODE,
        MFRNR @UI.Hidden
};

define view IATLOT as
    select from INVENTORYAUDITTRAIL distinct {
        key CHARG,
        MFRNR @UI.Hidden
};
define view IATSALESORG as
    select from INVENTORYAUDITTRAIL distinct {
        key SALES_ORG,
        MFRNR @UI.Hidden
};

define view IATWAREHOUSE as
    select from INVENTORYAUDITTRAIL distinct {
        key WAREHOUSE_STATUS,
        MFRNR @UI.Hidden
};

define view IATCUSTSUPP as
    select from INVENTORYAUDITTRAIL distinct {
        key KUNNR,
        MFRNR @UI.Hidden
};
define view IATCUSTSUPPNAME as
    select from INVENTORYAUDITTRAIL distinct {
        key CUSTOMER_NAME,
        MFRNR @UI.Hidden
};
define view IATMFRNR as
    select from INVENTORYAUDITTRAIL distinct {
        key MFRNR
};
define view IATMFRNRNAME as
    select from INVENTORYAUDITTRAIL distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};

@cds.search: { BILL_TO, NAME1, VKORG, BKTXT, SGTXT, BUDAT, VBELN, FKDAT, BLART, AUBEL, SHIP_TO, BUKRS, MFRNR, BELNR, PRCTR, GJAHR, BSTKD }
@cds.persistence.exists
entity CASHJOURNAL 
{
        BILL_TO             : String(10)        @title : '{i18n>CASHJOURNAL.BILL_TO}';
        SHIP_TO             : String(10)        @title : '{i18n>CASHJOURNAL.SHIP_TO}';
    key VKORG               : String(4)         @title : '{i18n>CASHJOURNAL.VKORG}';
        BKTXT               : String(25)        @title : '{i18n>CASHJOURNAL.BKTXT}';
        SGTXT               : String(50)        @title : '{i18n>CASHJOURNAL.SGTXT}';
        CAL_DISCOUNT        : Decimal(23,2)     @title : '{i18n>CASHJOURNAL.CAL_DISCOUNT}';
        CAL_CASH_RECEIVED   : Decimal(23,2)     @title : '{i18n>CASHJOURNAL.CAL_CASH_RECEIVED}';
        NAME1               : String(35)        @title : '{i18n>CASHJOURNAL.NAME1}';
        BUDAT               : String(8)         @title : '{i18n>CASHJOURNAL.BUDAT}';
    key VBELN               : String(10)        @title : '{i18n>CASHJOURNAL.VBELN}';
        NETWR               : Decimal(20,2)     @title : '{i18n>CASHJOURNAL.NETWR}';
        FKDAT               : String(8)         @title : '{i18n>CASHJOURNAL.FKDAT}';
        BLART               : String(2)         @title : '{i18n>CASHJOURNAL.BLART}';
        MFRNR               : String(10)        @title : '{i18n>CASHJOURNAL.MFRNR}';
    key BUKRS               : String(4)         @title : '{i18n>CASHJOURNAL.BUKRS}';
    key BELNR               : String(10)        @title : '{i18n>CASHJOURNAL.BELNR}';
    key GJAHR               : String(4)         @title : '{i18n>CASHJOURNAL.GJAHR}';
        BSTKD               : String(35)        @title : '{i18n>CASHJOURNAL.BSTKD}';
        PRCTR               : String(10)        @title : '{i18n>CASHJOURNAL.PRCTR}';
    key AUBEL               : String(10)        @title : '{i18n>CASHJOURNAL.AUBEL}';
        BLDAT               : String(8)         @title : '{i18n>CASHJOURNAL.BLDAT}';
        CURRENT             : String(3)         @title : '{i18n>CASHJOURNAL.CURRENT}';
        CAL_INV_AMOUNT      : Decimal(23,2)     @title : '{i18n>CASHJOURNAL.CAL_INV_AMOUNT}';
        MFRNR_NAME          : String(35)        @title : '{i18n>CASHJOURNAL.MFRNR_NAME}';
        VTEXT_ZTERM         : String(30)        @title : '{i18n>CASHJOURNAL.VTEXT_ZTERM}';
}
define view BLARTS as
    select from CASHJOURNAL distinct {
        key BLART,
        MFRNR @UI.Hidden
};
define view BILL_TOS as
    select from CASHJOURNAL distinct {
        key BILL_TO,
        MFRNR @UI.Hidden
};
define view BILL_TONAME as
    select from CASHJOURNAL distinct {
        key NAME1,
        MFRNR @UI.Hidden
};
define view FINCJMFRNR as
    select from CASHJOURNAL distinct {
        key MFRNR
};
define view FINCJMFRNRNAME as
    select from CASHJOURNAL distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view FINCJPRCTR as
    select from CASHJOURNAL distinct {
        key PRCTR,
        MFRNR @UI.Hidden
};
define view FINCJSALESORG as
    select from CASHJOURNAL distinct {
        key VKORG,
        MFRNR @UI.Hidden
};


@cds.search: { MATNR, MFRPN, MAKTX, SIZE, CHARG, WAREHOUSE_STATUS, EAN11, MFRNR, VKORG, LGNUM }
@cds.persistence.exists
entity INVENTORYSNAPSHOT 
{
    key MATNR               : String(7)     @title: '{i18n>INVENTORYSNAPSHOT.MATNR}';
    key WAREHOUSE_STATUS    : String(30)    @title: '{i18n>INVENTORYSNAPSHOT.WAREHOUSE_STATUS}';
        EAN11               : String(18)    @title: '{i18n>INVENTORYSNAPSHOT.EAN11}';
        ON_HAND             : Decimal(36,2) @title: '{i18n>INVENTORYSNAPSHOT.ON_HAND}';
        MFRPN               : String(40)    @title: '{i18n>INVENTORYSNAPSHOT.MFRPN}';
        DAYS_UNTIL_EXPIRY   : Integer       @title: '{i18n>INVENTORYSNAPSHOT.DAYS_UNTIL_EXPIRY}';
    key REPORT_DATE         : Date          @title: '{i18n>INVENTORYSNAPSHOT.REPORT_DATE}';
    key VKORG               : String(4)     @title: '{i18n>INVENTORYSNAPSHOT.VKORG}';
    key LGNUM               : String(4)     @title: '{i18n>INVENTORYSNAPSHOT.LGNUM}';
        UNIT                : String(3)     @title: '{i18n>INVENTORYSNAPSHOT.UNIT}';
        MFRNR               : String(10)    @title: '{i18n>INVENTORYSNAPSHOT.MFRNR}';
        SIZE                : String(70)    @title: '{i18n>INVENTORYSNAPSHOT.SIZE}';
        MAKTX               : String(40)    @title: '{i18n>INVENTORYSNAPSHOT.MAKTX}';
    key CHARG               : String(10)    @title: '{i18n>INVENTORYSNAPSHOT.CHARG}';
    key VFDAT               : String(8)     @title: '{i18n>INVENTORYSNAPSHOT.VFDAT}';
        DIN                 : String(100)   @title: '{i18n>INVENTORYSNAPSHOT.DIN}';
        RBTXT               : String(20)    @title: '{i18n>INVENTORYSNAPSHOT.RBTXT}';
        TBTXT               : String(60)    @title: '{i18n>INVENTORYSNAPSHOT.TBTXT}';
        CURRENT             : String(3)     @title: '{i18n>INVENTORYSNAPSHOT.CURRENT}';
        MFRNR_NAME          : String(35)    @title: '{i18n>INVENTORYSNAPSHOT.MFRNR_NAME}';
    key WERKS               : String(4)     @title: '{i18n>INVENTORYSNAPSHOT.PLANT}';
        PLANT_NAME          : String(30)    @title: '{i18n>INVENTORYSNAPSHOT.PLANT_NAME}';

}
define view INVSNAPPLANTNAME as
    select from INVENTORYSNAPSHOT distinct {
        key PLANT_NAME,
        MFRNR @UI.Hidden
};
define view INVSNAPPROD as
    select from INVENTORYSNAPSHOT distinct {
        key MFRPN,
        MFRNR @UI.Hidden
};
define view INVSNAPPRODSKU as
    select from INVENTORYSNAPSHOT distinct {
        key MATNR,
        MFRNR @UI.Hidden
};
define view INVSNAPPRODDESC as
    select from INVENTORYSNAPSHOT distinct {
        key MAKTX,
        MFRNR @UI.Hidden
};
define view INVSNAPLOT as
    select from INVENTORYSNAPSHOT distinct {
        key CHARG,
        MFRNR @UI.Hidden
};
define view INVSNAPWARESTAT as
    select from INVENTORYSNAPSHOT distinct {
        key WAREHOUSE_STATUS,
        MFRNR @UI.Hidden
};
define view INVSNAPMFRNR as
    select from INVENTORYSNAPSHOT distinct {
        key MFRNR
};
define view INVSNAPMFRNRNAME as
    select from INVENTORYSNAPSHOT distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view INVSNAPVKORG as
    select from INVENTORYSNAPSHOT distinct {
        key VKORG,
        MFRNR @UI.Hidden
};
@cds.search: { MATNR, WAREHOUSE_STATUS, EAN11, MFRPN, LGNUM, MFRNR, MAKTX, CHARG, PLANT, DIN, VKBUR }
@cds.persistence.exists
entity INVENTORYBYLOT 
{
        
    key MATNR                       : String(7)         @title : '{i18n>INVENTORYBYLOT.MATNR}';
    key WAREHOUSE_STATUS            : String(4)         @title : '{i18n>INVENTORYBYLOT.WAREHOUSE_STATUS}';
        EAN11                       : String(18)        @title : '{i18n>INVENTORYBYLOT.EAN11}';
        ON_HAND                     : Decimal(38,2)     @title : '{i18n>INVENTORYBYLOT.ON_HAND}';
        MFRPN                       : String(40)        @title : '{i18n>INVENTORYBYLOT.MFRPN}';
        DAYS_UNTIL_EXPIRY           : Integer           @title : '{i18n>INVENTORYBYLOT.DAYS_UNTIL_EXPIRY}';
    key LGNUM                       : String(4)         @title : '{i18n>INVENTORYBYLOT.LGNUM}';
        UNIT                        : String(3)         @title : '{i18n>INVENTORYBYLOT.UNIT}';
        MFRNR                       : String(10)        @title : '{i18n>INVENTORYBYLOT.MFRNR}';
        MFRNR_NAME                  : String(35)        @title : '{i18n>INVENTORYBYLOT.MFRNR_NAME}';
        SIZE                        : String(70)        @title : '{i18n>INVENTORYBYLOT.SIZE}';
        MAKTX                       : String(40)        @title : '{i18n>INVENTORYBYLOT.MAKTX}';
    key CHARG                       : String(10)        @title : '{i18n>INVENTORYBYLOT.CHARG}';
    key VFDAT                       : String(8)         @title : '{i18n>INVENTORYBYLOT.VFDAT}';
        DIN                         : String(100)       @title : '{i18n>INVENTORYBYLOT.DIN}';
    key PLANT                       : String(18)        @title : '{i18n>INVENTORYBYLOT.PLANT}';
        PLANT_NAME                  : String(30)        @title : '{i18n>INVENTORYBYLOT.PLANT_NAME}';
    key VKBUR                       : String(4)         @title : '{i18n>INVENTORYBYLOT.VKBUR}';
}

define view INVBYLOTPLANTNAME as
    select from INVENTORYBYLOT distinct {
        key PLANT_NAME,
        MFRNR @UI.Hidden
};
define view INVBYLOTPRODUCTCODE as
    select from INVENTORYBYLOT distinct {
        key MFRPN,
        MFRNR @UI.Hidden
};
define view INVBYLOTLOT as
    select from INVENTORYBYLOT distinct {
        key CHARG,
        MFRNR @UI.Hidden
};

define view INVBYLOTWAREHOUSE as
    select from INVENTORYBYLOT distinct {
        key WAREHOUSE_STATUS,
        MFRNR @UI.Hidden
};
define view INVBYLOTMFRNR as
    select from INVENTORYBYLOT distinct {
        key MFRNR
};
define view INVBYLOTMFRNRNAME as
    select from INVENTORYBYLOT distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view INVBYLOTVKBUR as
    select from INVENTORYBYLOT distinct {
        key VKBUR,
        MFRNR @UI.Hidden
};

@cds.search: { VKORG, BILL_TO, NAME1, BSTKD, BELNR, ZTERM, STORE_SHIP_TO, BLART, MFRNR }
@cds.persistence.exists
entity OPENAR 
{
        CAL_1_30            : Decimal(24,2)     @title : '{i18n>OPENAR.CAL_1_30}';
        CAL_31_60           : Decimal(24,2)     @title : '{i18n>OPENAR.CAL_31_60}';
        CAL_61_90           : Decimal(24,2)     @title : '{i18n>OPENAR.CAL_61_90}';
        CAL_AGE             : Integer           @title : '{i18n>OPENAR.CAL_AGE}';
        TSL                 : Decimal(23,2)     @title : '{i18n>OPENAR.TSL}';
    key VKORG               : String(4)         @title : '{i18n>OPENAR.VKORG}';
        CREDIT_LIMIT        : Decimal(15,2)     @title : '{i18n>OPENAR.CREDIT_LIMIT}';
        CAL_CURRENT         : Decimal(23,2)     @title : '{i18n>OPENAR.CAL_CURRENT}';
    key BILL_TO             : String(10)        @title : '{i18n>OPENAR.BILL_TO}';
        NAME1               : String(35)        @title : '{i18n>OPENAR.NAME1}';
        BSTKD               : String(35)        @title : '{i18n>OPENAR.BSTKD}';
        NETDT               : String(8)         @title : '{i18n>OPENAR.NETDT}';
    key BELNR               : String(10)        @title : '{i18n>OPENAR.BELNR}';
        FKDAT               : String(8)         @title : '{i18n>OPENAR.FKDAT}';
        ZTERM               : String(4)         @title : '{i18n>OPENAR.ZTERM}';
        NETWR               : Decimal(23,2)     @title : '{i18n>OPENAR.NETWR}';
        CAL_OVER_90         : Decimal(24,2)     @title : '{i18n>OPENAR.CAL_OVER_90}';
    key STORE_SHIP_TO       : String(10)        @title : '{i18n>OPENAR.STORE_SHIP_TO}';
        BLART               : String(2)         @title : '{i18n>OPENAR.BLART}';
        MFRNR               : String(10)        @title : '{i18n>OPENAR.MFRNR}';
        MFRNR_NAME          : String(10)        @title : '{i18n>OPENAR.MFRNR_NAME}';
        VTEXT_ZTERM         : String(30)        @title : '{i18n>OPENAR.VTEXT_ZTERM}';
}
define view OPENARCUSTOMER as
    select from OPENAR distinct {
        key NAME1,
        MFRNR @UI.Hidden
};
define view OPENARCUSTOMERID as
    select from OPENAR distinct {
        key BILL_TO,
        MFRNR @UI.Hidden
};
define view OPENARMFRNR as
    select from OPENAR distinct {
        key MFRNR
};
define view OPENARMFRNRNAME as
    select from OPENAR distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view OPENARSALESORG as
    select from OPENAR distinct {
        key VKORG,
        MFRNR @UI.Hidden
};
@cds.search: { PLANT, LGNUM, MATNR, MAKTX, MFRPN,VKBUR,MFRNR }
@cds.persistence.exists
entity INVENTORYVALUATION 
{
    key PLANT                       : String(4)         @title : '{i18n>INVENTORYVALUATION.PLANT}';
    key LGNUM                       : String(4)         @title : '{i18n>INVENTORYVALUATION.LGNUM}';
    key MATNR                       : String(7)         @title : '{i18n>INVENTORYVALUATION.MATNR}';
        MAKTX                       : String(40)        @title : '{i18n>INVENTORYVALUATION.MAKTX}';
        MFRPN                       : String(40)        @title : '{i18n>INVENTORYVALUATION.MFRPN}';
        DIN                         : String(100)       @title : '{i18n>INVENTORYVALUATION.DIN}';
        SIZE                        : String(70)        @title : '{i18n>INVENTORYVALUATION.SIZE}';
    key VKBUR                       : String(10)        @title : '{i18n>INVENTORYVALUATION.VKBUR}';
        MFRNR                       : String(10)        @title : '{i18n>INVENTORYVALUATION.MFRNR}';
        MFRNR_NAME                  : String(35)        @title : '{i18n>INVENTORYVALUATION.MFRNR_NAME}';
        WAERS                       : String(5)         @title : '{i18n>INVENTORYVALUATION.WAERS}';
        UNIT_PRICE                  : Decimal(11,2)     @title : '{i18n>INVENTORYVALUATION.UNIT_PRICE}';
        TOTAL_COST                  : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.TOTAL_COST}';
        AVAILABLE_COST              : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.AVAILABLE_COST}';
        QUARANTINE_COST             : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.QUARANTINE_COST}';
        RETAINS_COST                : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.RETAINS_COST}';
        QUALITY_HOLD_COST           : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.QUALITY_HOLD_COST}';
        RETURNS_COST                : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.RETURNS_COST}';
        RECALL_COST                 : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.RECALL_COST}';
        INVENTORY_HOLD_COST         : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.INVENTORY_HOLD_COST}';
        RELABEL_COST                : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.RELABEL_COST}';
        DAMAGE_DESTRUCTION_COST     : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.DAMAGE_DESTRUCTION_COST}';
        SAMPLE_COST                 : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.SAMPLE_COST}';
        UNIT                        : String(3)         @title : '{i18n>INVENTORYVALUATION.UNIT}';
        QUAN                        : Decimal(38,2)     @title : '{i18n>INVENTORYVALUATION.QUAN}'; 
        PLANT_NAME                  : String(30)        @title : '{i18n>INVENTORYVALUATION.PLANT_NAME}';  
}

define view INVVALPLANTNAME as
    select from INVENTORYVALUATION distinct {
        key PLANT_NAME,
        MFRNR @UI.Hidden
};
define view INVVALPROD as
    select from INVENTORYVALUATION distinct {
        key MFRPN,
        MFRNR @UI.Hidden
};
define view INVVALPRODDESC as
    select from INVENTORYVALUATION distinct {
        key MAKTX,
        MFRNR @UI.Hidden
};
define view INVVALPRODSKU as
    select from INVENTORYVALUATION distinct {
        key MATNR,
        MFRNR @UI.Hidden
};
define view INVVALMFRNR as
    select from INVENTORYVALUATION distinct {
        key MFRNR
};
define view INVVALMFRNRNAME as
    select from INVENTORYVALUATION distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view INVVALVKBUR as
    select from INVENTORYVALUATION distinct {
        key VKBUR,
        MFRNR @UI.Hidden
};

// Invoice History
// Security attributes to match: ??
@cds.search: { BKTXT,
LFDAT,
CAL_GST,
CAL_PST,
ORT01,
MFRNR,
VKORG,
SHIP_TO,
TSL_AMOUNT,
NAME1,
BSTKD,
PSTLZ,
REGIO,
AUBEL,
TRACKN,
BILL_TO,
WAERK,
VBELN, 
CURRENT,
ORDER_TYPE,
FKDAT,
PATIENT_ID,
AUGRU_AUFT,
PLANT_NAME,
WERKS,
BEZEI,
MFRNR_NAME,
MFRNR_7CH }
@cds.persistence.exists
entity INVOICEHISTORY
{
        BKTXT        : String(25)    @title : '{i18n>INVOICEHISTORY.BKTXT}';
        LFDAT        : String(8)     @title : '{i18n>INVOICEHISTORY.LFDAT}';
        CAL_GST      : Decimal(23,2) @title : '{i18n>INVOICEHISTORY.CAL_GST}';
        CAL_PST      : Decimal(23,2) @title : '{i18n>INVOICEHISTORY.CAL_PST}';
        ORT01        : String(35)    @title : '{i18n>INVOICEHISTORY.ORT01}';
    key MFRNR        : String(10)    @title : '{i18n>INVOICEHISTORY.MFRNR}';
    key VKORG        : String(4)     @title : '{i18n>INVOICEHISTORY.VKORG}';
    key SHIP_TO      : String(10)    @title : '{i18n>INVOICEHISTORY.SHIP_TO}';
        TSL_AMOUNT   : Decimal(23,2) @title : '{i18n>INVOICEHISTORY.TSL_AMOUNT}';
        NAME1        : String(35)    @title : '{i18n>INVOICEHISTORY.NAME1}';
        BSTKD        : String(35)    @title : '{i18n>INVOICEHISTORY.BSTKD}';
        PSTLZ        : String(10)    @title : '{i18n>INVOICEHISTORY.PSTLZ}';
        REGIO        : String(3)     @title : '{i18n>INVOICEHISTORY.REGIO}';
    key AUBEL        : String(10)    @title : '{i18n>INVOICEHISTORY.AUBEL}';
        TRACKN       : String(35)    @title : '{i18n>INVOICEHISTORY.TRACKN}';
    key BILL_TO      : String(10)    @title : '{i18n>INVOICEHISTORY.BILL_TO}';
        WAERK        : String(5)     @title : '{i18n>INVOICEHISTORY.WAERK}';
    key VBELN        : String(10)    @title : '{i18n>INVOICEHISTORY.VBELN}';
        CURRENT      : String(1)     @title : '{i18n>INVOICEHISTORY.CURRENT}';
        ORDER_TYPE   : String(20)    @title : '{i18n>INVOICEHISTORY.ORDER_TYPE}';
        FKDAT        : String(8)     @title : '{i18n>INVOICEHISTORY.FKDAT}';
        PATIENT_ID   : String(15)    @title : '{i18n>INVOICEHISTORY.PATIENT_ID}';
        AUGRU_AUFT   : String(3)     @title : '{i18n>INVOICEHISTORY.AUGRU_AUFT}';
        PLANT_NAME   : String(30)    @title : '{i18n>INVOICEHISTORY.PLANT_NAME}';
        WERKS        : String(4)     @title : '{i18n>INVOICEHISTORY.WERKS}';
        BEZEI        : String(40)    @title : '{i18n>INVOICEHISTORY.BEZEI}';
        MFRNR_NAME   : String(35)    @title : '{i18n>INVOICEHISTORY.MFRNR_NAME}';
        
        
        
}
define view IHPLANTNAME as
    select from INVOICEHISTORY distinct {
        key PLANT_NAME,
        MFRNR @UI.Hidden
};
// Invoice History Customer filter
define view IHCUSTOMER as
    select from INVOICEHISTORY distinct {
        key NAME1,
        MFRNR @UI.Hidden
};
// Invoice History Ship To filter
define view IHSHIPTO as
    select from INVOICEHISTORY distinct {
        key SHIP_TO,
        MFRNR @UI.Hidden
};
define view IHBEZEI as
    select from INVOICEHISTORY distinct {
        key BEZEI,
        MFRNR @UI.Hidden
};
//Invoice History Invoice # filter
define view IHINVOICE as
    select from INVOICEHISTORY distinct {
        key VBELN,
        MFRNR @UI.Hidden
};
// Invoice History Purchase Order filter
define view IHPO as
    select from INVOICEHISTORY distinct {
        key BSTKD,
        MFRNR @UI.Hidden
};
// Invoice History Type filter
define view IHTYPE as
    select from INVOICEHISTORY distinct {
        key ORDER_TYPE,
        MFRNR @UI.Hidden
};
// Invoice History Province filter
define view IHPROVINCE as
    select from INVOICEHISTORY distinct {
        key REGIO,
        MFRNR @UI.Hidden
};
define view IHMFRNR as
    select from INVOICEHISTORY distinct {
        key MFRNR
};

define view IHMFRNRNAME as
    select from INVOICEHISTORY distinct {
        key MFRNR_NAME,
         MFRNR @UI.Hidden
};
        
define view IHSALESORG as
    select from INVOICEHISTORY distinct {
        key VKORG,
        MFRNR @UI.Hidden
};

// Sales by Product/Customer
@cds.search: { 
    INVOICE_CREDIT_VBELN, 
    PURCHASE_ORDER_BSTKD, 
    SKU_MATNR, 
    PRODUCT_DESCRIPTION_MAKTX, 
    LOT_CHARG, 
    TYPE_FKART,
    BILL_TO_KUNRE_ANA,
    SHIP_TO_KUNWE_ANA,
    BILL_TO_NAME,
    SHIP_TO_NAME,
    ADDRESS_1,
    ADDRESS_2,
    POSTAL_CODE_PSTLZ,
    CITY_ORT01,
    PROVINCE_REGIO,
    SPECIAL_HANDLING, 
    UPC_EAN11, 
    WAREHOUSE, 
    TRACKING_TRACKN, 
    COMMENT, 
    CURRENT,
    CO_VKORG
}
@cds.persistence.exists
entity SALESBYCURRENT
{
    ADDRESS_1               : String(35)    @title : '{i18n>SALESBYCURRENT.ADDRESS_1}';
    ADDRESS_2               : String(40)    @title : '{i18n>SALESBYCURRENT.ADDRESS_2}';
    AMOUNT_NETWR            : Decimal(20,2) @title : '{i18n>SALESBYCURRENT.AMOUNT_NETWR}';
    AUGRU_AUFT              : String(3)     @title : '{i18n>SALESBYCURRENT.AUGRU_AUFT}';
    BILL_TO_KUNRE_ANA       : String(10)    @title : '{i18n>SALESBYCURRENT.BILL_TO_KUNRE_ANA}';
    BILL_TO_NAME            : String(70)    @title : '{i18n>SALESBYCURRENT.BILL_TO_NAME}';
    CITY_ORT01              : String(35)    @title : '{i18n>SALESBYCURRENT.CITY_ORT01}';
key CO_VKORG                : String(4)     @title : '{i18n>SALESBYCURRENT.CO_VKORG}';
    COMMENT                 : String(13)    @title : '{i18n>SALESBYCURRENT.COMMENT}';
    CURRENT                 : String(3)     @title : '{i18n>SALESBYCURRENT.CURRENT}';
    DELEVERY_DATE_VDATU     : String(8)     @title : '{i18n>SALESBYCURRENT.DELEVERY_DATE_VDATU}'; 
    EXPIRY_DATE_VFDAT       : String(8)     @title : '{i18n>SALESBYCURRENT.EXPIRY_DATE_VFDAT}';
key INVOICE_CREDIT_VBELN    : String(10)    @title : '{i18n>SALESBYCURRENT.INVOICE_CREDIT_VBELN}';
    INVOICE_DATE_FKDAT      : String(8)     @title : '{i18n>SALESBYCURRENT.INVOICE_DATE_FKDAT}';
key LOT_CHARG               : String(10)    @title : '{i18n>SALESBYCURRENT.LOT_CHARG}';
    MFRNR                   : String(10)    @title : '{i18n>SALESBYCURRENT.MFRNR}';
    MFRPN                   : String(40)    @title : '{i18n>SALESBYCURRENT.MFRPN}';
    PATIENT_ID              : String(20)    @title : '{i18n>SALESBYCURRENT.PATIENT_ID}';
    POSTAL_CODE_PSTLZ       : String(10)    @title : '{i18n>SALESBYCURRENT.POSTAL_CODE_PSTLZ}';
    PRODUCT_DESCRIPTION_MAKTX : String(40)  @title : '{i18n>SALESBYCURRENT.PRODUCT_DESCRIPTION_MAKTX}'; 
    PROVINCE_REGIO          : String(3)     @title : '{i18n>SALESBYCURRENT.PROVINCE_REGIO}';
    PURCHASE_ORDER_BSTKD    : String(35)    @title : '{i18n>SALESBYCURRENT.PURCHASE_ORDER_BSTKD}';
    QUANTITY_FKIMG          : Decimal(13,3) @title : '{i18n>SALESBYCURRENT.QUANTITY_FKIMG}';
    RBTXT                   : String(20)    @title : '{i18n>SALESBYCURRENT.RBTXT}';
    SHIP_TO_KUNWE_ANA       : String(10)    @title : '{i18n>SALESBYCURRENT.SHIP_TO_KUNWE_ANA}';
    SHIP_TO_NAME            : String(70)    @title : '{i18n>SALESBYCURRENT.SHIP_TO_NAME}';
key SKU_MATNR               : String(7)     @title : '{i18n>SALESBYCURRENT.SKU_MATNR}';
    TBTXT                   : String(60)    @title : '{i18n>SALESBYCURRENT.TBTXT}';
    TRACKING_TRACKN         : String(35)    @title : '{i18n>SALESBYCURRENT.TRACKING_TRACKN}';
    MWSBP                   : Decimal(18,2) @title : '{i18n>SALESBYCURRENT.MWSBP}';
    UNIT_PRICE              : Decimal(32,2) @title : '{i18n>SALESBYCURRENT.UNIT_PRICE}';
    UNITS_PER_CASE          : Integer       @title : '{i18n>SALESBYCURRENT.UNITS_PER_CASE}';
    UPC_EAN11               : String(18)    @title : '{i18n>SALESBYCURRENT.UPC_EAN11}';
key VKBUR                   : String(4)     @title : '{i18n>SALESBYCURRENT.VKBUR}';
    VTEXT_FKART             : String(40)    @title : '{i18n>SALESBYCURRENT.VTEXT_FKART}';
    WAERK                   : String(5)     @title : '{i18n>SALESBYCURRENT.WAERK}';
    WAREHOUSE               : String(12)    @title : '{i18n>SALESBYCURRENT.WAREHOUSE}';
key WERKS                   : String(4)     @title : '{i18n>SALESBYCURRENT.WERKS}';
    PLANT_NAME              : String(30)    @title : '{i18n>SALESBYCURRENT.PLANT_NAME}';
    MFRNR_NAME              : String(35)    @title : '{i18n>SALESBYCURRENT.MFRNR_NAME}'; 
    INV_YEAR                : String(4)     @title : '{i18n>SALESBYCURRENT.INV_YEAR}';
    BEZEI                   : String(40)    @title : '{i18n>SALESBYCURRENT.BEZEI}';
    AUART                   : String(4)     @title : '{i18n>SALESBYCURRENT.AUART}';
    BEZEI_AUART             : String(20)    @title : '{i18n>SALESBYCURRENT.BEZEI_AUART}';
    VGBEL                   : String(10)    @title : '{i18n>SALESBYCURRENT.VGBEL}';
}
@cds.persistence.exists
entity SALESBYCURRENTWOPID
{
    ADDRESS_1               : String(35)    @title : '{i18n>SALESBYCURRENT.ADDRESS_1}';
    ADDRESS_2               : String(40)    @title : '{i18n>SALESBYCURRENT.ADDRESS_2}';
    AMOUNT_NETWR            : Decimal(20,2) @title : '{i18n>SALESBYCURRENT.AMOUNT_NETWR}';
    AUGRU_AUFT              : String(3)     @title : '{i18n>SALESBYCURRENT.AUGRU_AUFT}';
    BILL_TO_KUNRE_ANA       : String(10)    @title : '{i18n>SALESBYCURRENT.BILL_TO_KUNRE_ANA}';
    BILL_TO_NAME            : String(70)    @title : '{i18n>SALESBYCURRENT.BILL_TO_NAME}';
    CITY_ORT01              : String(35)    @title : '{i18n>SALESBYCURRENT.CITY_ORT01}';
key CO_VKORG                : String(4)     @title : '{i18n>SALESBYCURRENT.CO_VKORG}';
    COMMENT                 : String(13)    @title : '{i18n>SALESBYCURRENT.COMMENT}';
    CURRENT                 : String(3)     @title : '{i18n>SALESBYCURRENT.CURRENT}';
    DELEVERY_DATE_VDATU     : String(8)     @title : '{i18n>SALESBYCURRENT.DELEVERY_DATE_VDATU}'; // Note: Typo 'DELEVERY' kept in field name
    EXPIRY_DATE_VFDAT       : String(8)     @title : '{i18n>SALESBYCURRENT.EXPIRY_DATE_VFDAT}';
key INVOICE_CREDIT_VBELN    : String(10)    @title : '{i18n>SALESBYCURRENT.INVOICE_CREDIT_VBELN}';
    INVOICE_DATE_FKDAT      : String(8)     @title : '{i18n>SALESBYCURRENT.INVOICE_DATE_FKDAT}';
key LOT_CHARG               : String(10)    @title : '{i18n>SALESBYCURRENT.LOT_CHARG}';
    MFRNR                   : String(10)    @title : '{i18n>SALESBYCURRENT.MFRNR}';
    MFRPN                   : String(40)    @title : '{i18n>SALESBYCURRENT.MFRPN}';
    POSTAL_CODE_PSTLZ       : String(10)    @title : '{i18n>SALESBYCURRENT.POSTAL_CODE_PSTLZ}';
    PRODUCT_DESCRIPTION_MAKTX : String(40)  @title : '{i18n>SALESBYCURRENT.PRODUCT_DESCRIPTION_MAKTX}'; // Corrected typo in original title implicitly via key
    PROVINCE_REGIO          : String(3)     @title : '{i18n>SALESBYCURRENT.PROVINCE_REGIO}';
    PURCHASE_ORDER_BSTKD    : String(35)    @title : '{i18n>SALESBYCURRENT.PURCHASE_ORDER_BSTKD}';
    QUANTITY_FKIMG          : Decimal(13,3) @title : '{i18n>SALESBYCURRENT.QUANTITY_FKIMG}';
    RBTXT                   : String(20)    @title : '{i18n>SALESBYCURRENT.RBTXT}';
    SHIP_TO_KUNWE_ANA       : String(10)    @title : '{i18n>SALESBYCURRENT.SHIP_TO_KUNWE_ANA}';
    SHIP_TO_NAME            : String(70)    @title : '{i18n>SALESBYCURRENT.SHIP_TO_NAME}';
key SKU_MATNR               : String(7)     @title : '{i18n>SALESBYCURRENT.SKU_MATNR}';
    TBTXT                   : String(60)    @title : '{i18n>SALESBYCURRENT.TBTXT}';
    TRACKING_TRACKN         : String(35)    @title : '{i18n>SALESBYCURRENT.TRACKING_TRACKN}';
    MWSBP                   : Decimal(18,2) @title : '{i18n>SALESBYCURRENT.MWSBP}';
    UNIT_PRICE              : Decimal(32,2) @title : '{i18n>SALESBYCURRENT.UNIT_PRICE}';
    UNITS_PER_CASE          : Integer       @title : '{i18n>SALESBYCURRENT.UNITS_PER_CASE}';
    UPC_EAN11               : String(18)    @title : '{i18n>SALESBYCURRENT.UPC_EAN11}';
key VKBUR                   : String(4)     @title : '{i18n>SALESBYCURRENT.VKBUR}';
    VTEXT_FKART             : String(40)    @title : '{i18n>SALESBYCURRENT.VTEXT_FKART}';
    WAERK                   : String(5)     @title : '{i18n>SALESBYCURRENT.WAERK}';
    WAREHOUSE               : String(12)    @title : '{i18n>SALESBYCURRENT.WAREHOUSE}';
key WERKS                   : String(4)     @title : '{i18n>SALESBYCURRENT.WERKS}';
    PLANT_NAME              : String(30)    @title : '{i18n>SALESBYCURRENT.PLANT_NAME}';
    MFRNR_NAME              : String(35)    @title : '{i18n>SALESBYCURRENT.MFRNR_NAME}'; 
    INV_YEAR                : String(4)     @title : '{i18n>SALESBYCURRENT.INV_YEAR}';
    BEZEI                   : String(40)    @title : '{i18n>SALESBYCURRENT.BEZEI}';
    AUART                   : String(4)     @title : '{i18n>SALESBYCURRENT.AUART}';
    BEZEI_AUART             : String(20)    @title : '{i18n>SALESBYCURRENT.BEZEI_AUART}';
    VGBEL                   : String(10)    @title : '{i18n>SALESBYCURRENT.VGBEL}';
}
define view SBCINVOICE as
    select from SALESBYCURRENT distinct {
        key INVOICE_CREDIT_VBELN,
        MFRNR @UI.Hidden
};
define view SBCBEZEI as
    select from SALESBYCURRENT distinct {
        key BEZEI,
        MFRNR @UI.Hidden
};
define view SBCBEZEIAUART as
    select from SALESBYCURRENT distinct {
        key BEZEI_AUART,
        MFRNR @UI.Hidden
};
define view SBCPLANTNAME as
    select from SALESBYCURRENT distinct {
        key PLANT_NAME,
        MFRNR @UI.Hidden
};
define view SBCPRODDESC as
    select from SALESBYCURRENT distinct {
        key PRODUCT_DESCRIPTION_MAKTX,
        MFRNR @UI.Hidden
};
define view SBCTYPE as
    select from SALESBYCURRENT distinct {
        key VTEXT_FKART,
        MFRNR @UI.Hidden
};
define view SBCWAREHOUSE as
    select from SALESBYCURRENT distinct {
        key WAREHOUSE,
        MFRNR @UI.Hidden
};
define view SBCLOT as
    select from SALESBYCURRENT distinct {
        key LOT_CHARG,
        MFRNR @UI.Hidden
};
define view SBCBILLTO as
    select from SALESBYCURRENT distinct {
        key BILL_TO_NAME,
        MFRNR @UI.Hidden
};
define view SBCBILLTOID as
    select from SALESBYCURRENT distinct {
        key BILL_TO_KUNRE_ANA,
        MFRNR @UI.Hidden
};
define view SBCSHIPTOID as
    select from SALESBYCURRENT distinct {
        key SHIP_TO_KUNWE_ANA,
        MFRNR @UI.Hidden
};
define view SBCSHIPTO as
    select from SALESBYCURRENT distinct {
        key SHIP_TO_NAME,
        MFRNR @UI.Hidden
};
define view SBCMFRNR as
    select from SALESBYCURRENT distinct {
        key MFRNR
};
define view SBCMFRNRNAME as
    select from SALESBYCURRENT distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view SBCSALESORG as
    select from SALESBYCURRENT distinct {
        key CO_VKORG,
        MFRNR @UI.Hidden
};
define view SBCSALESOFFICE as
    select from SALESBYCURRENT distinct {
        key VKBUR,
        MFRNR @UI.Hidden
};
define view SBCYEAR as
    select from SALESBYCURRENT distinct {
        key INV_YEAR,
        MFRNR @UI.Hidden
};
// Sales by Product/Customer
// Security attributes to match: ??
@cds.search: { 
     
    PURCHASE_ORDER,  
    PRODUCT_DESCRIPTION, 
    LOT, 
    TYPE,
    BILL_TO,
    SHIP_TO,
    BILL_TO_NAME,
    SHIP_TO_NAME,
    ADDRESS_1,
    ADDRESS_2,
    POSTAL_CODE,
    CITY,
    PROVANCE,
    SPECIAL_HANDLING, 
    WAREHOUSE,
    COMMENT, 
    CO_VKORG 
}
// Customer Master
// Security attributes to match: ??
@cds.search: { 
    KUNN2_BILLTO,
    STRAS_BILLTO,
    ORT01_BILLTO,
    ERDAT_BILLTO,
    NAME1_BILLTO,
    PSTLZ_BILLTO,
    BEZEI_BILLTO,
    KTEXT_BILLTO,
    VKORG,
    KUNN2_SHIPTO,
    STRAS_SHIPTO,
    ORT01_SHIPTO,
    ERDAT_SHIPTO,
    NAME1_SHIPTO,
    PSTLZ_SHIPTO,
    BEZEI_SHIPTO,
    KTEXT_SHIPTO,
    CAL_CUST_STATUS,
    CAL_TERM
}
@cds.persistence.exists
entity CUSTOMERMASTER 
{
    key KUNN2_BILLTO	: String(10)        @title: '{i18n>CUSTOMERMASTER.KUNN2_BILLTO}';	
        STRAS_BILLTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.STRAS_BILLTO}';     
        ORT01_BILLTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.ORT01_BILLTO}';	 
        ERDAT_BILLTO	: String(8)         @title: '{i18n>CUSTOMERMASTER.ERDAT_BILLTO}';	 
        NAME1_BILLTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.NAME1_BILLTO}';	 
        PSTLZ_BILLTO	: String(10)        @title: '{i18n>CUSTOMERMASTER.PSTLZ_BILLTO}';  
        BEZEI_BILLTO	: String(20)        @title: '{i18n>CUSTOMERMASTER.BEZEI_BILLTO}';	 
        KTEXT_BILLTO	: String(20)        @title: '{i18n>CUSTOMERMASTER.KTEXT_BILLTO}';	 
    key VKORG	        : String(4)         @title: '{i18n>CUSTOMERMASTER.VKORG}';	
        CREDIT_LIMIT	: Decimal(15,2)     @title: '{i18n>CUSTOMERMASTER.CREDIT_LIMIT}';	 
    key KUNN2_SHIPTO	: String(10)        @title: '{i18n>CUSTOMERMASTER.KUNN2_SHIPTO}';	
        STRAS_SHIPTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.STRAS_SHIPTO}';	 
        ORT01_SHIPTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.ORT01_SHIPTO}';	 
        ERDAT_SHIPTO	: String(8)         @title: '{i18n>CUSTOMERMASTER.ERDAT_SHIPTO}';	 
        NAME1_SHIPTO	: String(35)        @title: '{i18n>CUSTOMERMASTER.NAME1_SHIPTO}';	 
        PSTLZ_SHIPTO	: String(10)        @title: '{i18n>CUSTOMERMASTER.PSTLZ_SHIPTO}';	 
        BEZEI_SHIPTO	: String(20)        @title: '{i18n>CUSTOMERMASTER.BEZEI_SHIPTO}';	 
        KTEXT_SHIPTO	: String(20)        @title: '{i18n>CUSTOMERMASTER.KTEXT_SHIPTO}';	 
        CAL_CUST_STATUS	: String(1)         @title: '{i18n>CUSTOMERMASTER.CAL_CUST_STATUS}';	 
        CAL_TERM	    : String(4)         @title: '{i18n>CUSTOMERMASTER.CAL_TERM}';
        VTEXT           : String(30)	    @title: '{i18n>CUSTOMERMASTER.VTEXT}';
}
// Customer Master Bill To filter
define view KUNN2_BILLTO as
    select from CUSTOMERMASTER distinct {
        key KUNN2_BILLTO
};
define view KUNN2_BILLTONAME as
    select from CUSTOMERMASTER distinct {
        key NAME1_BILLTO
};
// Customer Master Ship To filter
define view KUNN2_SHIPTO as
    select from CUSTOMERMASTER distinct {
        key KUNN2_SHIPTO

};
define view KUNN2_SHIPTONAME as
    select from CUSTOMERMASTER distinct {
        key NAME1_SHIPTO

};
// Customer Master Customer Status filter
define view CAL_CUST_STATUS as
    select from CUSTOMERMASTER distinct {
        key CAL_CUST_STATUS
};
define view CMSALESORG as
    select from CUSTOMERMASTER distinct {
        key VKORG
};

// Shipping History
// Security attributes to match: ??
@cds.search: { 
    CARRIER,
    VKORG,
    KUNAG,
    VBELN,
    PSTLZ,
    TRK_DLVTO,
    KUNNR,
    NAME1,
    TRACKN,
    MFRNR
}
@cds.persistence.exists
entity SHIPPINGHISTORY
{
        TRK_DLVTO            : String(40)    @title : '{i18n>SHIPPINGHISTORY.TRK_DLVTO}';
    key VBELN                : String(10)    @title : '{i18n>SHIPPINGHISTORY.VBELN}';
    key KUNNR                : String(10)    @title : '{i18n>SHIPPINGHISTORY.KUNNR}';
        WADAT_IST            : String(8)     @title : '{i18n>SHIPPINGHISTORY.WADAT_IST}';
        NAME1                : String(35)    @title : '{i18n>SHIPPINGHISTORY.NAME1}';
    key VKORG                : String(4)     @title : '{i18n>SHIPPINGHISTORY.VKORG}';
        LFUHR                : String(6)     @title : '{i18n>SHIPPINGHISTORY.LFUHR}';
        CARRIER              : String(10)    @title : '{i18n>SHIPPINGHISTORY.CARRIER}';
        CAL_BILL_ITM_COUNT   : Integer       @title : '{i18n>SHIPPINGHISTORY.CAL_BILL_ITM_COUNT}';
    key KUNAG                : String(10)    @title : '{i18n>SHIPPINGHISTORY.KUNAG}';
        FKIMG                : Decimal(18,0) @title : '{i18n>SHIPPINGHISTORY.FKIMG}';
        MFRNR                : String(10)    @title : '{i18n>SHIPPINGHISTORY.MFRNR}';
        MEINS                : String(3)     @title : '{i18n>SHIPPINGHISTORY.MEINS}';
        PSTLZ                : String(10)    @title : '{i18n>SHIPPINGHISTORY.PSTLZ}';
        LFDAT                : String(8)     @title : '{i18n>SHIPPINGHISTORY.LFDAT}';
        TRACKN               : String(35)    @title : '{i18n>SHIPPINGHISTORY.TRACKN}';
        CURRENT              : String(3)     @title : '{i18n>SHIPPINGHISTORY.CURRENT}';
        MFRNR_NAME           : String(35)    @title : '{i18n>SHIPPINGHISTORY.MFRNR_NAME}';
}

// Shipping History Invoice filter
define view SHINVOICE as
    select from SHIPPINGHISTORY distinct {
        key VBELN,
        MFRNR @UI.Hidden
};
// Shipping History Customer filter
define view SHCUSTOMER as
    select from SHIPPINGHISTORY distinct {
        key KUNAG,
        MFRNR @UI.Hidden
};
// Shipping History Ship To filter
define view SHSHIPTO as
    select from SHIPPINGHISTORY distinct {
        key KUNNR,
        MFRNR @UI.Hidden
};
define view SHSHIPTONAME as
    select from SHIPPINGHISTORY distinct {
        key NAME1,
        MFRNR @UI.Hidden
};
// Shipping History Carrier filter
define view SHCARRIER as
    select from SHIPPINGHISTORY distinct {
        key CARRIER,
        MFRNR @UI.Hidden
};
// Shipping History Tracking # filter
define view SHTRACKING as
    select from SHIPPINGHISTORY distinct {
        key TRACKN,
        MFRNR @UI.Hidden
};

define view SHMFRNR as
    select from SHIPPINGHISTORY distinct {
        key MFRNR
};

define view SHMFRNRNAME as
    select from SHIPPINGHISTORY distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};

define view SHVKORG as
    select from SHIPPINGHISTORY distinct {
        key VKORG,
        MFRNR @UI.Hidden
};

// Pricing
@cds.search: { 
    VKORG,
    KSCHL,
    VTEXT,
    MATNR,
    MAKTX,
    MFRNR
}
@cds.persistence.exists
entity PRICING
{
    key VKORG       : String(4)     @title : '{i18n>PRICING.VKORG}';
        KBETR       : Decimal(11,2) @title : '{i18n>PRICING.KBETR}';
    key KSCHL       : String(4)     @title : '{i18n>PRICING.KSCHL}';
        VTEXT       : String(20)    @title : '{i18n>PRICING.VTEXT}';
    key MATNR       : String(7)     @title : '{i18n>PRICING.MATNR}';
        MAKTX       : String(40)    @title : '{i18n>PRICING.MAKTX}';
        REGIO       : String(3)     @title : '{i18n>PRICING.REGIO}';
        MFRNR       : String(10)    @title : '{i18n>PRICING.MFRNR}';
        KONWA       : String(5)     @title : '{i18n>PRICING.KONWA}';
        MFRNR_NAME  : String(35)    @title : '{i18n>PRICING.MFRNR_NAME}';
        DATAB       : String(8)     @title : '{i18n>PRICING.DATAB}';
}
// Shipping History Carrier filter
define view PRICINGPRICEDESC as
    select from PRICING distinct {
        key VTEXT,
        MFRNR @UI.Hidden
};
// Shipping History Tracking # filter
define view PRICINGPRODUCTDESC as
    select from PRICING distinct {
        key MAKTX,
        MFRNR @UI.Hidden
};
define view PRICINGPRODUCT as
    select from PRICING distinct {
        key MATNR,
        MFRNR @UI.Hidden
};
define view PRICINGMFRNR as
    select from PRICING distinct {
        key MFRNR
};

define view PRICINGMFRNRNAME as
    select from PRICING distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};

define view PRICINGSALESORG as
    select from PRICING distinct {
        key VKORG,
        MFRNR @UI.Hidden
};

// Open Orders
@cds.search: { 
    KUNNR,	
    VDATU,	 
    CAL_NAME,	 
    VBELN,
    GBSTK,
    MATNR,
    MAKTX,
    BSTKD,
    KUNWE_ANA,
    REGIO,
    MFRNR
}
@cds.persistence.exists
entity OPENORDERS
{
    key VBELN       : String(10)    @title : '{i18n>OPENORDERS.VBELN}';
        KWMENG      : Decimal(20,3) @title : '{i18n>OPENORDERS.KWMENG}';
        ERDAT       : String(8)     @title : '{i18n>OPENORDERS.ERDAT}';
        KUNWE_ANA   : String(10)    @title : '{i18n>OPENORDERS.KUNWE_ANA}';
    key KUNNR       : String(10)    @title : '{i18n>OPENORDERS.KUNNR}';
        VDATU       : String(10)    @title : '{i18n>OPENORDERS.VDATU}';
        REGIO       : String(3)     @title : '{i18n>OPENORDERS.REGIO}';
        CAL_NAME    : String(70)    @title : '{i18n>OPENORDERS.CAL_NAME}';
        PSTLZ       : String(10)    @title : '{i18n>OPENORDERS.PSTLZ}';
        VDATU_ANA   : String(8)     @title : '{i18n>OPENORDERS.VDATU_ANA}';
        //GBSTA       : String(1)     @title : '{i18n>OPENORDERS.GBSTA}';
        AUART_ANA   : String(4)     @title : '{i18n>OPENORDERS.AUART_ANA}';
        MAKTX       : String(40)    @title : '{i18n>OPENORDERS.MAKTX}';
        MFRPN       : String(40)    @title : '{i18n>OPENORDERS.MFRPN}';
        //GBSTK       : String(1)     @title : '{i18n>OPENORDERS.GBSTK}';
    key MATNR       : String(7)     @title : '{i18n>OPENORDERS.MATNR}';
        BSTKD       : String(35)    @title : '{i18n>OPENORDERS.BSTKD}';
        MFRNR       : String(10)    @title : '{i18n>OPENORDERS.MFRNR}';
        MFRNR_NAME  : String(35)    @title : '{i18n>OPENORDERS.MFRNR_NAME}';
    key VKORG       : String(4)     @title : '{i18n>OPENORDERS.VKORG}';
        PLANT_NAME  : String(35)    @title : '{i18n>OPENORDERS.PLANT_NAME}';   
        PLANT       : String(3)     @title : '{i18n>OPENORDERS.PLANT}';
        BEZEI       : String(20)    @title : '{i18n>OPENORDERS.BEZEI}';
}

define view OOVBELN as
    select from OPENORDERS distinct {
        key VBELN,
        MFRNR @UI.Hidden
} where VBELN is not null and VBELN != '';
// Open Orders Product Description filter
define view OOPRODDESC as
    select from OPENORDERS distinct {
        key MAKTX,
        MFRNR @UI.Hidden
};
define view OOPROD as
    select from OPENORDERS distinct {
        key MATNR,
        MFRNR @UI.Hidden
};
// Open Orders Customer filter
define view OOCUST as
    select from OPENORDERS distinct {
        key KUNNR,
        MFRNR @UI.Hidden
};
// Open Orders Ship To filter
define view OOSHIPTO as
    select from OPENORDERS distinct {
        key KUNWE_ANA,
        MFRNR @UI.Hidden
};
define view OOSHIPTONAME as
    select from OPENORDERS distinct {
        key CAL_NAME,
        MFRNR @UI.Hidden
};
// Open Orders Province filter
define view OOPROVINCE as
    select from OPENORDERS distinct {
        key REGIO,
        MFRNR @UI.Hidden
};
define view OOVKORG as
    select from OPENORDERS distinct {
        key VKORG,
        MFRNR @UI.Hidden
};
define view OOMFRNR as
    select from OPENORDERS distinct {
        key MFRNR
};
define view OOMFRNRNAME as
    select from OPENORDERS distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};

// Returns
// Security attributes to match: ??
@cds.search: { 
    CUSTOMER_KUNNR,	
    CUSTOMER_NAME_NAME1,
    PROVINCE_REGIO,
    RGA_VBELN,
    REASON_BEZEI,
    REFERENCE_BSTKD ,
    CO_VKORG,
    MANUFACTURER_MFRNR,
    SALES_OFFICE_VKBUR,
    PROFIT_CENTER_PRCTR
}
@cds.persistence.exists
entity RETURNS
{
    ERDAT                 : String(8)     @title : '{i18n>RETURNS.ERDAT}';
key CUSTOMER_KUNNR        : String(10)    @title : '{i18n>RETURNS.CUSTOMER_KUNNR}';
    CUSTOMER_NAME_NAME1   : String(35)    @title : '{i18n>RETURNS.CUSTOMER_NAME_NAME1}';
    PROVINCE_REGIO        : String(3)     @title : '{i18n>RETURNS.PROVINCE_REGIO}';
key VBELN_VBAK            : String(10)    @title : '{i18n>RETURNS.VBELN_VBAK}';
    REASON_BEZEI          : String(40)    @title : '{i18n>RETURNS.REASON_BEZEI}';
    REFERENCE_BSTKD       : String(35)    @title : '{i18n>RETURNS.REFERENCE_BSTKD}';
key VBELN_VBRK            : String(35)    @title : '{i18n>RETURNS.VBELN_VBRK}';
    FKDAT_ANA             : String(8)     @title : '{i18n>RETURNS.FKDAT_ANA}';
    CREDIT_AMT_NETWR      : Decimal(15,2) @title : '{i18n>RETURNS.CREDIT_AMT_NETWR}';
key CO_VKORG              : String(4)     @title : '{i18n>RETURNS.CO_VKORG}';
    MFRNR                 : String(10)    @title : '{i18n>RETURNS.MFRNR}';
key VKBUR                 : String(4)     @title : '{i18n>RETURNS.VKBUR}';
    CURRENT               : String(10)    @title : '{i18n>RETURNS.CURRENT}';
    MFRNR_NAME            : String(35)    @title : '{i18n>RETURNS.MFRNR_NAME}';
    LFGSK                 : String(1)     @title : '{i18n>RETURNS.LFGSK}';
    VBTYP                 : String(1)     @title : '{i18n>RETURNS.VBTYP}';
    PLANT                 : String(3)     @title : '{i18n>RETURNS.PLANT}';
    PLANT_NAME            : String(35)    @title : '{i18n>RETURNS.PLANT_NAME}';   
}
//  Returns Customer filter
define view RETCUST as
    select from RETURNS distinct {
        key CUSTOMER_KUNNR,
        MFRNR @UI.Hidden
};
define view RETCUSTNAME as
    select from RETURNS distinct {
        key CUSTOMER_NAME_NAME1,
        MFRNR @UI.Hidden
};
//  Returns Reason filter
define view RETREASON as
    select from RETURNS distinct {
        key REASON_BEZEI,
        MFRNR @UI.Hidden
};
//  Returns RGA filter
define view RETRGA as
    select from RETURNS distinct {
        key VBELN_VBAK,
        MFRNR @UI.Hidden
};
define view RETVKORG as
    select from RETURNS distinct {
        key CO_VKORG,
        MFRNR @UI.Hidden
};
define view RETMFRNR as
    select from RETURNS distinct {
        key MFRNR
};

define view RETMFRNRNAME as
    select from RETURNS distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view RETVKBUR as
    select from RETURNS distinct {
        key VKBUR,
        MFRNR @UI.Hidden
};
@cds.search: { KUNRE_ANA, KUNWE_ANA, VKORG,	BSTKD, VBELN, MATNR, MAKTX, NAME1, MFRNR }
@cds.persistence.exists
entity BACKORDERS
{
    DATE_DIFF      : Integer       @title : '{i18n>BACKORDERS.DATE_DIFF}';
key KUNRE_ANA      : String(10)    @title : '{i18n>BACKORDERS.KUNRE_ANA}';
    UDATE          : String(8)     @title : '{i18n>BACKORDERS.UDATE}';
key VKORG          : String(4)     @title : '{i18n>BACKORDERS.VKORG}';
    BSTKD          : String(35)    @title : '{i18n>BACKORDERS.BSTKD}';
    EXTENSION      : Decimal(38,2) @title : '{i18n>BACKORDERS.EXTENSION}' @Org.OData.Measures.V1.ISOCurrency; // Assuming currency field exists/added
key VBELN          : String(10)    @title : '{i18n>BACKORDERS.VBELN}';
    ERDAT          : String(8)     @title : '{i18n>BACKORDERS.ERDAT}';
    UNIT_PRICE     : Decimal(30,2) @title : '{i18n>BACKORDERS.UNIT_PRICE}' @Org.OData.Measures.V1.ISOCurrency; // Assuming currency field exists/added
key MATNR          : String(7)     @title : '{i18n>BACKORDERS.MATNR}';
    MAKTX          : String(40)    @title : '{i18n>BACKORDERS.MAKTX}';
    BACK_ORD_QTY   : Decimal(18,0) @title : '{i18n>BACKORDERS.BACK_ORD_QTY}';
key KUNWE_ANA      : String(10)    @title : '{i18n>BACKORDERS.KUNWE_ANA}';
    NAME1          : String(35)    @title : '{i18n>BACKORDERS.NAME1}';
    MFRNR          : String(10)    @title : '{i18n>BACKORDERS.MFRNR}';
    MEINS          : String(3)     @title : '{i18n>BACKORDERS.MEINS}';
    MFRNR_NAME     : String(35)    @title : '{i18n>BACKORDERS.MFRNR_NAME}'; 
    PLANT          : String(3)     @title : '{i18n>BACKORDERS.PLANT}';
    PLANT_NAME     : String(35)    @title : '{i18n>BACKORDERS.PLANT_NAME}';   
}


//  Back Orders Product Name filter
define view BOPRODUCTDESC as
    select from BACKORDERS distinct {
        key MAKTX @(DataField:{Label:'Description'}),
        MFRNR @UI.Hidden
};
define view BOPRODUCT as
    select from BACKORDERS distinct {
        key MATNR @(DataField:{Label:'SKU'}),
        MFRNR @UI.Hidden
};

//  Back Orders Bill To filter
define view BOBILLTO as
    select from BACKORDERS distinct {
        key KUNRE_ANA,
        MFRNR @UI.Hidden

};
//  Back Orders Ship To filter
define view BOSHIPTO as
    select from BACKORDERS distinct {
        key KUNWE_ANA,
        MFRNR @UI.Hidden
};
define view BOSHIPTONAME as
    select from BACKORDERS distinct {
        key NAME1,
        MFRNR @UI.Hidden
};
define view BOMFRNR as
    select from BACKORDERS distinct {
        key MFRNR
};

define view BOMFRNRNAME as
    select from BACKORDERS distinct {
        key MFRNR_NAME,
        MFRNR @UI.Hidden
};
define view BOVKORG as
    select from BACKORDERS distinct {
        key VKORG,
        MFRNR @UI.Hidden
};

@cds.persistence.exists
entity SHIPPINGSTATUS
{
        OBD_NO_DOCNO_C                              : String(10)        @title: 'Delivery #';
    key OBD_ITEM_NO_ITEMNO                          : String(10)        @title: 'SKU';
        OBD_TIMESTAMP_LAST_STATUS_TIME_PLANT_BASED  : Timestamp         @title: 'Plant Time';
        PICK_AND_PACK_STATUS_SALES_SHIPPING_STATUS  : String(27)        @title: 'Warehouse Status';
        SO_NO_REFDOCNO                              : String(35)        @title: 'Sales Order #';
        CUSTOMER_PO_BSTNK                           : String(20)        @title: 'Customer PO'; 
        STORAGE_CONDITIONS_STOKEY1                  : String(5)         @title: 'Storage Condition';
        WAREHOUSE_NAME_LNUMT                        : String(40)        @title: 'Plant'; 
        WAREHOUSE_TIME_ZONE                         : String(6)         @title: 'Time Zone';
        VKORG                                       : String(4)         @title: 'Sales Org';
        QUANTITY_ORDERED_QTY                        : Decimal(31,14)    @title: 'Quantity Ordered';
        PRODUCT_DESCRIPTION_MAKTX                   : String(40)        @title: 'Product Description';
        REQUESTED_DELIVERY_DATE_VDATU               : String(8)         @title: 'Requested Delivery Date';
        SHIP_TO_PARTYNO                             : String(10)        @title: 'Ship To #';
        SHIP_TO_NAME_PARTNER                        : String(10)        @title: 'Ship To Name';
        MANUFACTURER_NAME_MC_NAME1                  : String(35)        @title: 'Manufacturer Name';
        MANUFACTURER_MFRNR                          : String(10)        @title: 'Manufacturer #'
}
@cds.persistence.exists
entity MAINPAGESUMMARY 
{       
    key MFRNR           : String(10);
    key CALYEAR         : Integer;
    key PREVIOUS_YEAR   : Integer;
    key CALMONTH        : Integer;
    key PRE_YEAR_MONTH  :Integer;
        NETWR_CURRENT   : Decimal(25, 2);
        NETWR_PREVIOUS  : Decimal(25, 2);
        FKIMG_CURRENT   : Decimal(23, 2);
        FKIMG_PREVIOUS  : Decimal(23, 2);
        INV_COUNT       : Integer;
        QTY_DIFF        : Decimal(23, 2);
        PERCENTAGE_DIFF : Decimal(34, 0);
        MONTH_NAME      : String(8); 
}

define view MPSYEAR as
    select from MAINPAGESUMMARY distinct {
        key CALYEAR
};

define view MPSMONTH as
    select from MAINPAGESUMMARY distinct {
        key MONTH_NAME,
        MFRNR @UI.Hidden
};

define view MPSMFRNR as
    select from MAINPAGESUMMARY distinct {
        key MFRNR
};

@cds.persistence.exists
entity MAINPAGEINVENTORY
{
    key SKU_MATNR           : String(7);
    QUAN_AVAILABLE_QUANTITY : Decimal(38, 2);
    OPEN_STOCK              : Decimal(38, 2);
    QUARANTINE              : Decimal(38, 2);
    RETAINS                 : Decimal(38, 2);
    QUALITY_HOLD            : Decimal(38, 2);
    RETURNS_CAL             : Decimal(38, 2);
    RECALLS                 : Decimal(38, 2);
    INVENTORY_HOLD          : Decimal(38, 2);
    RELABEL_QTY             : Decimal(38, 2);	
    DAMAGE_DESTRUCTION      : Decimal(38, 2);
    SAMPLE_QTY              : Decimal(38, 2); 
    MANUFACTURER_MFRPN      : String(10);
    
}



using { cuid, managed } from '@sap/cds/common';

// Optional: Define a namespace if you haven't already
// namespace com.yourcompany.media;

entity MediaFile : cuid, managed { // 'cuid' provides 'ID: UUID' as the key. 'managed' provides audit fields.
                                 // No need to explicitly define 'ID' again.
    @Core.MediaType : mediaType
    @Core.ContentDisposition.Filename : fileName
    content            : LargeBinary;
    fileName           : String;
    mediaType          : String @Core.IsMediaType;
    url                : String;
    manufacturerNumber : String(50);
    MFGName            : String(255);
}




















