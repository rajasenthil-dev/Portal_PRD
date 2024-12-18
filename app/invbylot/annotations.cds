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
            PRODUCT_CODE_1, 
            LOT_CHARG,
            WAREHOUSE_STATUS
            
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
                Value : PRODUCT_CODE_1,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : PRODUCT_DESCRIPTION,
            //     Label : 'Product Description',
            //     ![@HTML5.CssDefaults] : {width : '10rem'}
                
            // },
            {
                $Type : 'UI.DataField',
                Value : SIZE,
                Label : 'Size',
                ![@HTML5.CssDefaults] : {width : '3rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LOT_CHARG,
                Label : 'LOT',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : EXPIRY_DATE_VFDAT,
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
                Value : OPEN_STOCK,
                Label : 'Open Stock'
            },
            {
                $Type : 'UI.DataField',
                Value : QUARANTINE,
                Label : 'Quarantine'
            },
            {
                $Type : 'UI.DataField',
                Value : DAMAGE_DESTRUCTION,
                Label : 'Damage Destruction'
            },
            {
                $Type : 'UI.DataField',
                Value : RETAINS,
                Label : 'Retains'
            },
            {
                $Type : 'UI.DataField',
                Value : RETURNS_CAL,
                Label : 'Returns'
            },
            {
                $Type : 'UI.DataField',
                Value : RECALLS,
                Label : 'Recalls'
            },
            {
                $Type : 'UI.DataField',
                Value : SALES_ORGANIZATION_VKORG,
                Label : 'Sales Organization'
            },
            {
                $Type : 'UI.DataField',
                Value : SALES_OFFICE_VKBUR,
                Label : 'Sales Office'
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER_MFRPN,
                Label : 'Manufacturer'
            },
            {
                $Type : 'UI.DataField',
                Value : PROFIT_CENTER_PRCTR,
                Label : 'Profit Center'
            }

        ],
    },
    
    
)

{   
    SKU@(title: 'SKU');
    PRODUCT_CODE_1@(
        title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTPRODUCTCODE',
                Label : 'Product Code',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_CODE_1',
                        ValueListProperty : 'PRODUCT_CODE_1'
                    }
                ]
            },
        } 
    
    );
    // PRODUCT_DESCRIPTION@(title: 'Product Description');
    SIZE@(title: 'Size');
    LOT_CHARG@(
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
                        LocalDataProperty : 'LOT_CHARG',
                        ValueListProperty : 'LOT_CHARG'
                    }
                ]
            },
        } 
    
    );
    EXPIRY_DATE_VFDAT@(title: 'Expiry Date');
    WAREHOUSE_STATUS@(
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
                        LocalDataProperty : 'WAREHOUSE_STATUS',
                        ValueListProperty : 'WAREHOUSE_STATUS'
                    }
                ]
            },
        } 
    
    );
    QTY_ON_HAND@(title: 'On Hand');
    DAYS_UNTIL_EXPIRY@(title: 'Report Date');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS@(title: 'Retains');
    RETURNS_CAL@(title: 'Returs');
    RECALLS@(title: 'Recalls');
    SALES_ORGANIZATION_VKORG@(title: 'Sales Org');
    SALES_OFFICE_VKBUR@(title: 'Sales Office');
    MANUFACTURER_MFRPN@(title:'Manufacturer');
    PROFIT_CENTER_PRCTR@(title: 'Profit Center');
};