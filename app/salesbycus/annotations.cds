using SALES as service from '../../srv/service';

annotate SALES.SALESBYCURRENT with @(
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
            WAREHOUSE:true, 
            TRACKING_TRACKN:true,  
            COMMENT:true, 
            CO_VKORG:true, 
            CURRENT:true 
        }
    },
    UI : {
        SelectionFields  : [
            INVOICE_CREDIT_VBELN,
            PRODUCT_DESCRIPTION_MAKTX,
            VTEXT_FKART,
            WAREHOUSE,
            LOT_CHARG,
            BILL_TO_KUNRE_ANA,
            BILL_TO_NAME,
            SHIP_TO_KUNWE_ANA,
            SHIP_TO_NAME,
            INVOICE_DATE_FKDAT,
            EXPIRY_DATE_VFDAT,
            DELEVERY_DATE_VDATU,
            CURRENT,
            MFRNR,
            CO_VKORG,
            VKBUR
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : CURRENT,
                Label : 'Current/Legacy',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
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
                Value : RBTXT,
                Label : 'Storage Conditions',
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
                Value : UNIT_PRICE,
                Label : 'Unit Price',
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
                Value : WAERK,
                Label : 'SD Document Currency',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : AUGRU_AUFT,
                Label : 'Order Reason',
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
                Value : VTEXT_FKART,
                Label : 'Type',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO_KUNRE_ANA,
                Label : 'Bill To #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_KUNWE_ANA,
                Label : 'Ship To #',
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
                Value : TBTXT,
                Label : 'Temp. Conditions',
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
                Value : WERKS,
                Label : 'Plant',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT_NAME,
                Label : 'Plant Name',
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
                Value : PATIENT_ID,
                Label : 'Patient Id',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRPN,
                Label : 'Manufacturer Part Number',
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
                Label : 'Sales Org.',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VKBUR,
                Label : 'Sales Office',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
        ],
    }, 
){
    INVOICE_CREDIT_VBELN@(
        title: 'Invoice/Credit #',
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCINVOICE',
                Label : 'Invoice #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'INVOICE_CREDIT_VBELN',
                        ValueListProperty : 'INVOICE_CREDIT_VBELN'
                    }
                ]
            },
        } 
        
    );
    PRODUCT_DESCRIPTION_MAKTX@(
        title: 'Product Description',
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCPRODDESC',
                Label : 'Product Description',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_DESCRIPTION_MAKTX',
                        ValueListProperty : 'PRODUCT_DESCRIPTION_MAKTX'
                    }
                ]
            },
        }
        
    );
    LOT_CHARG@(
        title: 'Lot #',
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCLOT',
                Label : 'Lot #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'LOT_CHARG',
                        ValueListProperty : 'LOT_CHARG'
                    }
                ]
            },
        }
        
    );
    VTEXT_FKART@( 
        title: 'Type',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCTYPE',
                Label : 'Type',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VTEXT_FKART',
                        ValueListProperty : 'VTEXT_FKART'
                    }
                ]
            },
        }
        
    );
    BILL_TO_KUNRE_ANA@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCBILLTOID',
                Label : 'Bill To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BILL_TO_KUNRE_ANA',
                        ValueListProperty : 'BILL_TO_KUNRE_ANA'
                    }
                ]
            },
        }
    );
    BILL_TO_NAME@(
        title: 'Bill To Name',
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCBILLTO',
                Label : 'Bill To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BILL_TO_NAME',
                        ValueListProperty : 'BILL_TO_NAME'
                    }
                ]
            },
        }
    );
    SHIP_TO_KUNWE_ANA@(
         Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCSHIPTOID',
                Label : 'Ship To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'SHIP_TO_KUNWE_ANA',
                        ValueListProperty : 'SHIP_TO_KUNWE_ANA'
                    }
                ]
            },
        }
    );
    SHIP_TO_NAME@(
        title: 'Ship To Name',
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCSHIPTO',
                Label : 'Ship To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'SHIP_TO_NAME',
                        ValueListProperty : 'SHIP_TO_NAME'
                    }
                ]
            },
        }
        
    );
    WAREHOUSE@(
        title: 'Warehouse',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCWAREHOUSE',
                Label : 'Warehouse',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'WAREHOUSE',
                        ValueListProperty : 'WAREHOUSE'
                    }
                ]
            },
        }
        
    );
    MFRNR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCMFRNR',
                Label : 'Manufacturer #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR',
                        ValueListProperty : 'MFRNR'
                    }
                ]
            },
        }
        
    );
    CO_VKORG@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCSALESORG',
                Label : 'Sales Org.',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CO_VKORG',
                        ValueListProperty : 'CO_VKORG'
                    }
                ]
            },
        }
        
    );
    VKBUR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SBCSALESOFFICE',
                Label : 'Sales Office',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VKBUR',
                        ValueListProperty : 'VKBUR'
                    }
                ]
            },
        }
        
    );
};



