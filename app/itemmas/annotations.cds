using INVENTORY as service from '../../srv/service';

annotate INVENTORY.ITEMMASTER with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                PRODUCT: true,
                SALESORG: true,
                CREATIONDATE: true,
                DIN: true,
                GST_APPLICABLE: true,
                LOT_CONTROL_YN: true,
                NARCOTIC_YN: true,
                CATEGORY: true,
                PRODUCTDESCRIPTION_EN: true,
                PRODUCTDESCRIPTION_FR: true,
                PST_APPLICABLE: true,
                REFRIGERATED: true,
                SIZEUOM: true,
                PRODUCTSTANDARDID: true,
                MANUFACTURERNUMBER: true
        }
    },
    UI : {
        SelectionFields  : [
            PRODUCTDESCRIPTION_EN, CATEGORY
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT,
                Label : 'SKU',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCTSTANDARDID,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCTDESCRIPTION_EN,
                Label : 'Product Desc.',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCTDESCRIPTION_FR,
                Label : 'Special Handling',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DIN,
                Label : 'DIN',
                ![@HTML5.CssDefaults] : {width : '3.125rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SIZEUOM,
                Label : 'Size',
                ![@HTML5.CssDefaults] : {width : '4.688rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CATEGORY,
                Label : 'Category',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UNITS_PER_CASE,
                Label : 'Units Per Case',
                ![@HTML5.CssDefaults] : {width : '6.875rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NARCOTIC_YN,
                Label : 'Narcotic Y/N',
                ![@HTML5.CssDefaults] : {width : '6.25rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LOT_CONTROL_YN,
                Label : 'Lot Control Y/N',
                ![@HTML5.CssDefaults] : {width : '7.188rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : REFRIGERATED,
                Label : 'Refridgerated',
                ![@HTML5.CssDefaults] : {width : '6.25rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PST_APPLICABLE,
                Label : 'PST Applicable',
                ![@HTML5.CssDefaults] : {width : '6.875rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : GST_APPLICABLE,
                Label : 'GST Applicable',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CREATIONDATE,
                Label : 'Creation Date',
                ![@HTML5.CssDefaults] : {width : '7rem'}
            },{
                $Type : 'UI.DataField',
                Value : SALESORG,
                Label : 'Sales Org.',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURERNUMBER,
                Label : 'Manufacturer Id',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    PRODUCTDESCRIPTION_EN@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'ITEMMASPD',
                Label : 'Warehouse/Status',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRODUCTDESCRIPTION_EN',
                        ValueListProperty : 'PRODUCTDESCRIPTION_EN'
                    }
                ]
            },
        } 
    );
    CATEGORY@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'ITEMMASCATEGORY',
                Label : 'Warehouse/Status',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CATEGORY',
                        ValueListProperty : 'CATEGORY'
                    }
                ]
            },
        } 
        
    ); 
};