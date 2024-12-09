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
                Label : 'Product Desc',
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
                Label : 'Manufacturer',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
        ],
    },
){
    VBELN@(title: 'Order #');
    BSTKD@(title: 'Purchase Order');
    MATNR@(title: 'Product');
    MAKTX@(
        title: 'Product Desc',
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
    KWMENG@(title: 'Quantity');
    ERDAT@(title: 'Order Date');
    VDATU@(title: 'Delivery By Date');
    GBSTK@(title: 'Order Status');
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
    CAL_NAME@(title: 'Name');
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
    MFRNR@(title: 'Manufacturer');   
};