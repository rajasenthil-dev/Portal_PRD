using FINANCE as service from '../../srv/service';

annotate FINANCE.CASHJOURNAL with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            BILL_TO: true,
            NAME1: true,
            VKORG: true,
            BKTXT: true,
            SGTXT: true,
            VBELN: true,
            BLART: true,
            AUBEL: true,
            SHIP_TO: true,
            BUKRS: true,
            MFRNR: true,
            BELNR: true,
            RLDNR: true,
            GJAHR: true,
            BSTKD: true,
            PRCTR: true
        }
    },
    UI : {
        SelectionFields  : [
            BILL_TO, 
            BUDAT,
            BLART
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : BILL_TO,
                Label : 'Bill To',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Bill To Name',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO,
                Label : 'Ship To Code'
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN,
                Label : 'Invoice #'
            }, 
            {
                $Type : 'UI.DataField',
                Value : FKDAT,
                Label : 'Invoice Date'
            },  
            {
                $Type : 'UI.DataField',
                Value : NETWR,
                Label : 'Invoice Amount',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },  
            {
                $Type : 'UI.DataField',
                Value : AUBEL,
                Label : 'Reference',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },          
            {
                $Type : 'UI.DataField',
                Value : CAL_CASH_RECEIVED,
                Label : 'Cash Recieved',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_DISCOUNT,
                Label : 'Discount',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BLART,
                Label : 'Payment Type',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BUDAT,
                Label : 'Deposit Date'
            },
            {
                $Type : 'UI.DataField',
                Value : BUKRS,
                Label : 'Company Code',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR,
                Label : 'Accounting Document'
            },
            
            {
                $Type : 'UI.DataField',
                Value : GJAHR,
                Label : 'Fiscal Year'
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Co.',
                ![@HTML5.CssDefaults] : {width : '3rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : 'Customer PO',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : BKTXT,
                Label : 'Comment 1',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SGTXT,
                Label : 'Comment 2'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer'
            },
            {
                $Type : 'UI.DataField',
                Value : PRCTR,
                Label : 'Profit Center'
            },
        ],
    },
    
)

{   
    BILL_TO@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BILL_TOS',
                Label : 'Bill To Name',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BILL_TO',
                        ValueListProperty : 'BILL_TO'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'BILL_TO'
                    }
                ]
            },
        }      
    );
    
    BLART@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BLARTS',
                Label : 'Payment Type',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BLART',
                        ValueListProperty : 'BLART'
                    }
                ]
            },
        } 
    );
     
};