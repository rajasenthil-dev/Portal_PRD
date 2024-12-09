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
                Label : 'CO.',
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
    BILL_TO@(title: 'Customer');
    NAME1@(
        title: 'Customer Name',
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
    BELNR@(title: 'Invoice #');
    BSTKD@(title: 'Customer PO');
    FKDAT@(title: 'Invoice Date');
    NETDT@(title: 'Due Date');
    BLART@(title: 'Type');
    STORE_SHIP_TO@(title: 'Store');
    CAL_AGE@(title: 'Age');
    CAL_CURRENT@(title: 'Current');
    CAL_1_30@(title: '1 to 30');
    CAL_31_60@(title: '31 to 60');
    CAL_61_90@(title: '61 to 90');
    CAL_OVER_90@(title: 'Over 90');
    NETWR@(title: 'Invoiced Amount');
    TSL@(title: 'Amount Paid');
    ZTERM@(title: 'Invoice Terms');
    CREDIT_LIMIT@(title: 'Credit Limit');
    VKORG@(title: 'CO.');
    MFRNR@(title: 'Manufacturer');

    
};