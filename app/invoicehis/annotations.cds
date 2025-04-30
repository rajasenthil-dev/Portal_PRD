using SALES as service from '../../srv/service';

annotate SALES.INVOICEHISTORY with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            ORT01:true, 
            VKORG:true,
            BKTXT:true,
            KUNNR:true,
            LFDAT:true,
            BELNR:true,
            BUDAT:true,
            NAME1:true,
            AUBEL:true,
            PSTLZ:true,
            REGIO:true,
            BSTKD:true,
            SHIP_TO:true,
            TRACKN:true,
            ORDER_TYPE:true,
            MFRNR:true,
            CURRENT:true
        }
    },
    UI : {
        SelectionFields  : [
            KUNNR, NAME1, SHIP_TO, BELNR, BSTKD, BUDAT, ORDER_TYPE, REGIO, MFRNR, VKORG
        ],
        LineItem  : [
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
                Value : ORT01
            },
            {
                $Type : 'UI.DataField',
                Value : REGIO
            },
            {
                $Type : 'UI.DataField',
                Value : PSTLZ
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD
            },
            {
                $Type : 'UI.DataField',
                Value : AUBEL
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR
            },
            {
                $Type : 'UI.DataField',
                Value : BUDAT
            },
            {
                $Type : 'UI.DataField',
                Value : TSL_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_PST
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_GST
            },
            {
                $Type : 'UI.DataField',
                Value : ORDER_TYPE
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
                Value : BKTXT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENT
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG
            },
            
            {
                $Type : 'UI.DataField',
                Value : MFRNR
            },
        ],
    },
){
    KUNNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHCUSTOMERID',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'KUNNR',
                        ValueListProperty : 'KUNNR'
                    }
                ]
            },
        } 
    );
    NAME1@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHCUSTOMER',
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
    REGIO@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHPROVINCE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'REGIO',
                        ValueListProperty : 'REGIO'
                    }
                ]
            },
        } 
        
    );	    
    SHIP_TO@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHSHIPTO',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'SHIP_TO',
                        ValueListProperty : 'SHIP_TO'
                    }
                ]
            },
        } 
        
    );    
    BSTKD@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHPO',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BSTKD',
                        ValueListProperty : 'BSTKD'
                    }
                ]
            },
        } 
    );	    
    BELNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHINVOICE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'BELNR',
                        ValueListProperty : 'BELNR'
                    }
                ]
            },
        }    
    );    
    ORDER_TYPE@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHTYPE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'ORDER_TYPE',
                        ValueListProperty : 'ORDER_TYPE'
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
                CollectionPath : 'IHMFRNR',
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
                CollectionPath : 'IHSALESORG',
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