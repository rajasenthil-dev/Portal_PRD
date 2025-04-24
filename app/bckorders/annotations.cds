using PROCESSING as service from '../../srv/service';

annotate PROCESSING.BACKORDERS with @(
    
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            DATE_DIFF,
            KUNRE_ANA,
            UDATE,
            VKORG,
            BSTKD,
            EXTENSION,
            VBELN,
            ERDAT,
            UNIT_PRICE,
            MATNR, 
            MAKTX,
            BACK_ORD_QTY,
            KUNWE_ANA, 
            NAME1,
            MFRNR,
            MEINS,
            MFRNR_NAME    
        }
    },
    UI : {
        SelectionFields  : [
           MATNR, MAKTX, KUNRE_ANA, KUNWE_ANA, NAME1, MFRNR, MFRNR_NAME, VKORG
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
                Label : 'SKU',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '15rem'}
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
                Label : 'Bill To #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNWE_ANA,
                Label : 'Ship To #',
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
                Label : 'Sales Org.',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'},
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : 'Manufacturer Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'},
            }
            
        ],
    },
){
    
    MATNR@(
        Common.ValueList : {
                CollectionPath : 'BOPRODUCT',
                SearchSupported: true,
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : 'MATNR',
                        ValueListProperty : 'MATNR'
                    }
                ]
            }
        
    );
    MAKTX@(
        Common.ValueList : {
                CollectionPath : 'BOPRODUCTDESC',
                SearchSupported: true,
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : 'MAKTX',
                        ValueListProperty : 'MAKTX'
                    }
                ]
            }
        
    );
    
    KUNRE_ANA@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOBILLTO',
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
    KUNWE_ANA@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOSHIPTO',
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
    NAME1@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOSHIPTONAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'NAME1',
                        ValueListProperty : 'NAME1'
                    }
                ]
            },
        }
    );
    
    VKORG@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOVKORG',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VKORG',
                        ValueListProperty : 'VKORG'
                    }
                ]
            },
        }
    );
    MFRNR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOMFRNR',
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
    MFRNR_NAME@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BOMFRNRNAME',
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