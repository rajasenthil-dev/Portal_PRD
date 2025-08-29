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
            NETDT,
            BLART,
            VKORG,
            PRCTR
        ],
        
        LineItem  : [
            // {
            //     $Type : 'UI.DataField',
            //     Value : CURRENT,
            //     ![@HTML5.CssDefaults] : {width : '10rem'}

            // },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO,
                ![@HTML5.CssDefaults] : {width : '12rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN
            }, 
            // {
            //     $Type : 'UI.DataField',
            //     Value : FKDAT
            // },
            
            // {
            //     $Type : 'UI.DataField',
            //     Value : NETWR,
            //     ![@HTML5.CssDefaults] : {width : '16rem'}
            // },          
            {
                $Type : 'UI.DataField',
                Value : CAL_CASH_RECEIVED,
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_DISCOUNT,
                ![@HTML5.CssDefaults] : {width : '5.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : XBLNR_REF
            },
            {
                $Type : 'UI.DataField',
                Value : BLART,
                ![@HTML5.CssDefaults] : {width : '6.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VTEXT_ZTERM
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_INV_DATE
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_DUE_DATE
            },
            {
                $Type : 'UI.DataField',
                Value : BUKRS,
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR,
            },
            
            {
                $Type : 'UI.DataField',
                Value : GJAHR
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                ![@HTML5.CssDefaults] : {width : '3rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : BKTXT,
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SGTXT
            },
            {
                $Type : 'UI.DataField',
                Value : PRCTR,
            },
            {
                $Type : 'UI.DataField',
                Value : BLDAT,
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_INV_AMOUNT,
            }

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