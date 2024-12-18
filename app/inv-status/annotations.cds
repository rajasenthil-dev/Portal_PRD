using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYSTATUS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
              SKU_MATNR: true,
                PRODUCT_CODE: true,
                PRODUCTDESCRIPTION_EN: true,
                MANUFACTURER: true,
                SIZE: true,
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
                Value : SKU_MATNR,
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
                Value : CON_SIZE_UOM_SIZE,
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
                Value : SALES_ORGANIZATION_VKORG,
                Label : 'Sales Org',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SALES_OFFICE_VKBUR,
                Label : 'Sales Office',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER_MFRPN,
                Label : 'Manufacturer',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PROFIT_CENTER_PRCTR,
                Label : 'Profit Center',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    SKU_MATNR@(title: 'SKU');
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
    CON_SIZE_UOM_SIZE@(title: 'Size');
    PRODUCTDESCRIPTION_EN@(title: 'Product Description');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS_1@(title: 'Retains');
    RETURNS_CAL@(title: 'Returns');
    RECALLS@(title: 'Recalls');
    SALES_ORGANIZATION_VKORG@(title: 'Sales Org');
    SALES_OFFICE@(title: 'Sales Office');
    MANUFACTURER@(title: 'Manufacturer'); 
    PROFIT_CENTER@(title: 'Profit Center'); 
};