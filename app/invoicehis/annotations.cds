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
            KUNNR, NAME1, SHIP_TO, BELNR, BSTKD, BUDAT, ORDER_TYPE, REGIO
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : 'Customer'
            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Customer Name'
            },
            {
                $Type : 'UI.DataField',
                Value : ORT01,
                Label : 'City'
            },
            {
                $Type : 'UI.DataField',
                Value : REGIO,
                Label : 'Province'
            },
            {
                $Type : 'UI.DataField',
                Value : PSTLZ,
                Label : 'Postal Code'
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO,
                Label : 'Ship To'
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : 'Purchase Order'
            },
            {
                $Type : 'UI.DataField',
                Value : AUBEL,
                Label : 'Order #'
            },
            {
                $Type : 'UI.DataField',
                Value : BELNR,
                Label : 'Invoice #'
            },
            {
                $Type : 'UI.DataField',
                Value : BUDAT,
                Label : 'Invoice Date'
            },
            {
                $Type : 'UI.DataField',
                Value : TSL_AMOUNT,
                Label : '$ Amount'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_PST,
                Label : 'P.S.T.'
            },
            {
                $Type : 'UI.DataField',
                Value : CAL_GST,
                Label : 'G.S.T.'
            },
            {
                $Type : 'UI.DataField',
                Value : ORDER_TYPE,
                Label : 'Type'
            },
            {
                $Type : 'UI.DataField',
                Value : TRACKN,
                Label : 'Tracking #'
            },
            {
                $Type : 'UI.DataField',
                Value : LFDAT,
                Label : 'Delivery Date'
            },
            {
                $Type : 'UI.DataField',
                Value : BKTXT,
                Label : 'Comment'
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENT,
                Label : 'Current/Historical'
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'CO'
            },
            
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer'
            },
        ],
    },
){
    KUNNR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHCUSTOMERID',
                Label : 'Customer',
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
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHCUSTOMER',
                Label : 'Customer',
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
                Label : 'Province',
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
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHSHIPTO',
                Label : 'Ship To',
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
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHPO',
                Label : 'Purchase Order',
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
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IHINVOICE',
                Label : 'Invoice #',
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
                Label : 'Customer',
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
};