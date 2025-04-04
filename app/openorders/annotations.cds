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
           KUNNR, KUNWE_ANA, REGIO, MAKTX
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
                Label : 'Product',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Desc.',
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
                Value : VDATU,
                Label : 'Delivery By Date',
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
                Value : KUNNR,
                Label : 'Customer',
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
                Value : CAL_NAME,
                Label : 'Name',
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
                Value : MFRNR,
                Label : 'Manufacturer Number',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
        ],
    },
){
    MAKTX@(
        title: 'Product Desc.',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOPRODDESC',
                Label : 'Warehouse/Status',
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
        title: 'Customer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOCUST',
                Label : 'Warehouse/Status',
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
        title: 'Ship To',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOSHIPTO',
                Label : 'Warehouse/Status',
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
    REGIO@(
        title: 'Province',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OOPROVINCE',
                Label : 'Warehouse/Status',
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
};