using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYBYLOT with @(
    odata: {
        filterable: {
            SKU: true,
            PRODUCT_CODE: true, 
            PRODUCT_DESCRIPTION: true, 
            SIZE:true,
            LOT:true,
            WAREHOUSE:true,
            UPC:true,
            CO: true,
            MANUFACTURER: true
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCT_CODE, 
            LOT,
            WAREHOUSE
            
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
                Value : PRODUCT_CODE,
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
                Value : WAREHOUSE,
                Label : 'Warehouse Status'
            },
            {
                $Type : 'UI.DataField',
                Value : QTY_ON_HAND,
                Label : 'Qty On Hand'
            },
            {
                $Type : 'UI.DataField',
                Value : DAYS_UNTIL_EXPIRY,
                Label : 'Days Until Expiry',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UPC,
                Label : 'UPC'
            },
            {
                $Type : 'UI.DataField',
                Value : CO,
                Label : 'CO.'
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER,
                Label : 'Manufacturer'
            }
        ],
    },
    
    
)

{   
    SKU@(title: 'SKU');
    PRODUCT_CODE@(
        title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTPRODUCTCODE',
                Label : 'Warehouse/Status',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_CODE',
                        ValueListProperty : 'PRODUCT_CODE'
                    }
                ]
            },
        } 
    
    );
    PRODUCT_DESCRIPTION@(title: 'Product Description');
    SIZE@(title: 'Size');
    LOT@(
        title: 'Lot #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTLOT',
                Label : 'Warehouse/Status',
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
    WAREHOUSE@(
        title: 'Warehouse Status',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTWAREHOUSE',
                Label : 'Warehouse/Status',
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
    QTY_ON_HAND@(title: 'On Hand');
    DAYS_UNTIL_EXPIRY@(title: 'Report Date');
    UPC@(title: 'UPC');
    CO@(title: 'CO.');
    MANUFACTURER@(title:'Manufacturer');
};