using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYVALUATION with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            PLANT: true,
            LGNUM: true,
            MATNR: true,            
            MAKTX: true,
            MFRPN: true,
            MFRNR: true,
            VKBUR: true
        }
    },
    UI : {
        SelectionFields  : [
            MFRPN,
            MAKTX
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'SKU'

            },
            {
                $Type : 'UI.DataField',
                Value : MFRPN,
                Label : 'Product Code'
                
            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '20rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT,
                Label : 'Plant',
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT_PRICE,
                Label : 'Unit Price'
            },
            {
                $Type : 'UI.DataField',
                Value : TOTAL_COST,
                Label : 'Total Cost'
            },
            {
                $Type : 'UI.DataField',
                Value : AVAILABLE_COST,
                Label : 'Open Stock'
            },
            {
                $Type : 'UI.DataField',
                Value : QUARANTINE_COST,
                Label : 'Quarantine'
            },
            {
                $Type : 'UI.DataField',
                Value : DAMAGE_DESTRUCTION_COST,
                Label : 'Damage/Destruction'
            },
            {
                $Type : 'UI.DataField',
                Value : RETAINS_COST,
                Label : 'Retains'
            },
            {
                $Type : 'UI.DataField',
                Value : QUALITY_HOLD_COST,
                Label : 'Quality Hold'
            },
            {
                $Type : 'UI.DataField',
                Value : RETURNS_COST,
                Label : 'Returns'
            },
            {
                $Type : 'UI.DataField',
                Value : RECALL_COST,
                Label : 'Recalls'
            },
            {
                $Type : 'UI.DataField',
                Value : INVENTORY_HOLD_COST,
                Label : 'Inventory Hold'
            },
            {
                $Type : 'UI.DataField',
                Value : RELABEL_COST,
                Label : 'Re-labels'
            },
            {
                $Type : 'UI.DataField',
                Value : SAMPLE_COST,
                Label : 'Samples'
            },
            {
                $Type : 'UI.DataField',
                Value : VKBUR,
                Label : 'Sales Office'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer Number'
            }
        ],
    },
){
    MATNR@(title: 'SKU');
    MFRPN@( 
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
                        LocalDataProperty : 'MFRPN',
                        ValueListProperty : 'MFRPN'
                    }
                ]
            },
        } );
    MAKTX@(
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
                        LocalDataProperty : 'MAKTX',
                        ValueListProperty : 'MAKTX'
                    }
                ]
            },
        } 
    );
    PLANT@(title: 'Plant');
    UNIT_PRICE@(title: 'Unit Price');
    TOTAL_COST@(title: 'Total Cost');
    AVAILABLE_COST@(title: 'Open Stock');
    QUARANTINE_COST@(title: 'Quarantine');
    DAMAGE_DESTRUCTION_COST@(title: 'Damage/Destruction');
    RETAINS_COST@(title: 'Retains');
    RETURNS_COST@(title: 'Returns');
    INVENTORY_HOLD_COST@(title: 'Inventory Hold');
    QUALITY_HOLD_COST@(title: 'Returns');
    RECALL_COST@(title: 'Recalls');
    RELABEL_COST@(title: 'Re-Labels');
    SAMPLE_COST@(title: 'Samples'); 
    VKBUR@(title: 'Sales Office',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALVKBUR',
                Label : 'Product Description',
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
    MFRNR@(title: 'Manufacturer Number',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALMFRNR',
                Label : 'Product Description',
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
};