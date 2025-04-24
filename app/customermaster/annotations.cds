using CUSTOMERS as service from '../../srv/service';

annotate CUSTOMERS.CUSTOMERMASTER with @(
    odata: {
        filterable: {
            KUNN2_BILLTO: true,
            STRAS_BILLTO: true,
            ORT01_BILLTO: true,
            ERDAT_BILLTO: true,
            NAME1_BILLTO: true,
            PSTLZ_BILLTO: true,
            BEZEI_BILLTO: true,
            KTEXT_BILLTO: true,
            VKORG: true,
            KUNN2_SHIPTO: true,
            STRAS_SHIPTO: true,
            ORT01_SHIPTO: true,
            ERDAT_SHIPTO: true,
            NAME1_SHIPTO: true,
            PSTLZ_SHIPTO: true,
            BEZEI_SHIPTO: true,
            KTEXT_SHIPTO: true,
            CAL_CUST_STATUS: true,
            CAL_TERM: true  
        }
    },
    UI : {
        SelectionFields  : [
            KUNN2_BILLTO,
            KUNN2_SHIPTO,
            NAME1_BILLTO,
            NAME1_SHIPTO,
            CAL_CUST_STATUS,
            VKORG
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : KUNN2_BILLTO,
                Label : 'Bill To #' 
            },          
            {
                $Type : 'UI.DataField',
                Value : NAME1_BILLTO,
                Label : 'Bill To Name'
            },
            {
                $Type : 'UI.DataField',
                Value : KUNN2_SHIPTO,
                Label : 'Ship To #'
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1_SHIPTO,
                Label : 'Ship To Name'
            },
            {
                $Type : 'UI.DataField',
                Value : KTEXT_BILLTO,
                Label : 'Bill To Type'
            },
            {
                $Type : 'UI.DataField',
                Value : KTEXT_SHIPTO,
                Label : 'Ship To Type'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_TERM,
                Label : 'Terms'
            },
            {
                $Type : 'UI.DataField',
                Value : CREDIT_LIMIT,
                Label : 'Credit Limit'
            },
            // {
            //     $Type : 'UI.DataField',
            //     Value : STRAS_BILLTO,
            //     Label : 'Bill To Address 1'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : ORT01_BILLTO,
            //     Label : 'Bill To City'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : PSTLZ_BILLTO,
            //     Label : 'Bill To Postal Code'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : BEZEI_BILLTO,
            //     Label : 'Bill To Province'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : STRAS_SHIPTO,
            //     Label : 'Ship To Address 1'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : ORT01_SHIPTO,
            //     Label : 'Ship To City'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : PSTLZ_SHIPTO,
            //     Label : 'Ship To Postal Code'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : BEZEI_SHIPTO,
            //     Label : 'Ship To Province'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : ERDAT_BILLTO,
            //     Label : 'Bill To Created'
            // },
            // {
            //     $Type : 'UI.DataField',
            //     Value : ERDAT_SHIPTO,
            //     Label : 'Ship To Created'
            // },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Sales Org.'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_CUST_STATUS,
                Label : 'Status'
            },

        ],
    },
    
    
)

{   
    KUNN2_BILLTO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'KUNN2_BILLTO',
                Label : 'Bill To #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNN2_BILLTO',
                        ValueListProperty : 'KUNN2_BILLTO'
                    }
                ]
            },
        } 
    );
    NAME1_BILLTO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'KUNN2_BILLTONAME',
                Label : 'Bill To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'NAME1_BILLTO',
                        ValueListProperty : 'NAME1_BILLTO'
                    }
                ]
            },
        } 
    );
    KUNN2_SHIPTO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'KUNN2_SHIPTO',
                Label : 'Ship To #',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNN2_SHIPTO',
                        ValueListProperty : 'KUNN2_SHIPTO'
                    }
                ]
            },
        } 
    );
    NAME1_SHIPTO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'KUNN2_SHIPTONAME',
                Label : 'Ship To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'NAME1_SHIPTO',
                        ValueListProperty : 'NAME1_SHIPTO'
                    }
                ]
            },
        } 
    );
    CAL_CUST_STATUS@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'CAL_CUST_STATUS',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CAL_CUST_STATUS',
                        ValueListProperty : 'CAL_CUST_STATUS'
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
                CollectionPath : 'CMSALESORG',
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
};