using PROCESSING as service from '../../srv/service';

annotate PROCESSING.RETURNS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                CUSTOMER_KUNNR: true,
                CUSTOMER_NAME_NAME1: true,
                PROVINCE_REGIO: true,
                RGA_VBELN: true,
                REASON_BEZEI: true,
                REFERENCE_BSTKD: true,
                CO_VKORG: true,
                SALES_OFFICE_VKBUR: true,
                MANUFACTURER_MFRNR: true,
                PROFIT_CENTER_PRCTR: true
        }
    },
    UI : {
        SelectionFields  : [
           RGA_VBELN, CUSTOMER_NAME_NAME1, REASON_BEZEI, DATE_ENTERED_FKDAT_ANA
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : DATE_ENTERED_FKDAT_ANA,
                Label : 'Date Entered',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_KUNNR,
                Label : 'Customer',
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
                Value : RGA_VBELN,
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
                Value : CREDIT_DATE_ERDAT,
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
                Value : SALES_OFFICE_VKBUR,
                Label : 'Sales Office',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MANUFACTURER_MFRNR,
                Label : 'Manufacturer Number',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PROFIT_CENTER_PRCTR,
                Label : 'Profit Center',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    DATE_ENTERED_FKDAT_ANA@(title: 'Date Entered');
    CUSTOMER_KUNNR@(title: 'Customer');
    CUSTOMER_NAME_NAME1@(title: 'Name',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETCUST',
                Label : 'Customer',
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
    PROVINCE_REGIO@(title: 'Province');
    RGA_VBELN@(
        title: 'RGA #',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETRGA',
                Label : 'RGA #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'RGA_VBELN',
                        ValueListProperty : 'RGA_VBELN'
                    }
                ]
            },
        }

    );
    REFERENCE_BSTKD@(title: 'Reference #');
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
    CREDIT_DATE_ERDAT@(title: 'Credit Date');
    CREDIT_AMT_NETWR@(title: 'Credit Amt');
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
    SALES_OFFICE_VKBUR@(title: 'Sales Office',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETVKBUR',
                Label : 'Sales Office',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'SALES_OFFICE_VKBUR',
                        ValueListProperty : 'SALES_OFFICE_VKBUR'
                    }
                ]
            },
        }
    );
    MANUFACTURER_MFRNR@(title: 'Manufacturer Number',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETMFRNR',
                Label : 'Manufacturer',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MANUFACTURER_MFRNR',
                        ValueListProperty : 'MANUFACTURER_MFRNR'
                    }
                ]
            },
        }
    );
    PROFIT_CENTER_PRCTR@(title: 'Profit Center',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETPRCTR',
                Label : 'Profit Center',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PROFIT_CENTER_PRCTR',
                        ValueListProperty : 'PROFIT_CENTER_PRCTR'
                    }
                ]
            },
        }
    );



};
