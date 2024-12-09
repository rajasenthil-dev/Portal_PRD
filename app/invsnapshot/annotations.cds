using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYSNAPSHOT with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            SKU: true,
            PORDUCT_CODE: true, 
            PRODUCT_DESCRIPTION: true, 
            SIZE:true,
            LOT:true,
            WAREHOUSE_STATUS:true,
            UPC:true
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCT_DESCRIPTION, 
            LOT,
            WAREHOUSE_STATUS, 
            REPORT_DATE,
            
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : SKU,
                Label : 'SKU',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : PORDUCT_CODE,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SIZE,
                Label : 'Size',
                ![@HTML5.CssDefaults] : {width : '3rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LOT,
                Label : 'LOT',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : EXPIRY_DATE,
                Label : 'Expiry Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_STATUS,
                Label : 'Warehouse Status'
            },
            {
                $Type : 'UI.DataField',
                Value : ON_HAND,
                Label : 'On Hand'
            },
            {
                $Type : 'UI.DataField',
                Value : DAYS_UNTIL_EXPIRY,
                Label : 'Days Until Expiry'
            },
            {
                $Type : 'UI.DataField',
                Value : REPORT_DATE,
                Label : 'Report Date'
            },
            {
                $Type : 'UI.DataField',
                Value : UPC,
                Label : 'UPC'
            }
        ],
    },
    
    
)

{   
    SKU@(title: 'SKU');
    PORDUCT_CODE@(title: 'Product Code');
    PRODUCT_DESCRIPTION@(
        title: 'Product Description',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPPRODDESC',
                Label : 'Bill To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_DESCRIPTION',
                        ValueListProperty : 'PRODUCT_DESCRIPTION'
                    }
                ]
            },
        }      
        
    );
    SIZE@(title: 'Size');
    LOT@(
        title: 'Lot #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPLOT',
                Label : 'Bill To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'LOT',
                        ValueListProperty : 'LOT'
                    }
                ]
            },
        }      
        
    );
    EXPIRY_DATE@(title: 'Expiry Date');
    WAREHOUSE_STATUS@(
        title: 'Warehouse Status',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPWARESTAT',
                Label : 'Bill To Name',
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
    ON_HAND@(title: 'On Hand');
    DAYS_UNTIL_EXPIRY@(title: 'Days Until Expiry');
    REPORT_DATE@(title: 'Report Date');
    UPC@(title: 'UPC');
};