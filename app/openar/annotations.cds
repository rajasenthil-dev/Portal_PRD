using FINANCE as service from '../../srv/service';

annotate FINANCE.OPENAR with @(
    odata: {
        filterable: {
            VKORG: true,
            BILL_TO: true,
            NAME1: true,
            BSTKD: true,
            NETDT: true,
            BELNR: true,
            FKDAT: true,
            ZTERM: true,
            STORE_SHIP_TO: true,
            BLART: true,
            MFRNR: true
        }
    },
    UI : {
        SelectionFields  : [
            NAME1,
            FKDAT 
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : BILL_TO,
                Label : 'Customer',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Customer Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR,
                Label : 'Invoice #',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : 'Customer PO',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : FKDAT,
                Label : 'Invoice Date',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NETDT,
                Label : 'Due Date',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BLART,
                Label : 'Type',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : STORE_SHIP_TO,
                Label : 'Store',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_AGE,
                Label : 'Age',
                ![@HTML5.CssDefaults] : {width : '3.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_CURRENT,
                Label : 'Current',
                ![@HTML5.CssDefaults] : {width : '4.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_1_30,
                Label : '1 to 30',
                ![@HTML5.CssDefaults] : {width : '4.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_31_60,
                Label : '31 to 60',
                ![@HTML5.CssDefaults] : {width : '4.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_61_90,
                Label : '61 to 90',
                ![@HTML5.CssDefaults] : {width : '4.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_OVER_90,
                Label : 'Over 90',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NETWR,
                Label : 'Invoiced Amount',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TSL,
                Label : 'Amount Paid',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : ZTERM,
                Label : 'Invoice Terms',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CREDIT_LIMIT,
                Label : 'Credit Limit',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Sales Org.',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },

        ],
    },
    
    
)

{
    NAME1@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'OPENARCUSTOMER',
                Label : 'Lot #',
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
};