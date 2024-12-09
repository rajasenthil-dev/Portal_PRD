using VDSP as service from '../../srv/service';

annotate VDSP.SALESBYCURRENT with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            INVOICE_CREDIT_VBELN:true, 
            PURCHASE_ORDER_BSTKD:true, 
            SKU_MATNR:true, 
            PRODUCT_DESCRIPTION_MAKTX:true, 
            LOT_CHARG:true,
            TYPE_FKART:true, 
            BILL_TO_KUNRE_ANA:true, 
            SHIP_TO_KUNWE_ANA:true, 
            BILL_TO_NAME:true, 
            SHIP_TO_NAME:true, 
            ADDRESS_1:true, 
            ADDRESS_2:true, 
            POSTAL_CODE_PSTLZ:true, 
            CITY_ORT01:true, 
            PROVINCE_REGIO:true, 
            SPECIAL_HANDLING:true, 
            UPC_EAN11:true, 
            WAREHOUSE:true, 
            TRACKING_TRACKN:true,  
            COMMENT:true, 
            CO_VKORG:true, 
            CURRENT:true,
            INVOICE_DATE_FKDAT:true,
            EXPIRY_DATE_VFDAT:true,
            DELEVERY_DATE_VDATU:true   
        }
    },
    UI : {
        SelectionFields  : [
            INVOICE_CREDIT_VBELN,
            PRODUCT_DESCRIPTION_MAKTX,
            TYPE_FKART,
            WAREHOUSE,
            LOT_CHARG,
            BILL_TO_KUNRE_ANA,
            SHIP_TO_KUNWE_ANA,
            INVOICE_DATE_FKDAT,
            EXPIRY_DATE_VFDAT,
            DELEVERY_DATE_VDATU
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : INVOICE_CREDIT_VBELN,
                Label : 'Invoice/Credit #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : INVOICE_DATE_FKDAT,
                Label : 'Invoice Date',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PURCHASE_ORDER_BSTKD,
                Label : 'Purchase Order',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SKU_MATNR,
                Label : 'SKU #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION_MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UNITS_PER_CASE,
                Label : 'Units Per Case',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : QUANTITY_FKIMG,
                Label : 'Quantity',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PRICE_CAL_UNIT_COST,
                Label : 'Price',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : AMOUNT_NETWR,
                Label : '$ Amount',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LOT_CHARG,
                Label : 'Lot #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : EXPIRY_DATE_VFDAT,
                Label : 'Expiry Date',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TYPE_FKART,
                Label : 'Type',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO_KUNRE_ANA,
                Label : 'Bill To',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_KUNWE_ANA,
                Label : 'Ship To',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO_NAME,
                Label : 'Bill To Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_NAME,
                Label : 'Ship To Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : ADDRESS_1,
                Label : 'Address 1',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : ADDRESS_2,
                Label : 'Address 2',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CITY_ORT01,
                Label : 'City',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : POSTAL_CODE_PSTLZ,
                Label : 'Postal Code',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PROVINCE_REGIO,
                Label : 'Province',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SPECIAL_HANDLING,
                Label : 'Special Handling',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UPC_EAN11,
                Label : 'UPC',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE,
                Label : 'Warehouse',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TRACKING_TRACKN,
                Label : 'Tracking #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DELEVERY_DATE_VDATU,
                Label : 'Delivery Date',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : COMMENT,
                Label : 'Comment',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CO_VKORG,
                Label : 'CO.',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
        ],
    }, 
){
    INVOICE_CREDIT_VBELN@(
        title: 'Invoice/Credit #'
        
    );
    INVOICE_DATE_FKDAT@(title: 'Invoice Date');
    PURCHASE_ORDER_BSTKD@(title: 'Purchase Order');
    SKU_MATNR@(title: 'SKU #');
    PRODUCT_DESCRIPTION_MAKTX@(
        title: 'Product Description'
        
    );
    UNITS_PER_CASE@(title: 'Units Per Case');
    QUANTITY_FKIMG@(title: 'Quantity');
    PRICE_CAL_UNIT_COST@(title: 'Price');
    AMOUNT_NETWR@(title: '$Amount');
    LOT_CHARG@(
        title: 'Lot #'
        
    );
    EXPIRY_DATE_VFDAT@(title: 'Expiry Date');
    TYPE_FKART@( 
        title: 'Type'
        
    );
    BILL_TO_KUNRE_ANA@(title: 'Bill To');
    SHIP_TO_KUNWE_ANA@(title: 'Ship To');
    BILL_TO_NAME@(
        title: 'Bill To Name'
        
    );
    SHIP_TO_NAME@(
        title: 'Ship To Name'
        
    );
    ADDRESS_1@(title: 'Address 1');
    ADDRESS_2@(title: 'Address 2');
    CITY_ORT01@(title: 'City');
    POSTAL_CODE_PSTLZ@(title: 'Postal Code');
    PROVINCE_REGIO@(title: 'Province');
    SPECIAL_HANDLING@(title: 'Special Handling');
    UPC_EAN11@(title: 'UPC');
    WAREHOUSE@(
        title: 'Warehouse'
        
    );
    TRACKING_TRACKN@(title: 'Tracking #');
    DELEVERY_DATE_VDATU@(title: 'Delivery Date');
    COMMENT@(title: 'Comment');
    CO_VKORG@(title: 'Co.');
};



