// First Initial Datashpere POC Entity
@cds.persistence.exists
@cds.search: { MANDT, VBELN, POSNR, FKART, LIFNR }
entity BILLING //@(restrict: [
//     { grant: 'READ', where: 'LIFNR = $user.LIFNR AND MFRNR = $user.MFRNR'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key MANDT   : String(3)@Common.FilterDefaultValueHigh : MANDT;
    key VBELN   : String(10);
    key POSNR   : String(4);
        FKART   : String(4);
        LIFNR   : String(10);
        MFRNR   : String(10);
}

// Item Master Entity 
// Security attibutes to match: ??
@cds.search: { PRODUCTSTANDARDID, PRODUCT, CATEGORY, MANUFACTURERNUMBER, SALESORG, CREATIONDATE, PRODUCTDESCRIPTION_EN, SIZEUOM }
@cds.persistence.exists
entity ITEMMASTER
{
        @UI.HiddenFilter: true
    key PRODUCT                 : String(40);
        @UI.HiddenFilter: true
    key SALESORG                : String(4);
        @UI.HiddenFilter: true
        CREATIONDATE            : String(8);
        @UI.HiddenFilter: true
        DIN                     : String(70);
        @UI.HiddenFilter: true
        GST_APPLICABLE          : String(1);
        @UI.HiddenFilter: true
        LOT_CONTROL_YN          : String(1);
        @UI.HiddenFilter: true
        NARCOTIC_YN             : String(1);
        CATEGORY                : String(20) @Search.defaultSearchElement;
        PRODUCTDESCRIPTION_EN   : String(40);
        @UI.HiddenFilter: true
        PRODUCTDESCRIPTION_FR   : String(40);
        @UI.HiddenFilter: true
        PST_APPLICABLE          : String(1);
        @UI.HiddenFilter: true
        REFRIGERATED            : String(1);
        @UI.HiddenFilter: true
        UNITS_PER_CASE          : Decimal(5,0);
        @UI.HiddenFilter: true
        SIZEUOM                 : String(80);
        @UI.HiddenFilter: true
        PRODUCTSTANDARDID       : String(18);
        @UI.HiddenFilter: true
        MANUFACTURERNUMBER      : String(10);
}
define view ITEMMASPD as
    select from ITEMMASTER distinct {
        key PRODUCTDESCRIPTION_EN
};
define view ITEMMASCATEGORY as
    select from ITEMMASTER distinct {
        key CATEGORY
};

// Inventory Status
// Security attributes to match: ??
@cds.search: { SKU, PRODUCT_CODE, SIZE, MANUFACTURER, PRODUCT_DESCRIPTION, CO, WAREHOUSE }
@cds.persistence.exists
entity INVENTORYSTATUS //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        @UI.HiddenFilter: true
    key SKU                 : String(40);
        PRODUCT_CODE        : String(99);
        @UI.HiddenFilter: true
        SIZE                : String(30);
        @UI.HiddenFilter: true
        PRODUCT_DESCRIPTION : String(40);
        @UI.HiddenFilter: true
        OPEN_STOCK          : Decimal(36,14);
        @UI.HiddenFilter: true
        QUARANTINE          : Decimal(36,14);
        @UI.HiddenFilter: true
        DAMAGE_DESTRUCTION  : Decimal(36,14);
        @UI.HiddenFilter: true
        RETAINS             : Decimal(36,14);
        @UI.HiddenFilter: true
        RETURNS_CAL         : Decimal(36,14);
        @UI.HiddenFilter: true
        RECALLS             : Decimal(36,14);
        @UI.HiddenFilter: true
    key CO                  : String(4);
        @UI.HiddenFilter: true
        WAREHOUSE           : String(4);
        @UI.HiddenFilter: true
        MANUFACTURER        : String(40);
}
// Inventory Status Product Code filter
define view INVSTATUSPRODUCTCODE as
    select from INVENTORYSTATUS distinct {
        key PRODUCT_CODE
};

// Invetory Audit Trail 
// Security attibutes to match:  
@cds.search: { MATNR, MAKTX, POSTING_DATE, CHARG, WAREHOUSE_STATUS, KUNNR, CUSTOMER_NAME, INV_MATDOC_ITEM, WERKS, LGORT, MFRNR, NAME1_PLANT }
@cds.persistence.exists
entity INVENTORYAUDITTRAIL
{
        MFRNR_PROD_CODE     : String(40);
        POSTING_DATE        : Date;
        CHARG               : String(10);
        WAREHOUSE_STATUS    : String(40);
        KUNNR               : String(10);
        @UI.HiddenFilter: true
        MATNR               : String(40);
        @UI.HiddenFilter: true
        MAKTX               : String(40);
        @UI.HiddenFilter: true
        TRAN_TYPE           : String(40);
        @UI.HiddenFilter: true
        MENGE               : Decimal(13,3);
        @UI.HiddenFilter: true
        CUSTOMER_NAME       : String(35);
        @UI.HiddenFilter: true
    key INV_MATDOC_ITEM     : String(15);
        @UI.HiddenFilter: true
        WERKS               : String(4);
        @UI.HiddenFilter: true
        LGORT               : String(4);
        @UI.HiddenFilter: true
        MFRNR               : String(10);
        @UI.HiddenFilter: true 
        NAME1_PLANT         : String(40);
        @UI.HiddenFilter: true
        MEINS               : String(3);
        @UI.HiddenFilter: true
        VFDAT               : String(8);              
}
// Inventory Audit Trail Product Code Filter
define view IATPRODUCTCODE as
    select from INVENTORYAUDITTRAIL distinct {
        key MFRNR_PROD_CODE
};
// Inventory Audit Trail Lot# filter
define view IATLOT as
    select from INVENTORYAUDITTRAIL distinct {
        key CHARG
};
// Inventory Audit Trail Warehouse Status filter
define view IATWAREHOUSE as
    select from INVENTORYAUDITTRAIL distinct {
        key WAREHOUSE_STATUS
};
// Inventory Audit Trail Customer/Supplier filter
define view IATCUSTSUPP as
    select from INVENTORYAUDITTRAIL distinct {
        key KUNNR
};

// Cash Journal
// Security attributes to match: ??
@cds.search: { BILL_TO, NAME1, VKORG, BKTXT, SGTXT, BUDAT, VBELN, FKDAT, BLART, AUGBL, SHIP_TO, BUKRS, MFRNR, BELNR, RLDNR, GJAHR, BSTKD }
@cds.persistence.exists
entity CASHJOURNAL //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        BILL_TO             : String(10);
        @UI.HiddenFilter: true
        NAME1               : String(35);
        @UI.HiddenFilter: true
        CAL_CASH_RECEIVED   : Decimal(23,2);
        @UI.HiddenFilter: true
        VKORG               : String(4);
        @UI.HiddenFilter: true
        BKTXT               : String(25);
        @UI.HiddenFilter: true
        SGTXT               : String(50);
        BUDAT               : String(8);
        @UI.HiddenFilter: true
        CAL_DISCOUNT        : Decimal(23,2);
        @UI.HiddenFilter: true
    key VBELN               : String(10);
        @UI.HiddenFilter: true
        NETWR               : Decimal(15,2);
        @UI.HiddenFilter: true
        FKDAT               : String(8);
        BLART               : String(2);
        @UI.HiddenFilter: true
        AUGBL               : String(10);
        @UI.HiddenFilter: true
        SHIP_TO             : String(10);
        @UI.HiddenFilter: true
    key BUKRS               : String(4);
        @UI.HiddenFilter: true
        MFRNR               : String(10);
        @UI.HiddenFilter: true
    key BELNR               : String(10);
        @UI.HiddenFilter: true
    key RLDNR               : String(2);
        @UI.HiddenFilter: true
    key GJAHR               : String(4);
        @UI.HiddenFilter: true
        BSTKD               : String(35);
}
// Cash Journal Invoice filter
define view BLARTS as
    select from CASHJOURNAL distinct {
        key BLART
};
// Cash Journal Bill TO filter
define view BILL_TOS as
    select from CASHJOURNAL distinct {
        key BILL_TO
};

// Inventory Snapshot
// Security attributes to match: ??
@cds.search: { SKU, PORDUCT_CODE, PRODUCT_DESCRIPTION, SIZE, LOT, WAREHOUSE_STATUS, UPC }
@cds.persistence.exists
entity INVENTORYSNAPSHOT //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        @UI.HiddenFilter: true
    key SKU                 : String(40);
        @UI.HiddenFilter: true
        PORDUCT_CODE        : String(40);
        PRODUCT_DESCRIPTION : String(40);
        @UI.HiddenFilter: true
        SIZE                : String(70);
        LOT                 : String(10);
        @UI.HiddenFilter: true
        EXPIRY_DATE         : String(8);
        WAREHOUSE_STATUS    : String(5000);
        REPORT_DATE         : Date;
        @UI.HiddenFilter: true
        ON_HAND             : Decimal(36,14);
        @UI.HiddenFilter: true
        DAYS_UNTIL_EXPIRY   : Integer;
        @UI.HiddenFilter: true
        UPC                 : String(18);
}
define view INVSNAPPRODDESC as
    select from INVENTORYSNAPSHOT distinct {
        key PRODUCT_DESCRIPTION
};
define view INVSNAPLOT as
    select from INVENTORYSNAPSHOT distinct {
        key LOT
};
define view INVSNAPWARESTAT as
    select from INVENTORYSNAPSHOT distinct {
        key WAREHOUSE_STATUS
};
// Inventory By Lot 
// Security attributes to match: ??
@cds.search: { SKU, PRODUCT_CODE, PRODUCT_DESCRIPTION, SIZE, LOT, UPC, CO, MANUFACTURER, WAREHOUSE }
@cds.persistence.exists
entity INVENTORYBYLOT //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        @UI.HiddenFilter: true
    key SKU                 : String(40);
        @UI.HiddenFilter: true
        PRODUCT_CODE        : String(99);
        PRODUCT_DESCRIPTION : String(40);
        @UI.HiddenFilter: true
        SIZE                : String(30);
        LOT                 : String(10);
        @UI.HiddenFilter: true
        EXPIRY_DATE         : String(8);
        @UI.HiddenFilter: true
        QTY_ON_HAND         : Decimal(36,14);
        @UI.HiddenFilter: true
        DAYS_UNTIL_EXPIRY   : Date;
        @UI.HiddenFilter: true
        UPC                 : String(18);
        @UI.HiddenFilter: true
        CO                  : String(4);
        @UI.HiddenFilter: true
        MANUFACTURER        : String(10);
        WAREHOUSE           : String(4);
}
// Inventory by Lot Product Code filter
define view INVBYLOTPRODUCTCODE as
    select from INVENTORYBYLOT distinct {
        key PRODUCT_CODE
};
// Inventory by Lot Lot filter
define view INVBYLOTLOT as
    select from INVENTORYBYLOT distinct {
        key LOT
};
// Inventory by Lot Warehouse filter
define view INVBYLOTWAREHOUSE as
    select from INVENTORYBYLOT distinct {
        key WAREHOUSE
};

// Accounts Receivable
// Security attributes to match
@cds.search: { VKORG, BILL_TO, NAME1, BSTKD, BELNR, ZTERM, STORE_SHIP_TO, BLART, MFRNR }
@cds.persistence.exists
entity OPENAR //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        CAL_1_30            : Decimal(24,2);
        CAL_31_60           : Decimal(24,2);
        CAL_61_90           : Decimal(24,2);
        CAL_AGE             : Integer;
        TSL                 : Decimal(23,2);
        VKORG               : String(4);
        CREDIT_LIMIT        : Decimal(15,2);
        CAL_CURRENT         : Decimal(23,2);
        BILL_TO             : String(10);
        NAME1               : String(35);
        BSTKD               : String(35);
        NETDT               : String(8);
    key BELNR               : String(10);
        FKDAT               : String(8);
        ZTERM               : String(4);
        NETWR               : Decimal(23,2);
        CAL_OVER_90         : Decimal(24,2);
        STORE_SHIP_TO       : String(10);
    key BLART               : String(2);
        MFRNR               : String(10);
}
define view OPENARCUSTOMER as
    select from OPENAR distinct {
        key NAME1
};
// Inventory Valuation
// Security attributes to match:??
@cds.search: { SKU, PRODUCT_CODE, PRODUCT_DESCRIPTION, CO }
@cds.persistence.exists
entity INVENTORYVALUATION //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        SKU                 : String(40);
    key PRODUCT_CODE        : String(99);
        PRODUCT_DESCRIPTION : String(40);
        UNIT_COST           : Decimal(11,2);
        TOTAL_COST          : Decimal(13,2);
        OPEN_STOCK          : Integer;
        QUARANTINE          : Integer;
        DAMAGE_DESTRUCTION  : Integer;
        RETAINS             : Integer;
        RETURNS_CAL         : Integer;
        RECALLS             : Integer;
    key CO                  : String(4);
    
}

define view INVVALPRODDESC as
    select from INVENTORYVALUATION distinct {
        key PRODUCT_DESCRIPTION
};

// Invoice History
// Security attributes to match: ??
@cds.search: { ORT01, VKORG, BKTXT, KUNNR, LFDAT, BELNR, BUDAT, NAME1, AUBEL, PSTLZ, REGIO, BSTKD, SHIP_TO, TRACKN, BLART, MFRNR }
@cds.persistence.exists
entity INVOICEHISTORY //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        @Aggregation.default: #SUM
        @Semantics.amount.currencyCode: 'currency'
        TSL_AMOUNT	: Decimal(23,2);
        ORT01	    : String(35);
        VKORG	    : String(4);
        BKTXT	    : String(25);
    key KUNNR       : String(10);
        LFDAT	    : String(8);
        CAL_GST	    : Decimal(23,2);
    key BELNR       : String(10);
        BUDAT	    : String(8);
        NAME1	    : String(35);
    key AUBEL       : String(10);
        PSTLZ	    : String(10);
        REGIO	    : String(3);
        CAL_PST	    : Decimal(23,2);
        BSTKD	    : String(35);
        SHIP_TO	    : String(10);
        TRACKN	    : String(35);
        BLART	    : String(2);
        MFRNR	    : String(10);
}

// Invoice History Customer filter
define view IHCUSTOMER as
    select from INVOICEHISTORY distinct {
        key NAME1
};
// Invoice History Ship To filter
define view IHSHIPTO as
    select from INVOICEHISTORY distinct {
        key SHIP_TO
};
// Invoice History Invoice # filter
define view IHINVOICE as
    select from INVOICEHISTORY distinct {
        key BELNR
};
// Invoice History Purchase Order filter
define view IHPO as
    select from INVOICEHISTORY distinct {
        key BSTKD
};
// Invoice History Type filter
define view IHTYPE as
    select from INVOICEHISTORY distinct {
        key BLART
};
// Invoice History Province filter
define view IHPROVINCE as
    select from INVOICEHISTORY distinct {
        key REGIO
};

// Sales by Product/Customer
// Security attributes to match: ??
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
    CO_VKORG
}
@cds.persistence.exists
entity SALESBYCURRENT //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key INVOICE_CREDIT_VBELN        : String(10);
        PURCHASE_ORDER_BSTKD        : String(35);
    key SKU_MATNR                   : String(40);
        PRODUCT_DESCRIPTION_MAKTX   : String(40);
        UNITS_PER_CASE              : Integer;
        QUANTITY_FKIMG              : Decimal(13,3);
        PRICE_CAL_UNIT_COST         : Decimal(11,2);
        AMOUNT_NETWR                : Decimal(15,2);
    key LOT_CHARG                   : String(10);
        TYPE_FKART                  : String(4);
        BILL_TO_KUNRE_ANA           : String(10);
        SHIP_TO_KUNWE_ANA           : String(10); 
        BILL_TO_NAME                : String(70);
        SHIP_TO_NAME                : String(70);
        ADDRESS_1                   : String(9);
        ADDRESS_2                   : String(9);
        POSTAL_CODE_PSTLZ           : String(10);
        CITY_ORT01                  : String(35);
        INVOICE_DATE_FKDAT          : Date;
        PROVINCE_REGIO              : String(3);
        EXPIRY_DATE_VFDAT           : Date;
        SPECIAL_HANDLING            : String(13);
        DELEVERY_DATE_VDATU         : Date;
        UPC_EAN11                   : String(18);
        WAREHOUSE                   : String(12);
        TRACKING_TRACKN             : String(35);
        COMMENT                     : String(13);
        CO_VKORG                    : String(4);
        CURRENT                     : String(1);
}
define view SBCINVOICE as
    select from SALESBYCURRENT distinct {
        key INVOICE_CREDIT_VBELN
};
define view SBCPRODDESC as
    select from SALESBYCURRENT distinct {
        key PRODUCT_DESCRIPTION_MAKTX
};
define view SBCTYPE as
    select from SALESBYCURRENT distinct {
        key TYPE_FKART
};
define view SBCWAREHOUSE as
    select from SALESBYCURRENT distinct {
        key WAREHOUSE
};
define view SBCLOT as
    select from SALESBYCURRENT distinct {
        key LOT_CHARG
};
define view SBCBILLTO as
    select from SALESBYCURRENT distinct {
        key BILL_TO_NAME
};
define view SBCSHIPTO as
    select from SALESBYCURRENT distinct {
        key SHIP_TO_NAME
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
@cds.persistence.exists
entity SALESBYHISTORICAL //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key INVOICE_CREDIT              : Integer64;
        INVOICE_DATE                : Date;
        PURCHASE_ORDER              : String(5000);
    key SKU                         : Integer64;
        PRODUCT_DESCRIPTION         : String(5000);
        UNITS_PER_CASE              : Integer64;
        QUANTITY                    : Integer64;
        PRICE                       : String(5000);
        AMOUNT                      : String(5000);
    key LOT                         : String(5000);
        EXPIRY_DATA                 : Date;
        TYPE                        : String(5000);
        BILL_TO                     : String(5000);
        SHIP_TO                     : String(5000); 
        BILL_TO_NAME                : String(5000);
        SHIP_TO_NAME                : String(5000);
        ADDRESS1                   : String(5000);
        ADDRESS2                   : String(5000);
        POSTAL_CODE                 : String(5000);
        CITY                        : String(5000);
        PROVANCE                    : String(5000);
        SPECIAL_HANDLING            : String(5000);
        UPC                         : Integer64;
        WAREHOUSE                   : String(5000);
        TRACKING                    : Decimal(38,19);
        DELEVERY_DATE               : Date;
        COMMENT                     : String(5000);
        CO                          : String(4);
        CURRENT                     : String(1);
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
entity CUSTOMERMASTER //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key KUNN2_BILLTO	: String(10);	
        STRAS_BILLTO	: String(35);     
        ORT01_BILLTO	: String(35);	 
        ERDAT_BILLTO	: String(8);	 
        NAME1_BILLTO	: String(35);	 
        PSTLZ_BILLTO	: String(10);  
        BEZEI_BILLTO	: String(20);	 
        KTEXT_BILLTO	: String(20);	 
    key VKORG	        : String(4);	
        CREDIT_LIMIT	: Decimal(15,2);	 
    key KUNN2_SHIPTO	: String(10);	
        STRAS_SHIPTO	: String(35);	 
        ORT01_SHIPTO	: String(35);	 
        ERDAT_SHIPTO	: String(8);	 
        NAME1_SHIPTO	: String(35);	 
        PSTLZ_SHIPTO	: String(10);	 
        BEZEI_SHIPTO	: String(20);	 
        KTEXT_SHIPTO	: String(20);	 
        CAL_CUST_STATUS	: String(1);	 
        CAL_TERM	    : String(4);	 
}
// Customer Master Bill To filter
define view KUNN2_BILLTO as
    select from CUSTOMERMASTER distinct {
        key KUNN2_BILLTO
};
// Customer Master Ship To filter
define view KUNN2_SHIPTO as
    select from CUSTOMERMASTER distinct {
        key KUNN2_SHIPTO
};
// Customer Master Customer Status filter
define view CAL_CUST_STATUS as
    select from CUSTOMERMASTER distinct {
        key CAL_CUST_STATUS
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
entity SHIPPINGHISTORY //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        CARRIER	            : String(10);
        VKORG	            : String(4);
        KUNAG	            : String(10);
        WADAT_IST	        : String(8);
        LFDAT	            : String(8);
        LFUHR	            : String(6);
    key VBELN	            : String(10);
        PSTLZ	            : String(10);
        TRK_DLVTO	        : String(40);
        KUNNR	            : String(10);
        NAME1	            : String(35);
        TRACKN	            : String(35);
        MFRNR	            : String(10);
        @UI.Hidden: true
        CAL_BILL_ITM_COUNT  : Integer;
        FKIMG               : Decimal(18,3);
        @UI.Hidden: true
        MEINS               : String(3); 
}
// Shipping History Invoice filter
define view SHINVOICE as
    select from SHIPPINGHISTORY distinct {
        key VBELN
};
// Shipping History Customer filter
define view SHCUSTOMER as
    select from SHIPPINGHISTORY distinct {
        key KUNAG
};
// Shipping History Ship To filter
define view SHSHIPTO as
    select from SHIPPINGHISTORY distinct {
        key KUNNR
};
// Shipping History Carrier filter
define view SHCARRIER as
    select from SHIPPINGHISTORY distinct {
        key CARRIER
};
// Shipping History Tracking # filter
define view SHTRACKING as
    select from SHIPPINGHISTORY distinct {
        key TRACKN
};

// Pricing
// Security attributes to match: ??
@cds.search: { 
    VKORG,
    KSCHL,
    VTEXT,
    MATNR,
    MAKTX,
    MFRNR
}
@cds.persistence.exists
entity PRICING  //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key VKORG :	String(4);
        KBETR :	Decimal(11,2);
        KSCHL : String(4);
        VTEXT :	String(20);
    key MATNR :	String(40);
        MAKTX :	String(40);
        MFRNR :	String(10);	
        KONWA : String(5); 
}
// Shipping History Carrier filter
define view PRICINGPRICEDESC as
    select from PRICING distinct {
        key VTEXT
};
// Shipping History Tracking # filter
define view PRICINGPRODUCTDESC as
    select from PRICING distinct {
        key MAKTX
};

// Open Orders
// Security attributes to match: ??
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
entity OPENORDERS //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
    key KUNNR	        : String(10);
        VDATU	        : String(10);
        CAL_NAME        : String(70);
    key VBELN	        : String(10);
        ERDAT   	    : String(8);	 
        GBSTK           : String(1);
        MATNR           : String(40); 
        MAKTX           : String(40);
        BSTKD           : String(35);
        KWMENG	        : Decimal(20,3);	 
        KUNWE_ANA	    : String(10);
        REGIO           : String(3);
        MFRNR           : String(10);
}

// Open Orders Product Description filter
define view OOPRODDESC as
    select from OPENORDERS distinct {
        key MAKTX
};
// Open Orders Customer filter
define view OOCUST as
    select from OPENORDERS distinct {
        key KUNNR
};
// Open Orders Ship To filter
define view OOSHIPTO as
    select from OPENORDERS distinct {
        key KUNWE_ANA
};
// Open Orders Province filter
define view OOPROVINCE as
    select from OPENORDERS distinct {
        key REGIO
};

action calculateTotals(filters: String) returns {
    totalOpenLines: Integer;
    totalKWMENG: Decimal(10,2);
};

// Returns
// Security attributes to match: ??
@cds.search: { 
    VKORG,	
    VBELN,
    KUNNR,
    NAME1,
    REGIO,
    AUGRU,
    VGBEL,
    BSTKD	 
}
@cds.persistence.exists
entity RETURNS //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        VKORG   : String(4);
    key VBELN	: String(10);
        NETWR   : Decimal(15,2);
        AUDAT   : String(8);
        KUNNR	: String(10);
        NAME1   : String(35);
        ERDAT   : String(8);
        REGIO   : String(3);
        AUGRU   : String(3);
        VGBEL   : String(10);
        BSTKD   : String(35);	 
}
//  Returns Customer filter
define view RETCUST as
    select from RETURNS distinct {
        key KUNNR
};
//  Returns Reason filter
define view RETREASON as
    select from RETURNS distinct {
        key AUGRU
};
//  Returns RGA filter
define view RETRGA as
    select from RETURNS distinct {
        key BSTKD
};

// Returns
// Security attributes to match: ??
@cds.search: { KUNRE_ANA, KUNWE_ANA, VKORG,	BSTKD, VBELN, MATNR, MAKTX, NAME1, MFRNR }
@cds.persistence.exists
entity BACKORDERS //@(restrict: [
//     { grant: 'READ', where: 'MANUFACTURER = $user.MANUFACTURER'  },
//     { grant: 'READ', to: 'Internal'}
// ])
{
        DATE_DIFF           : Integer;	 
    key KUNRE_ANA           : String(10);	
        UDATE               : String(8);	 
    key VKORG               : String(4);	
        BSTKD               : String(35);	 
        EXTENSION           : Decimal(38,21);	 
    key VBELN               : String(10);	
        ERDAT               : String(8);	 
        UNIT_PRICE          : Decimal(30,18);	 
    key MATNR               : String(40);	
        MAKTX               : String(40); 
        BACK_ORD_QTY        : Decimal(18,3);	 
    key KUNWE_ANA           : String(10);	
        NAME1               : String(35);	 
        MFRNR               : String(10);	 
        MEINS               : String(3);
}

//  Back Orders Product Name filter
define view BOPRODUCTDESC as
    select from BACKORDERS distinct {
        key MAKTX
};

//  Back Orders Bill To filter
define view BOBILLTO as
    select from BACKORDERS distinct {
        key KUNRE_ANA
};

//  Back Orders Ship To filter
define view BOSHIPTO as
    select from BACKORDERS distinct {
        key KUNWE_ANA
};









