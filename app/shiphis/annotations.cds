using PROCESSING as service from '../../srv/service';

annotate PROCESSING.SHIPPINGHISTORY with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            CARRIER: true,
            VKORG: true,
            KUNAG: true,
            VBELN: true,
            PSTLZ: true,
            TRK_DLVTO: true,
            KUNNR: true,
            NAME1: true,
            TRACKN: true,
            MFRNR: true
        }
    },
    UI : {
        SelectionFields  : [
            VBELN, KUNAG, KUNNR, WADAT_IST, LFDAT, TRACKN, CARRIER

        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : VBELN,
                Label : 'Ivoince #'

            },
            {
                $Type : 'UI.DataField',
                Value : KUNAG,
                Label : 'Customer'
            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : 'Ship To'
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Ship To Name'
            },
            {
                $Type : 'UI.DataField',
                Value : PSTLZ,
                Label : 'Postal Code'
            },
            {
                $Type : 'UI.DataField',
                Value : WADAT_IST,
                Label : 'Date Shipped'
            },
            {
                $Type : 'UI.DataField',
                Value : CARRIER,
                Label : 'Carrier'
            },
            {
                $Type : 'UI.DataField',
                Value : TRACKN,
                Label : 'Tracking #'
            },
            {
                $Type : 'UI.DataField',
                Value : LFDAT,
                Label : 'Delivery Date'
            },
            {
                $Type : 'UI.DataField',
                Value : LFUHR,
                Label : 'Delivery Time'
            },
            {
                $Type : 'UI.DataField',
                Value : TRK_DLVTO,
                Label : 'Recieved'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_BILL_ITM_COUNT,
                Label : 'Item Count'
            },
            {
                $Type : 'UI.DataField',
                Value : FKIMG,
                Label : 'Invoiced Quanity'
            },
            {
                $Type : 'UI.DataField',
                Value : MEINS,
                Label : 'Unit of Measure'
            }
        ],
    },   
){
    VBELN@(
        title:'Invoice Number',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHINVOICE',
                Label : 'Customer',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VBELN',
                        ValueListProperty : 'VBELN'
                    }
                ]
            },
        },
    );
    KUNAG@(
        title:'Customer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHCUSTOMER',
                Label : 'Customer',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNAG',
                        ValueListProperty : 'KUNAG'
                    }
                ]
            },
        },
    );
    KUNNR@(
        title:'Ship To',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHSHIPTO',
                Label : 'Ship To',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNNR',
                        ValueListProperty : 'KUNNR'
                    }
                ]
            },
        },  
    );
    NAME1@(title:'Ship To Name');
    PSTLZ@(title:'Postal Code');
    WADAT_IST@(title:'Date Shipped');
    CARRIER@(
        title:'Carrier',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHCARRIER',
                Label : 'Carrier',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CARRIER',
                        ValueListProperty : 'CARRIER'
                    }
                ]
            },
        }, 
    ); 
    TRACKN@(
        title:'Tracking #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHTRACKING',
                Label : 'Tracking #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'TRACKN',
                        ValueListProperty : 'TRACKN'
                    }
                ]
            },
        }, 
    );
    LFDAT@(title:'Delivery Date');
    LFUHR@(title:'Delivery Time');
    TRK_DLVTO@(title:'Received');
    VKORG@(title:'Co.');
    MFRNR@(title:'Manufacturer Number');
    CAL_BILL_ITM_COUNT@(title: 'Item Count');
    FKIMG@(title: 'Invoiced Quanity');
    MEINS@(title: 'Unit of Measure');
}