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
            MAKTX, VTEXT

        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'Product'

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
                Label : 'Co.'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer'
            }
        ],
    },   
){
    VKORG@(title:'Co.');
    KBETR@(title:'Price');
    KONWA@(title:'Currency');
    KSCHL@(title:'Price Level Code');
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
    MATNR@(title:'Product');
    MAKTX@(
        title:'Product Description',
        Common: {
                ValueListWithFixedValues,
                ValueList : {
                    $Type : 'Common.ValueListType',
                    CollectionPath : 'PRICINGPRODUCTDESC',
                    Label : 'Product Description',
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
    MFRNR@(title:'Manufacturer'); 
}