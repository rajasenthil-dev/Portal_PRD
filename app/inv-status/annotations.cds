using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYSTATUS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            SKU_MATNR: true,
            PRODUCT_CODE: true,
            PRODUCT_DESCRIPTION: true,
            MANUFACTURER_MFRPN: true,
            SIZE: true,
            VKBUR: true,
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
                Value : QUALITY_HOLD,
                Label : 'Quality Hold',
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
                Value : INVENTORY_HOLD,
                Label : 'Inventory Hold',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : RELABEL_QTY,
                Label : 'Re-Label',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SAMPLE_QTY,
                Label : 'Sample',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT,
                Label : 'Base Unit of Measure',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : VKBUR,
                Label : 'Sales Office',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER_MFRPN,
                Label : 'Manufacturer',
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
    SIZE@(title: 'Size');
    PRODUCT_DESCRIPTION@(title: 'Product Description');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS@(title: 'Retains');
    QUALITY_HOLD@(title:'Quality Hold');
    RETURNS_CAL@(title: 'Returns');
    RECALLS@(title: 'Recalls');
    INVENTORY_HOLD@(title:'Inventory Hold');
    RELABEL_QTY@(title:'Re-Label');
    SAMPLE_QTY@(title:'Sample');
    UNIT@(title:'Base Unit of Measure');
    VKBUR@(title: 'Sales Office',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSTATUSVKBUR',
                Label : 'Warehouse/Status',
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
    MANUFACTURER_MFRPN@(title: 'Manufacturer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSTATUSMFRNR',
                Label : 'Warehouse/Status',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MANUFACTURER_MFRPN',
                        ValueListProperty : 'MANUFACTURER_MFRPN'
                    }
                ]
            },
        }
    ); 
};