using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYVALUATION with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            SKU_MATNRU: true,
            PRODUCT_CODE: true,
            PRODUCT_DESCRIPTION_NORMT: true,            
            CO_VKORG: true,
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCT_CODE,
            PRODUCT_DESCRIPTION_NORMT
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : SKU_MATNR,
                Label : 'SKU'

            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_CODE,
                Label : 'Product Code'
                
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION_NORMT,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '20rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT_COST_CAL_UNIT_COST,
                Label : 'Unit Cost',
                ![@HTML5.CssDefaults] : {width : '4.65rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TOTAL_COST_SALK3,
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
                Value : RETURNS_CAL,
                Label : 'Returns',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CO_VKORG,
                Label : 'CO',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SALES_OFFICE_VKBUR,
                Label : 'Sales Office',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER_MFRNR,
                Label : 'Manufacturer Number',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PROFIT_CENTER_PRCTR,
                Label : 'Profit Center',
                ![@HTML5.CssDefaults] : {width : '7rem'}
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
                CollectionPath : 'INVVALPROD',
                Label : 'Product Code',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_CODE',
                        ValueListProperty : 'PRODUCT_CODE'
                    }
                ]
            },
        } );
    PRODUCT_DESCRIPTION_NORMT@(
        title: 'Product Description',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALPRODDESC',
                Label : 'Product Description',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCT_DESCRIPTION_NORMT',
                        ValueListProperty : 'PRODUCT_DESCRIPTION_NORMT'
                    }
                ]
            },
        } 
    );
    UNIT_COST_CAL_UNIT_COST@(title: 'Unit Cost');
    TOTAL_COST_SALK3@(title: 'Total Cost');
    OPEN_STOCK@(title: 'Open Stock');
    QUARANTINE@(title: 'Quarantine');
    DAMAGE_DESTRUCTION@(title: 'Damage/Destruction');
    RETAINS@(title: 'Retains');
    RETURNS_CAL@(title: 'Returns');
    CO_VKORG@(title: 'CO');  
    SALES_OFFICE_VKBUR@(title: 'Sales Office');
    MANUFACTURER_MFRNR@(title: 'Manufacturer Number');
    PROFIT_CENTER_PRCTR@(title: 'Profit Center'); 
};