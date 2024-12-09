using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYSTATUS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
              SKU: true,
                PRODUCT_CODE: true,
                PRODUCT_DESCRIPTION: true,
                MANUFACTURER: true,
                SIZE: true,
                WAREHOUSE: true,
                CO: true,
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCT_CODE
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : SKU,
                Label : 'SKU',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_CODE,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SIZE,
                Label : 'Size',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '20rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : OPEN_STOCK,
                Label : 'Open Stock',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : QUARANTINE,
                Label : 'Quarantine',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : DAMAGE_DESTRUCTION,
                Label : 'Damage/Destruction',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : RETAINS,
                Label : 'Retains',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : RETURNS_CAL,
                Label : 'Returns',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : RECALLS,
                Label : 'Recalls',
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
                Value : CO,
                Label : 'CO',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER,
                Label : 'Manufacturer',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    SKU@(title: 'SKU');
    PRODUCT_CODE@(
        title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSTATUSPRODUCTCODE',
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
    SIZE@(title: 'Size');
    PRODUCT_DESCRIPTION@(title: 'Product Description');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS@(title: 'Retains');
    RETURNS_CAL@(title: 'Returns');
    RECALLS@(title: 'Recalls');
    WAREHOUSE@(title: 'Warehouse');
    CO@(title: 'CO');
    MANUFACTURER@(title: 'Manufacturer'); 
};