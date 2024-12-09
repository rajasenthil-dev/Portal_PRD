using PROCESSING as service from '../../srv/service';

annotate PROCESSING.RETURNS with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
                KUNNR: true
                
                
        }
    },
    UI : {
        SelectionFields  : [
           BSTKD, KUNNR, AUGRU, ERDAT
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : ERDAT,
                Label : 'Date Entered',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : 'Customer',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : NAME1,
                Label : 'Customer Name',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : REGIO,
                Label : 'Province',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : BSTKD,
                Label : 'RGA #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VGBEL,
                Label : 'Reference #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : AUGRU,
                Label : 'Reason',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VBELN,
                Label : 'Credit #',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : AUDAT,
                Label : 'Credit Date',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : NETWR,
                Label : 'Credit Amt $',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Co.',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            }
        ],
    },
){
    ERDAT@(title: 'Date Entered');
    KUNNR@(
        title: 'Customer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'RETCUST',
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
    NAME1@(title: 'Name');
    REGIO@(title: 'Province');
    BSTKD@(
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
                        LocalDataProperty : 'BSTKD',
                        ValueListProperty : 'BSTKD'
                    }
                ]
            },
        } 
        
    );
    VGBEL@(title: 'Reference #');
    AUGRU@(
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
                        LocalDataProperty : 'AUGRU',
                        ValueListProperty : 'AUGRU'
                    }
                ]
            },
        } 
        
    );
    VBELN@(title: 'Credit #');
    AUDAT@(title: 'Credit Date');
    NETWR@(title: 'Credit Amt');
    VKORG@(title: 'Co.');
};
