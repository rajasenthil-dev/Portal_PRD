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
            BLART:true,
            MFRNR:true,
        }
    },
    UI : {
        SelectionFields  : [
            KUNNR, NAME1, SHIP_TO, BELNR, BSTKD, BUDAT, BLART, REGIO, CURRENT
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
                Value : BLART,
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
                Label : 'Current'
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
        title:'Customer',
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
        title:'Customer Name',
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
    ORT01@(title:'City');	    
    REGIO@(
        title:'Province',
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
    PSTLZ@(title: 'Postal Code');	    
    SHIP_TO@(
        title: 'Ship To',
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
        title: 'Purchase Order',
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
    AUBEL@(title: 'Order #');	    
    BELNR@(
        title: 'Invoice #',
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
    BUDAT@(title: 'Invoice Date');	    
    TSL_AMOUNT@(title: '$ Amount');
    CAL_PST@(title: 'P.S.T.');	    
    CAL_GST@(title: 'G.S.T.');	    
    BLART@(
        title: 'Type',
        Common: {
                ValueListWithFixedValues,
                ValueList : {
                    $Type : 'Common.ValueListType',
                    CollectionPath : 'IHTYPE',
                    Label : 'Customer',
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
    TRACKN@(title: 'Tracking #');	    
    LFDAT@(title: 'Delivery Date');	    
    BKTXT@(title: 'Comment');     
    VKORG@(title: 'CO');
    CURRENT@(title: 'Current');	    
    MFRNR@(title: 'Manufacturer');  
};