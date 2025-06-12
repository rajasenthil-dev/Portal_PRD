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
            VBELN, KUNAG, KUNNR, NAME1, WADAT_IST, LFDAT, TRACKN, CARRIER, VKORG

        ],
        LineItem : [
            {
                $Type : 'UI.DataField',
                Value : CURRENT
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN
            },
            {
                $Type : 'UI.DataField',
                Value : KUNAG
            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1
            },
            {
                $Type : 'UI.DataField',
                Value : PSTLZ
            },
            {
                $Type : 'UI.DataField',
                Value : WADAT_IST
            },
            {
                $Type : 'UI.DataField',
                Value : CARRIER
            },
            {
                $Type : 'UI.DataField',
                Value : TRACKN
            },
            {
                $Type : 'UI.DataField',
                Value : LFDAT
            },
            {
                $Type : 'UI.DataField',
                Value : LFUHR
            },
            {
                $Type : 'UI.DataField',
                Value : TRK_DLVTO
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_BILL_ITM_COUNT
            },
            {
                $Type : 'UI.DataField',
                Value : FKIMG
            },
            {
                $Type : 'UI.DataField',
                Value : MEINS
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG
            }
        ],
    },   
){
    VBELN@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHINVOICE',
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
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHCUSTOMER',
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
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHSHIPTO',
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
    NAME1@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHSHIPTONAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'NAME1',
                        ValueListProperty : 'NAME1'
                    }
                ]
            },
        },  
    );
    CARRIER@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHCARRIER',
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
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHTRACKING',
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
    VKORG@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHVKORG',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VKORG',
                        ValueListProperty : 'VKORG'
                    }
                ]
            },
        }, 
    );
    MFRNR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHMFRNR',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR',
                        ValueListProperty : 'MFRNR'
                    }
                ]
            },
        }, 
    );  
    MFRNR_NAME@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'SHMFRNRNAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR_NAME',
                        ValueListProperty : 'MFRNR_NAME'
                    }
                ]
            },
        }, 
    );
}