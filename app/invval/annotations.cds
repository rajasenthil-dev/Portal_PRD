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
            MATNR,
            MAKTX,
            MFRNR,
            MFRNR_NAME,
            VKBUR
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
                Label : 'Sales Org.'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : 'Manufacturer Name'
            }
        ],
    },
){
    MATNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALPRODSKU',
                Label : 'Product Description',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MATNR',
                        ValueListProperty : 'MATNR'
                    }
                ]
            },
        } 
    );
    MFRPN@( 
        title: 'Product Code',
        Common: {
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
    VKBUR@(title: 'Sales Org.',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALVKBUR',
                Label : 'Sales Org.',
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
    MFRNR@(title: 'Manufacturer #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALMFRNR',
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
    MFRNR_NAME@(title: 'Manufacturer #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVVALMFRNRNAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR_NAME',
                        ValueListProperty : 'MFRNR_NAME'
                    }
                ]
            },
        } 
    );
};