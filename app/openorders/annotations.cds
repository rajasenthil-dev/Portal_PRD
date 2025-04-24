using PROCESSING as service from '../../srv/service';

annotate PROCESSING.OPENORDERS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                VBELN: true,
                BSTKD: true,
                KUNWE_ANA: true,      
        }
    },
    UI : {
        SelectionFields  : [
           KUNNR, KUNWE_ANA, CAL_NAME, REGIO, MATNR, MAKTX, MFRNR, MFRNR_NAME
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
                Label : 'Purchase Order',
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
                Value : MFRPN,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KWMENG,
                Label : 'Quantity',
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
                Value : VDATU_ANA,
                Label : 'Requested Delivery Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VDATU,
                Label : 'Delivery By Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : GBSTA,
                Label : 'Processing Status',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : GBSTK,
                Label : 'Order Status',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : AUART_ANA,
                Label : 'Sales Doc. Type',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : 'Customer #',
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
                Value : CAL_NAME,
                Label : 'Ship To Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : REGIO,
                Label : 'Province',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PSTLZ,
                Label : 'Postal Code',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : 'Manufacturer Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    MATNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOPROD',
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
    MAKTX@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOPRODDESC',
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

    KUNNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOCUST',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNNR',
                        ValueListProperty : 'KUNNR'
                    }
                ]
            },
        } 
        
    );
    KUNWE_ANA@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOSHIPTO',
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
    CAL_NAME@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOSHIPTONAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CAL_NAME',
                        ValueListProperty : 'CAL_NAME'
                    }
                ]
            },
        } 
    
    );
    REGIO@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOPROVINCE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'REGIO',
                        ValueListProperty : 'REGIO'
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
                CollectionPath : 'OOMFRNR',
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
                CollectionPath : 'OOMFRNRNAME',
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