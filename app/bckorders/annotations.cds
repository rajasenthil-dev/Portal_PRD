using PROCESSING as service from '../../srv/service';

annotate PROCESSING.BACKORDERS with @(
    
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                KUNRE_ANA: true,
                VKORG: true,	
                BSTKD: true,	 
                VBELN: true,
                MATNR: true,
                MAKTX: true,
                NAME1: true,
                MFRNR: true       
        }
    },
    UI : {
        SelectionFields  : [
           MAKTX, KUNRE_ANA, KUNWE_ANA
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : VBELN,
                Label : 'Order #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : 'Customer PO',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : ERDAT,
                Label : 'Order Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DATE_DIFF,
                Label : 'Age',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : UDATE,
                Label : 'Cancel Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'Product',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Desc',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BACK_ORD_QTY,
                Label : 'Quantity',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MEINS,
                Label : 'Unit',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },

            {
                $Type : 'UI.DataField',
                Value : UNIT_PRICE,
                Label : 'Price',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : EXTENSION,
                Label : 'Extension',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNRE_ANA,
                Label : 'Bill To',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNWE_ANA,
                Label : 'Ship To',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Ship To Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Co.',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
            
        ],
    },
){
    VBELN@(title: 'Order #');
    BSTKD@(title: 'Customer PO');
    ERDAT@(title: 'Order Date');
    DATE_DIFF@(title: 'Age');
    UDATE@(title: 'Cancel Date');
    MATNR@(title: 'Product');
    MAKTX@(title: 'Product Desc',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOPRODUCTDESC',
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
    BACK_ORD_QTY@(title: 'Quantity');
    MEINS@(title: 'Unit');
    UNIT_PRICE@(title: 'Price');
    EXTENSION@(title:'Extension');
    KUNRE_ANA@(title:'Bill To',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOBILLTO',
                Label : 'Bill To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNRE_ANA',
                        ValueListProperty : 'KUNRE_ANA'
                    }
                ]
            },
        }
    );
    KUNWE_ANA@(title: 'Ship To',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOSHIPTO',
                Label : 'Bill To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNWE_ANA',
                        ValueListProperty : 'KUNWE_ANA'
                    }
                ]
            },
        }
    );
    NAME1@(title: 'Ship To Name');
    VKORG@(title: 'Co.');
    MFRNR@(title: 'Manufacturer');   
};