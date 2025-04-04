@cds.search: { PRODUCTSTANDARDID, PRODUCT, CATEGORY, MANUFACTURERNUMBER, SALESORG, CREATIONDATE, PRODUCTDESCRIPTION_EN, SIZEUOM }
@cds.persistence.exists
entity ITEMMASTER 
{
    key PRODUCT                 : String(40)    @title: 'SKU';
    key SALESORG                : String(4)     @title: 'Sales Org';
        CREATIONDATE            : String(8)     @title: 'Creation Date';
        DIN                     : String(70)    @title: 'DIN';
        GST_APPLICABLE          : String(1)     @title: 'GST Applicable';
        LOT_CONTROL_YN          : String(1)     @title: 'Lot Control Y/N';
        NARCOTIC_YN             : String(1)     @title: 'Narcotic Y/N';
        CATEGORY                : String(20)    @title: 'Category' @Search.defaultSearchElement;
        PRODUCTDESCRIPTION_EN   : String(40)    @title: 'Product Desc.';
        PRODUCTDESCRIPTION_FR   : String(40)    @title: 'Special Handling';
        PST_APPLICABLE          : String(1)     @title: 'PST Applicable';
        REFRIGERATED            : String(1)     @title: 'Refridgerated';
        UNITS_PER_CASE          : Decimal(5,0)  @title: 'Units Per Case';
        SIZEUOM                 : String(80)    @title: 'Size';
        PRODUCTSTANDARDID       : String(18)    @title: 'Product Code';
        MANUFACTURERNUMBER      : String(10)    @title: 'Manufacturer Number';
}
define view ITEMMASPD as
    select from ITEMMASTER distinct {
        key PRODUCTDESCRIPTION_EN
};
define view ITEMMASCATEGORY as
    select from ITEMMASTER distinct {
        key CATEGORY
};
@cds.search: { SKU_MATNR, PRODUCT_CODE, SIZE, MANUFACTURER_MFRPN, PRODUCT_DESCRIPTION, VKBUR }
@cds.persistence.exists
entity INVENTORYSTATUS 
{
        
    key SKU_MATNR                   : String(40)        @title : 'SKU';
        PRODUCT_CODE                : String(40)        @title : 'Product Code';
        SIZE                        : String(70)        @title : 'Size';
        PRODUCT_DESCRIPTION         : String(40)        @title : 'Product Desc.';
        OPEN_STOCK                  : Decimal(36,2)     @title : 'Open Stock';
        QUARANTINE                  : Decimal(36,2)     @title : 'Quarantine';
        DAMAGE_DESTRUCTION          : Decimal(36,2)     @title : 'Damage/Destruction';
        RETAINS                     : Decimal(36,2)     @title : 'Retains';
        QUALITY_HOLD                : Decimal(36,2)     @title : 'Quality Hold';
        RETURNS_CAL                 : Decimal(36,2)     @title : 'Returns';
        RECALLS                     : Decimal(36,2)     @title : 'Recalls';
        INVENTORY_HOLD              : Decimal(36,2)     @title : 'Inventory Hold';
        RELABEL_QTY                 : Decimal(36,2)     @title : 'Re-Lable';
        SAMPLE_QTY                  : Decimal(36,2)     @title : 'Samples';
        UNIT                        : String(3)         @title : 'Base Unit of Measure';
        VKBUR                       : String(4)         @title : 'Sales Office';
        MANUFACTURER_MFRPN          : String(40)        @title : 'Manufacturer Number';
}
define view INVSTATUSPRODUCTCODE as
    select from INVENTORYSTATUS distinct {
        key PRODUCT_CODE
};
define view INVSTATUSMFRNR as
    select from INVENTORYSTATUS distinct {
        key MANUFACTURER_MFRPN
};
define view INVSTATUSVKBUR as
    select from INVENTORYSTATUS distinct {
        key VKBUR
};
@cds.search: { MATNR, MAKTX, POSTING_DATE, CHARG, WAREHOUSE_STATUS, KUNNR, CUSTOMER_NAME, INV_MATDOC_ITEM, WERKS, LGORT, MFRNR, NAME1_PLANT }
@cds.persistence.exists
entity INVENTORYAUDITTRAIL
{
        MFRNR_PROD_CODE     : String(40)        @title : 'Product Code';
        POSTING_DATE        : Date              @title : 'Posting Date';
        CHARG               : String(10)        @title : 'Lot #';
        WAREHOUSE_STATUS    : String(40)        @title : 'Warehouse Status';
        KUNNR               : String(10)        @title : 'Customer/Supplier Number';
        MATNR               : String(40)        @title : 'SKU';
        MAKTX               : String(40)        @title : 'Product Desc.';
        TRAN_TYPE           : String(40)        @title : 'Transaction Type';
        MENGE               : Decimal(13,3)     @title : 'Quantity';
        CUSTOMER_NAME       : String(35)        @title : 'Customer/Supplier Name';
    key INV_MATDOC_ITEM     : String(15)        @title : 'Inv/Adj/Receipt Number';
        WERKS               : String(4)         @title : 'Plant';
        LGORT               : String(4)         @title : 'Storage Location';
        MFRNR               : String(10)        @title : 'Manufacturer Number';
        NAME1_PLANT         : String(40)        @title : 'Plant Name';
        MEINS               : String(3)         @title : 'Base Unit of Measure'; 
        VFDAT               : String(8)         @title : 'Expiry Date';              
}
define view IATPRODUCTCODE as
    select from INVENTORYAUDITTRAIL distinct {
        key MFRNR_PROD_CODE
};

define view IATLOT as
    select from INVENTORYAUDITTRAIL distinct {
        key CHARG
};

define view IATWAREHOUSE as
    select from INVENTORYAUDITTRAIL distinct {
        key WAREHOUSE_STATUS
};

define view IATCUSTSUPP as
    select from INVENTORYAUDITTRAIL distinct {
        key KUNNR
};

@cds.search: { BILL_TO, NAME1, VKORG, BKTXT, SGTXT, BUDAT, VBELN, FKDAT, BLART, AUBEL, SHIP_TO, BUKRS, MFRNR, BELNR, PRCTR, GJAHR, BSTKD }
@cds.persistence.exists
entity CASHJOURNAL 
{
        BILL_TO             : String(10)        @title : 'Bill To';
        NAME1               : String(35)        @title : 'Bill To Name';
        CAL_CASH_RECEIVED   : Decimal(23,2)     @title : 'Cash Received';
        VKORG               : String(4)         @title : 'Sales Org.';
        BKTXT               : String(25)        @title : 'Comment 1';
        SGTXT               : String(50)        @title : 'Comment 2';
        BUDAT               : String(8)         @title : 'Deposit Date';
        CAL_DISCOUNT        : Decimal(23,2)     @title : 'Discount';
    key VBELN               : String(10)        @title : 'Invoice Number';
        NETWR               : Decimal(15,2)     @title : 'Invoice Amount';
        FKDAT               : String(8)         @title : 'Invoice Date';
        BLART               : String(2)         @title : 'Payment Type';
        AUBEL               : String(10)        @title : 'Reference';
        SHIP_TO             : String(10)        @title : 'Ship To Code';
    key BUKRS               : String(4)         @title : 'Company Code';
        MFRNR               : String(10)        @title : 'Manufacturer Number';
    key BELNR               : String(10)        @title : 'Accounting Document';
    key GJAHR               : String(4)         @title : 'Fiscal Year';
        BSTKD               : String(35)        @title : 'Customer PO';
        PRCTR               : String(10)        @title : 'Profit Center';
}
define view BLARTS as
    select from CASHJOURNAL distinct {
        key BLART
};
define view BILL_TOS as
    select from CASHJOURNAL distinct {
        key BILL_TO
};

@cds.search: { MATNR, MFRPN, MAKTX, SIZE, CHARG, WAREHOUSE_STATUS, EAN11, MFRNR, VKORG, LGNUM }
@cds.persistence.exists
entity INVENTORYSNAPSHOT 
{
    key MATNR               : String(40)    @title: 'SKU';
    key WAREHOUSE_STATUS    : String(30)    @title: 'Warehouse Status';
        EAN11               : String(18)    @title: 'UPC';
        ON_HAND             : Decimal(36,2) @title: 'On Hand';
        MFRPN               : String(40)    @title: 'Product Code';
        DAYS_UNTIL_EXPIRY   : Integer       @title: 'Days Until Expiry';
    key REPORT_DATE         : Date          @title: 'Report Date';
    key VKORG               : String(4)     @title: 'Sales Org.';
    key LGNUM               : String(4)     @title: 'Warehouse Number/Warehouse Complex';
        UNIT                : String(3)     @title: 'Base Unit of Measure';
        MFRNR               : String(10)    @title: 'Manufacturer Number';
        SIZE                : String(70)    @title: 'Size';
        MAKTX               : String(40)    @title: 'Product Desc.';
    key CHARG               : String(10)    @title: 'Lot Number';
    key VFDAT               : String(8)     @title: 'Shelf Life Expiration or Best-Before Date';
        DIN                 : String(100)   @title: 'DIN';
        RBTXT               : String(20)    @title: 'Storage Condition Description';
        TBTXT               : String(60)    @title: 'Desctription of Temperature Conditions';
        CURRENT             : String(3)     @title: 'Current/Historical';
}
define view INVSNAPPROD as
    select from INVENTORYSNAPSHOT distinct {
        key MFRPN
};
define view INVSNAPPRODDESC as
    select from INVENTORYSNAPSHOT distinct {
        key MAKTX
};
define view INVSNAPLOT as
    select from INVENTORYSNAPSHOT distinct {
        key CHARG
};
define view INVSNAPWARESTAT as
    select from INVENTORYSNAPSHOT distinct {
        key WAREHOUSE_STATUS
};
define view INVSNAPMFRNR as
    select from INVENTORYSNAPSHOT distinct {
        key MFRNR
};
define view INVSNAPVKORG as
    select from INVENTORYSNAPSHOT distinct {
        key VKORG
};
@cds.search: { MATNR, WAREHOUSE_STATUS, EAN11, MFRPN, LGNUM, MFRNR, MAKTX, CHARG, PLANT, DIN, VKBUR }
@cds.persistence.exists
entity INVENTORYBYLOT 
{
        
    key MATNR                       : String(40)        @title : 'SKU';
        WAREHOUSE_STATUS            : String(4)         @title : 'Warehouse Status';
        EAN11                       : String(18)        @title : 'UPC';
        ON_HAND                     : Decimal(38,2)     @title : 'On Hand';
        MFRPN                       : String(40)        @title : 'Product Code';
        DAYS_UNTIL_EXPIRY           : Integer           @title : 'Days Until Expiry';
        LGNUM                       : String(4)         @title : 'Warehouse Number';
        UNIT                        : String(3)         @title : 'Base Unit of Measure';
        MFRNR                       : String(10)        @title : 'Manufacturer Number';
        SIZE                        : String(70)        @title : 'Size';
        MAKTX                       : String(40)        @title : 'Product Desc.';
        CHARG                       : String(10)        @title : 'Lot Number';
        VFDAT                       : String(8)         @title : 'Shelf Life or Best-Before Date';
        DIN                         : String(100)       @title : 'DIN';
        PLANT                       : String(18)        @title : 'Plant';
        VKBUR                       : String(4)         @title : 'Sales Office';
}

define view INVBYLOTPRODUCTCODE as
    select from INVENTORYBYLOT distinct {
        key MFRPN
};
define view INVBYLOTLOT as
    select from INVENTORYBYLOT distinct {
        key CHARG
};

define view INVBYLOTWAREHOUSE as
    select from INVENTORYBYLOT distinct {
        key WAREHOUSE_STATUS
};
define view INVBYLOTMFRNR as
    select from INVENTORYBYLOT distinct {
        key MFRNR
};
define view INVBYLOTVKBUR as
    select from INVENTORYBYLOT distinct {
        key VKBUR
};

@cds.search: { VKORG, BILL_TO, NAME1, BSTKD, BELNR, ZTERM, STORE_SHIP_TO, BLART, MFRNR }
@cds.persistence.exists
entity OPENAR 
{
        CAL_1_30            : Decimal(24,2)     @title : '1 to 30';
        CAL_31_60           : Decimal(24,2)     @title : '31 to 60';
        CAL_61_90           : Decimal(24,2)     @title : '61 to 90';
        CAL_AGE             : Integer           @title : 'Age';
        TSL                 : Decimal(23,2)     @title : 'Amount Paid';
        VKORG               : String(4)         @title : 'Sales Org.';
        CREDIT_LIMIT        : Decimal(15,2)     @title : 'Credit Limit';
        CAL_CURRENT         : Decimal(23,2)     @title : 'Current';
        BILL_TO             : String(10)        @title : 'Customer ID';
        NAME1               : String(35)        @title : 'Customer Name';
        BSTKD               : String(35)        @title : 'Customer PO';
        NETDT               : String(8)         @title : 'Due Date';
    key BELNR               : String(10)        @title : 'Invoice Number';
        FKDAT               : String(8)         @title : 'Invoice Date';
        ZTERM               : String(4)         @title : 'Invoice Terms';
        NETWR               : Decimal(23,2)     @title : 'Invoiced Amount';
        CAL_OVER_90         : Decimal(24,2)     @title : 'Over 90';
        STORE_SHIP_TO       : String(10)        @title : 'Store';
    key BLART               : String(2)         @title : 'Type';
        MFRNR               : String(10)        @title : 'Manufacturer Number';
}
define view OPENARCUSTOMER as
    select from OPENAR distinct {
        key NAME1
};
@cds.search: { PLANT, LGNUM, MATNR, MAKTX, MFRPN,VKBUR,MFRNR }
@cds.persistence.exists
entity INVENTORYVALUATION 
{
        PLANT                       : String(4)         @title : 'Plant';
        LGNUM                       : String(4)         @title : 'Warehouse Number';
        MATNR                       : String(18)        @title : 'SKU';
        MAKTX                       : String(40)        @title : 'Product Desc.';
    key MFRPN                       : String(40)        @title : 'Product Code';
        DIN                         : String(100)       @title : 'DIN';
        SIZE                        : String(70)        @title : 'Size';
        VKBUR                       : String(10)        @title : 'Sales Office';
        MFRNR                       : String(10)        @title : 'Manufacturer Number';
        WAERS                       : String(5)         @title : 'Currency Key';
        UNIT_PRICE                  : Decimal(11,2)     @title : 'Unit Price';
        TOTAL_COST                  : Decimal(38,2)     @title : 'Total Cost';
        AVAILABLE_COST              : Decimal(38,2)     @title : 'Open Stock';
        QUARANTINE_COST             : Decimal(38,2)     @title : 'Quarantine';
        RETAINS_COST                : Decimal(38,2)     @title : 'Retains';
        QUALITY_HOLD_COST           : Decimal(38,2)     @title : 'Quality Hold';
        RETURNS_COST                : Decimal(38,2)     @title : 'Returns';
        RECALL_COST                 : Decimal(38,2)     @title : 'Recalls';
        INVENTORY_HOLD_COST         : Decimal(38,2)     @title : 'Inventory Hold';
        RELABEL_COST                : Decimal(38,2)     @title : 'Re-Label';
        DAMAGE_DESTRUCTION_COST     : Decimal(38,2)     @title : 'Damage/Destruction';
        SAMPLE_COST                 : Decimal(38,2)     @title : 'Samples';
        UNIT                        : String(3)         @title : 'Base Unit of Measure';
        QUAN                        : Decimal(38,2)     @title : 'Total Quantity';   
}

define view INVVALPROD as
    select from INVENTORYVALUATION distinct {
        key MFRPN
};
define view INVVALPRODDESC as
    select from INVENTORYVALUATION distinct {
        key MAKTX
};
define view INVVALMFRNR as
    select from INVENTORYVALUATION distinct {
        key MFRNR
};
define view INVVALVKBUR as
    select from INVENTORYVALUATION distinct {
        key VKBUR
};

// Invoice History
// Security attributes to match: ??
@cds.search: { ORT01, VKORG, BKTXT, KUNNR, LFDAT, BELNR, BUDAT, NAME1, AUBEL, PSTLZ, REGIO, BSTKD, SHIP_TO, TRACKN, CURRENT, BLART, MFRNR }
@cds.persistence.exists
entity INVOICEHISTORY 
{
        @Aggregation.default: #SUM
        @Semantics.amount.currencyCode: 'currency'
        TSL_AMOUNT	: Decimal(23,2)     @title : '$ Amount';
        ORT01	    : String(35)        @title : 'City';
        VKORG	    : String(4)         @title : 'Sales Org.';
        BKTXT	    : String(25)        @title : 'Comment';
    key KUNNR       : String(10)        @title : 'Customer';
        LFDAT	    : String(8)         @title : 'Delivery Date';
        CAL_GST	    : Decimal(23,2)     @title : 'G.S.T.';
    key BELNR       : String(10)        @title : 'Invoice Number';
        BUDAT	    : String(8)         @title : 'Invoice Date';
        NAME1	    : String(35)        @title : 'Customer Name';
    key AUBEL       : String(10)        @title : 'Order Number';
        PSTLZ	    : String(10)        @title : 'Postal Code';
        REGIO	    : String(3)         @title : 'Province';
        CAL_PST	    : Decimal(23,2)     @title : 'P.S.T.';
        BSTKD	    : String(35)        @title : 'Purchase Order';
        SHIP_TO	    : String(10)        @title : 'Ship To';
        TRACKN	    : String(35)        @title : 'Tracking Number';
        ORDER_TYPE	: String(20)        @title : 'Type';
        CURRENT     : String(1)         @title : 'Current/Historical';
        MFRNR	    : String(10)        @title : 'Manufacturer Number';
}
define view IHCUSTOMERID as
    select from INVOICEHISTORY distinct {
        key KUNNR
};
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
        key ORDER_TYPE
};
// Invoice History Province filter
define view IHPROVINCE as
    select from INVOICEHISTORY distinct {
        key REGIO
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
        ADDRESS_1                   : String(35)            @title: 'Address 1';
        ADDRESS_2                   : String(40)            @title: 'Address 2';
        AMOUNT_NETWR                : Decimal(20,2)         @title: '$Amount';
        AUGRU_AUFT                  : String(3)             @title: 'Order Reason';
        BILL_TO_KUNRE_ANA           : String(10)            @title: 'Bill To';
        BILL_TO_NAME                : String(70)            @title: 'Bill To Name';
        CITY_ORT01                  : String(35)            @title: 'City';
        CO_VKORG                    : String(4)             @title: 'Sales Org.';
        COMMENT                     : String(13)            @title: 'Comment';
        CURRENT                     : String(3)             @title: 'Current/Historical';
        DELEVERY_DATE_VDATU         : String(8)             @title: 'Delivery Date';
        EXPIRY_DATE_VFDAT           : String(8)             @title: 'Expiry Date';
    key INVOICE_CREDIT_VBELN        : String(10)            @title: 'Invoice/Credit #';
        INVOICE_DATE_FKDAT          : String(8)             @title: 'Invoice Date';
    key LOT_CHARG                   : String(10)            @title: 'Lot #';
        MFRNR                       : String(10)            @title: 'Manufacturer Number';
        MFRPN                       : String(40)            @title: 'Manufacturer Part Number';
        PATIENT_ID                  : String(20)            @title: 'Patient Id';
        POSTAL_CODE_PSTLZ           : String(10)            @title: 'Postal Code';
        PRICE_CAL_UNIT_COST         : Decimal(11,2)         @title: 'Price';
        PRODUCT_DESCRIPTION_MAKTX   : String(40)            @title: 'Product Desctription';
        PROVINCE_REGIO              : String(3)             @title: 'Province';
        PURCHASE_ORDER_BSTKD        : String(35)            @title: 'Purchase Order';
        QUANTITY_FKIMG              : Decimal(13,3)         @title: 'Quantity';
        RBTXT                       : String(20)            @title: 'Storage Conditions';
        SHIP_TO_KUNWE_ANA           : String(10)            @title: 'Ship To';
        SHIP_TO_NAME                : String(70)            @title: 'Ship To Name';
    key SKU_MATNR                   : String(40)            @title: 'SKU';
        TBTXT                       : String(60)            @title: 'Temp. Conditions';
        TRACKING_TRACKN             : String(35)            @title: 'Tracking #';
        UNIT_PRICE                  : Decimal(32,2)         @title: 'Unit Price';
        UNITS_PER_CASE              : Integer               @title: 'Units Per Case';
        UPC_EAN11                   : String(18)            @title: 'UPC';
        VKBUR                       : String(4)             @title: 'Sales Office';
        VTEXT_FKART                 : String(40)            @title: 'Type';      
        WAERK                       : String(5)             @title: 'SD Document Currency';
        WAREHOUSE                   : String(12)            @title: 'Warehouse';
    key WERKS                       : String(4)             @title: 'Plant';
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
        key VTEXT_FKART
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
    key KUNN2_BILLTO	: String(10)        @title: 'Bill To';	
        STRAS_BILLTO	: String(35)        @title: 'Bill To Address';     
        ORT01_BILLTO	: String(35)        @title: 'Bill To City';	 
        ERDAT_BILLTO	: String(8)         @title: 'Bill To Created';	 
        NAME1_BILLTO	: String(35)        @title: 'Bill To Name';	 
        PSTLZ_BILLTO	: String(10)        @title: 'Bill To Postal Code';  
        BEZEI_BILLTO	: String(20)        @title: 'Bill To Province';	 
        KTEXT_BILLTO	: String(20)        @title: 'Bill To Type';	 
    key VKORG	        : String(4)         @title: 'Sales Org.';	
        CREDIT_LIMIT	: Decimal(15,2)     @title: 'Credit Limit';	 
    key KUNN2_SHIPTO	: String(10)        @title: 'Ship To';	
        STRAS_SHIPTO	: String(35)        @title: 'Ship To Address';	 
        ORT01_SHIPTO	: String(35)        @title: 'Ship To City';	 
        ERDAT_SHIPTO	: String(8)         @title: 'Ship To Created';	 
        NAME1_SHIPTO	: String(35)        @title: 'Ship To Name';	 
        PSTLZ_SHIPTO	: String(10)        @title: 'Ship To Postal Code';	 
        BEZEI_SHIPTO	: String(20)        @title: 'Ship To Province';	 
        KTEXT_SHIPTO	: String(20)        @title: 'Ship To Type';	 
        CAL_CUST_STATUS	: String(1)         @title: 'Status';	 
        CAL_TERM	    : String(4)         @title: 'Terms';	 
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
entity SHIPPINGHISTORY 
{
        CARRIER	            : String(10)        @title: 'Carrier';
        VKORG	            : String(4)         @title: 'Sales Org.';
        KUNAG	            : String(10)        @title: 'Customer';
        WADAT_IST	        : String(8)         @title: 'Date Shipped';
        LFDAT	            : String(8)         @title: 'Delivery Date';
        LFUHR	            : String(6)         @title: 'delivery Time';
    key VBELN	            : String(10)        @title: 'Invoice #';
        PSTLZ	            : String(10)        @title: 'Postal Code';
        TRK_DLVTO	        : String(40)        @title: 'Received';
        KUNNR	            : String(10)        @title: 'Ship To';
        NAME1	            : String(35)        @title: 'Ship To Name';
        TRACKN	            : String(35)        @title: 'Tracking #';
        MFRNR	            : String(10)        @title: 'Manufacturer Number';
        CAL_BILL_ITM_COUNT  : Integer           @title: 'Item Count';
        FKIMG               : Decimal(18,3)     @title: 'Invoice Quantity';
        MEINS               : String(3)         @title: 'Base Unit of Measure'; 
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

define view SHMFRNR as
    select from SHIPPINGHISTORY distinct {
        key MFRNR
};

define view SHVKORG as
    select from SHIPPINGHISTORY distinct {
        key VKORG
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
    key VKORG :	String(4)       @title: 'Sales Org.';
        KBETR :	Decimal(11,2)   @title: 'Price';
        KSCHL : String(4)       @title: 'Price Level Code';
        VTEXT :	String(20)      @title: 'Price Level Desc.';
    key MATNR :	String(40)      @title: 'Product';
        MAKTX :	String(40)      @title: 'Product Desc.';
        MFRNR :	String(10)      @title: 'Manufacturer Number';	
        KONWA : String(5)       @title: 'Currency'; 
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
    key KUNNR	        : String(10)        @title: 'Customer';
        VDATU	        : String(10)        @title: 'Delivery By Date';
        CAL_NAME        : String(70)        @title: 'Name';
    key VBELN	        : String(10)        @title: 'Order #';
        ERDAT   	    : String(8)         @title: 'Order Date';	 
        GBSTK           : String(1)         @title: 'Order Status';
        MATNR           : String(40)        @title: 'Product'; 
        MAKTX           : String(40)        @title: 'Product Desc.';
        BSTKD           : String(35)        @title: 'Purchase Order';
        KWMENG	        : Decimal(20,3)     @title: 'Quantity';	 
        KUNWE_ANA	    : String(10)        @title: 'Ship To';
        REGIO           : String(3)         @title: 'Province';
        MFRNR           : String(10)        @title: 'Manufacturer Number';
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
        ERDAT                   : String(8)         @title: 'Date Entered';
    key CUSTOMER_KUNNR          : String(10)        @title: 'Customer';
        CUSTOMER_NAME_NAME1     : String(35)        @title: 'Customer Name';
        PROVINCE_REGIO          : String(3)         @title: 'Province';
    key VBELN_VBAK              : String(10)        @title: 'RGA #';
        REASON_BEZEI            : String(40)        @title: 'Reason';
        REFERENCE_BSTKD         : String(35)        @title: 'Reference #';
    key VBELN_VBRK              : String(35)        @title: 'Credit #';
        FKDAT_ANA               : String(8)         @title: 'Credit Date';
        CREDIT_AMT_NETWR        : Decimal(15,2)     @title: 'Credit Amt $';
        CO_VKORG                : String(4)         @title: 'Sales Org.';
        MFRNR                   : String(10)        @title: 'Manufacturer Number';
        VKBUR                   : String(4)         @title: 'Sales Office';
        CURRENT                 : String(10)        @title: 'Current/Historical'; 
}
//  Returns Customer filter
define view RETCUST as
    select from RETURNS distinct {
        key CUSTOMER_NAME_NAME1
};
//  Returns Reason filter
define view RETREASON as
    select from RETURNS distinct {
        key REASON_BEZEI
};
//  Returns RGA filter
define view RETRGA as
    select from RETURNS distinct {
        key VBELN_VBAK
};
define view RETVKORG as
    select from RETURNS distinct {
        key CO_VKORG
};
define view RETMFRNR as
    select from RETURNS distinct {
        key MFRNR
};
define view RETVKBUR as
    select from RETURNS distinct {
        key VKBUR
};
@cds.search: { KUNRE_ANA, KUNWE_ANA, VKORG,	BSTKD, VBELN, MATNR, MAKTX, NAME1, MFRNR }
@cds.persistence.exists
entity BACKORDERS 
{
        DATE_DIFF           : Integer               @title: 'Age';	 
    key KUNRE_ANA           : String(10)            @title: 'Bill To';	
        UDATE               : String(8)             @title: 'Cancel Date';	 
    key VKORG               : String(4)             @title: 'Sales Org.';	
        BSTKD               : String(35)            @title: 'Customer PO';	 
        EXTENSION           : Decimal(38,21)        @title: 'Extension';	 
    key VBELN               : String(10)            @title: 'Order #';	
        ERDAT               : String(8)             @title: 'Order Date';	 
        UNIT_PRICE          : Decimal(30,18)        @title: 'Price';	 
    key MATNR               : String(40)            @title: 'Product';	
        MAKTX               : String(40)            @title: 'Product Desc.'; 
        BACK_ORD_QTY        : Decimal(18,3)         @title: 'Quantity';	 
    key KUNWE_ANA           : String(10)            @title: 'Ship To';	
        NAME1               : String(35)            @title: 'Ship To Name';	 
        MFRNR               : String(10)            @title: 'Manufacturer Number';	 
        MEINS               : String(3)             @title: 'Base Unit of Measure';
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
define view BOMFRNR as
    select from BACKORDERS distinct {
        key MFRNR
};
define view BOVKORG as
    select from BACKORDERS distinct {
        key VKORG
};

@cds.persistence.exists
entity MAINPAGESUMMARY 
{
        UNITS_SHIPPED_FKIMG         : Decimal(23,3);
        TOTAL_SALES_AMOUNT_NETWR    : Decimal(20,2);
        INVOICES                    : Integer;
        YEAR_CAL                    : String(4);
    key MANUFACTURER_MFRNR          : String(10);
    
}

define view MPSYEAR as
    select from MAINPAGESUMMARY distinct {
        key YEAR_CAL
};

@cds.persistence.exists
entity MAINPAGEINVENTORY
{
    key SKU_MATNR       : String(40);
    QUAN_AVAILABLE_QUANTITY  : Decimal(38, 2);
    OPEN_STOCK          : Decimal(38, 2);
    QUARANTINE          : Decimal(38, 2);
    RETAINS             : Decimal(38, 2);
    QUALITY_HOLD        : Decimal(38, 2);
    RETURNS_CAL         : Decimal(38, 2);
    RECALLS             : Decimal(38, 2);
    INVENTORY_HOLD      : Decimal(38, 2);
    RELABEL_QTY         : Decimal(38, 2);	
    DAMAGE_DESTRUCTION  : Decimal(38, 2);
    SAMPLE_QTY          : Decimal(38, 2); 
    MANUFACTURER_MFRPN  : String(10);
    
}

@cds.persistence.exists
entity MAINPAGEUNIT 
{
        CALYEAR             : Integer;
    key MFRNR               : String(10);
        CALMONTH            : String;
        QTY_CURRENT         : Decimal(18, 3);
        PREVIOUS_MONTH      : Integer;	
        QTY_DIFF            : Decimal(18, 2);
        PERCENTAGE_DIFF     : Decimal(38, 3); 
        MEINS               : String(3);
        QTY_PREVIOUS        : Decimal(18, 3);    
}

define view MPUYEAR as
    select from MAINPAGEUNIT distinct {
        key CALYEAR
};

using {cuid} from '@sap/cds/common';
entity MediaFile : cuid {
        @Core.ContentDisposition.Filename : fileName
        @Core.MediaType                   : mediaType
        content                           : LargeBinary;
        fileName                          : String;
        @Core.IsMediaType                 : true
        mediaType                         : String;
        url                               : String;
        manufacturerNumber                : String(50);
        MFGName                           : String(255);
}



















