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
            NAME1, 
            BUDAT,
            BLART,
            MFRNR,
            VKORG,
            PRCTR,
            MFRNR_NAME
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : CURRENT,
                Label : '{i18n>CASHJOURNAL.CURRENT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO,
                Label : '{i18n>CASHJOURNAL.BILL_TO}',
                ![@HTML5.CssDefaults] : {width : '12rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : '{i18n>CASHJOURNAL.NAME1}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO,
                Label : '{i18n>CASHJOURNAL.SHIP_TO}'
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN,
                Label : '{i18n>CASHJOURNAL.VBELN}'
            }, 
            {
                $Type : 'UI.DataField',
                Value : FKDAT,
                Label : '{i18n>CASHJOURNAL.FKDAT}'
            },  
            {
                $Type : 'UI.DataField',
                Value : NETWR,
                Label : '{i18n>CASHJOURNAL.NETWR}',
                ![@HTML5.CssDefaults] : {width : '16rem'}
            },  
            {
                $Type : 'UI.DataField',
                Value : AUBEL,
                Label : '{i18n>CASHJOURNAL.AUBEL}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },          
            {
                $Type : 'UI.DataField',
                Value : CAL_CASH_RECEIVED,
                Label : '{i18n>CASHJOURNAL.CAL_CASH_RECEIVED}',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_DISCOUNT,
                Label : '{i18n>CASHJOURNAL.CAL_DISCOUNT}',
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BLART,
                Label : '{i18n>CASHJOURNAL.BLART}',
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BUDAT,
                Label : '{i18n>CASHJOURNAL.BUDAT}'
            },
            {
                $Type : 'UI.DataField',
                Value : BUKRS,
                Label : '{i18n>CASHJOURNAL.BURKS}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR,
                Label : '{i18n>CASHJOURNAL.BELNR}'
            },
            
            {
                $Type : 'UI.DataField',
                Value : GJAHR,
                Label : '{i18n>CASHJOURNAL.GJAHR}'
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : '{i18n>CASHJOURNAL.VKORG}',
                ![@HTML5.CssDefaults] : {width : '3rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : '{i18n>CASHJOURNAL.BSTKD}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : BKTXT,
                Label : '{i18n>CASHJOURNAL.BKTXT}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SGTXT,
                Label : '{i18n>CASHJOURNAL.SGTXT}'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : '{i18n>CASHJOURNAL.MFRNR}'
            },
            {
                $Type : 'UI.DataField',
                Value : PRCTR,
                Label : '{i18n>CASHJOURNAL.PRCTR}'
            },
            {
                $Type : 'UI.DataField',
                Value : BLDAT,
                Label : '{i18n>CASHJOURNAL.BLDAT}'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_INV_AMOUNT,
                Label : '{i18n>CASHJOURNAL.CAL_INV_AMOUNT}'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : '{i18n>CASHJOURNAL.MFRNR_NAME}'
            },

        ],
    },
    
)

{   
    BILL_TO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BILL_TOS',
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
    NAME1@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'BILL_TONAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'NAME1',
                        ValueListProperty : 'NAME1'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'NAME1'
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
    MFRNR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'FINCJMFRNR',
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
    VKORG@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'FINCJSALESORG',
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
    PRCTR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'FINCJPRCTR',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'PRCTR',
                        ValueListProperty : 'PRCTR'
                    }
                ]
            },
        } 
    );
    MFRNR_NAME@(
        Common: {
            
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                DistinctValuesSupported: true,
                CollectionPath : 'FINCJMFRNRNAME',
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