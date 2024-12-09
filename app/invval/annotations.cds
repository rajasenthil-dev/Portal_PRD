using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYVALUATION with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            SKU: true,
            PRODUCT_CODE: true,
            PRODUCT_DESCRIPTION: true,            
            CO: true,
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCT_DESCRIPTION
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : SKU,
                Label : 'SKU'

            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_CODE,
                Label : 'Product Code'
                
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '20rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT_COST,
                Label : 'Unit Cost',
                ![@HTML5.CssDefaults] : {width : '4.65rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TOTAL_COST,
                Label : 'Total Cost',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : OPEN_STOCK,
                Label : 'Open Stock',
                ![@HTML5.CssDefaults] : {width : '5.5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : QUARANTINE,
                Label : 'Quarantine',
                ![@HTML5.CssDefaults] : {width : '5.75rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DAMAGE_DESTRUCTION,
                Label : 'Damage/Destruction',
                ![@HTML5.CssDefaults] : {width : '9rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : RETAINS,
                Label : 'Retains',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : RETAINS,
                Label : 'Retains',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : RETURNS_CAL,
                Label : 'Returns',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : RECALLS,
                Label : 'Recalls',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CO,
                Label : 'CO',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            }
        ],
    },
){
    SKU@(title: 'SKU');
    PRODUCT_CODE@( title: 'Product Code');
    PRODUCT_DESCRIPTION@(
        title: 'Product Description',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALPRODDESC',
                Label : 'Warehouse/Status',
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
    UNIT_COST@(title: 'Unit Cost');
    TOTAL_COST@(title: 'Total Cost');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS@(title: 'Retains');
    RETURNS_CAL@(title: 'Returns');
    RECALLS@(title: 'Recalls');
    CO@(title: 'CO');   
};