using CUSTOMERS as service from '../../srv/service';

annotate CUSTOMERS.PRICING with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            VKORG: true,
            KSCHL: true,
            VTEXT: true,
            MATNR: true,
            MAKTX: true,
            MFRNR: true
        }
    },
    UI : {
        SelectionFields  : [
            MATNR, MAKTX, VTEXT, MFRNR, VKORG

        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'SKU'

            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description'
            },
            {
                $Type : 'UI.DataField',
                Value : KSCHL,
                Label : 'Price Level Code'
            },
            {
                $Type : 'UI.DataField',
                Value : VTEXT,
                Label : 'Price Level Description'
            },
            {
                $Type : 'UI.DataField',
                Value : KBETR,
                Label : 'Price'
            },
            {
                $Type : 'UI.DataField',
                Value : KONWA,
                Label : 'Currency'
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Sales Org.'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #'
            }
        ],
    },   
){
    VTEXT@(
        title:'Price Level Description',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'PRICINGPRICEDESC',
                Label : 'Price Level',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VTEXT',
                        ValueListProperty : 'VTEXT'
                    }
                ]
            },
        }
    );
    MATNR@(
        Common: {
                ValueList : {
                    $Type : 'Common.ValueListType',
                    CollectionPath : 'PRICINGPRODUCT',
                    Label: 'SKU',
                    Parameters : [
                        {
                            $Type : 'Common.ValueListParameterOut',
                            LocalDataProperty : 'MATNR',
                            ValueListProperty : 'MATNR'
                        }
                    ]
                },
            }
        );
        MAKTX@(
        Common: {
                ValueList : {
                    $Type : 'Common.ValueListType',
                    CollectionPath : 'PRICINGPRODUCTDESC',
                    Label: 'Product Description',
                    Parameters : [
                        {
                            $Type : 'Common.ValueListParameterOut',
                            LocalDataProperty : 'MAKTX',
                            ValueListProperty : 'MAKTX'
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
                    CollectionPath : 'PRICINGMFRNR',
                    Label: 'Manufacturer #',
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
                    CollectionPath : 'PRICINGSALESORG',
                    Label: 'Sales Org',
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
}