using PROCESSING as service from '../../srv/service';

annotate PROCESSING.RETURNS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                CUSTOMER_KUNNR: true,
                CUSTOMER_NAME_NAME1: true,
                PROVINCE_REGIO: true,
                VBELN_VBAK: true,
                REASON_BEZEI: true,
                REFERENCE_BSTKD: true,
                CO_VKORG: true,
                VKBUR: true,
                MFRNR: true
        }
    },
    UI : {
        SelectionFields  : [
           VBELN_VBAK, CUSTOMER_KUNNR, CUSTOMER_NAME_NAME1, REASON_BEZEI, ERDAT, MFRNR, MFRNR_NAME, CO_VKORG, VKBUR
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : CURRENT,
                Label : 'Current/Historical',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : ERDAT,
                Label : 'Date Entered',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_KUNNR,
                Label : 'Customer #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_NAME_NAME1,
                Label : 'Customer Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PROVINCE_REGIO,
                Label : 'Province',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN_VBAK,
                Label : 'RGA #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : REFERENCE_BSTKD,
                Label : 'Reference #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : REASON_BEZEI,
                Label : 'Reason',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN_VBRK,
                Label : 'Credit #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : FKDAT_ANA,
                Label : 'Credit Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CREDIT_AMT_NETWR,
                Label : 'Credit Amt $',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CO_VKORG,
                Label : 'Sales Org.',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VKBUR,
                Label : 'Sales Office',
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
                Value : MFRNR,
                Label : 'Manufacturer Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
            
        ],
    },
){
    CUSTOMER_KUNNR@(
         Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETCUST',
                Label : 'Customer #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CUSTOMER_KUNNR',
                        ValueListProperty : 'CUSTOMER_KUNNR'
                    }
                ]
            },
        }
    );
    CUSTOMER_NAME_NAME1@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETCUSTNAME',
                Label : 'Customer Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CUSTOMER_NAME_NAME1',
                        ValueListProperty : 'CUSTOMER_NAME_NAME1'
                    }
                ]
            },
        }
    );
    VBELN_VBAK@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETRGA',
                Label : 'RGA #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VBELN_VBAK',
                        ValueListProperty : 'VBELN_VBAK'
                    }
                ]
            },
        }

    );
    REASON_BEZEI@(
        title: 'Reason',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETREASON',
                Label : 'Reason',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'REASON_BEZEI',
                        ValueListProperty : 'REASON_BEZEI'
                    }
                ]
            },
        }

    );
    CO_VKORG@(title: 'Sales Org.',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETVKORG',
                Label : 'Sales Org.',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CO_VKORG',
                        ValueListProperty : 'CO_VKORG'
                    }
                ]
            },
        }
    );
    VKBUR@(title: 'Sales Office',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETVKBUR',
                Label : 'Sales Office',
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
                CollectionPath : 'RETMFRNR',
                Label : 'Manufacturer',
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
                CollectionPath : 'RETMFRNRNAME',
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
