using INVENTORY.INVENTORYAUDITTRAIL as service from '../../srv/service';

annotate INVENTORY.INVENTORYAUDITTRAIL with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            MATNR: true,
            MFRNR_PROD_CODE: true,
            MAKTX: true, 
            CHARG: true,
            POSTING_DATE: true, 
            WAREHOUSE_STATUS:true, 
            KUNNR:true, 
            CUSTOMER_NAME:true, 
            INV_MATDOC_ITEM:true, 
            WERKS:true, 
            NAME1_PLANT: true,
            LGORT:true, 
            MFRNR:true
        }
    },
    UI : {
        SelectionFields  : [
            MFRNR_PROD_CODE,
            POSTING_DATE,
            CHARG, 
            WAREHOUSE_STATUS, 
            KUNNR
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'Material Number (SKU)',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_PROD_CODE,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : POSTING_DATE,
                Label : 'Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TRAN_TYPE,
                Label : 'Transaction Type',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MENGE,
                Label : 'Quantity',
                ![@HTML5.CssDefaults] : {width : '6rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MEINS,
                Label : 'Unit of Measure',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CHARG,
                Label : 'Lot #',
                ![@HTML5.CssDefaults] : {width : '4rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VFDAT,
                Label : 'Expiry Date'
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_STATUS,
                Label : 'Warehouse Status',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : 'Customer/Supplier #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_NAME,
                Label : 'Customer/Supplier Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : INV_MATDOC_ITEM,
                Label : 'Inv/Adj/Receipt #',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1_PLANT,
                Label : 'Plant Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LGORT,
                Label : 'Storage Location',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer'
            }
        ],
    },
    
)

{   
    MATNR@(title: 'Material Number (SKU)');
    MFRNR_PROD_CODE@(
        title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATPRODUCTCODE',
                Label : 'Product Code',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR_PROD_CODE',
                        ValueListProperty : 'MFRNR_PROD_CODE'
                    }
                ]
            },
        } 
    );
    MAKTX@(title: 'Product Description');
    POSTING_DATE@(title: 'Date');
    TRAN_TYPE@(title: 'Transaction Type');
    MENGE@(title: 'Quantity');
    CHARG@(
        title: 'Lot #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATLOT',
                Label : 'Lot #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CHARG',
                        ValueListProperty : 'CHARG'
                    }
                ]
            },
        }    
    );
    VFDAT@(title: 'Expiry Date');
    WAREHOUSE_STATUS@(
        title: 'Warehouse Status',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATWAREHOUSE',
                Label : 'Warehouse/Status',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'WAREHOUSE_STATUS',
                        ValueListProperty : 'WAREHOUSE_STATUS'
                    }
                ]
            },
        }     
    );
    KUNNR@(
        title: 'Customer/Supplier #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATCUSTSUPP',
                Label : 'Customer/Supplier #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNNR',
                        ValueListProperty : 'KUNNR'
                    }
                ]
            },
        }     
    );
    CUSTOMER_NAME@(title: 'Customer/Supplier Name');
    INV_MATDOC_ITEM@(title: 'Inv/Adj/Receipt #');
    WERKS@(title: 'Plant');
    NAME1_PLANT@(title: 'Plant Name');
    LGORT@(title: 'Storage Location');
    MFRNR@(title: 'Manufacturer'); 
};