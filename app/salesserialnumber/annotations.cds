using SALES as service from '../../srv/service';
annotate SALES.SALESSERIALNUMBER with @(
Search.defaultSearchElement: true,
    UI : {
        SelectionFields  : [
            
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : SALES_ORDER_NO
            },
            {
                $Type : 'UI.DataField',
                Value : PURCHASE_ORDER_BSTKD
            },
            {
                $Type : 'UI.DataField',
                Value : INVOICE_DATE_FKDAT
            },
            {
                $Type : 'UI.DataField',
                Value : INVOICE_CREDIT_NO
            },
            {
                $Type : 'UI.DataField',
                Value : SKU
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION
            },
            {
                $Type : 'UI.DataField',
                Value : AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : QUANTITY
            },
            {
                $Type : 'UI.DataField',
                Value : LOT
            },
            {
                $Type : 'UI.DataField',
                Value : DOCUMENT_TYPE
            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO_NAME
            },
            {
                $Type : 'UI.DataField',
                Value : BILL_TO_NO
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_NAME
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_NO
            },
            {
                $Type : 'UI.DataField',
                Value : ADDRESS_1
            },
            {
                $Type : 'UI.DataField',
                Value : ADDRESS_2
            },
            {
                $Type : 'UI.DataField',
                Value : CITY
            },
            {
                $Type : 'UI.DataField',
                Value : POSTAL_CODE
            },
            {
                $Type : 'UI.DataField',
                Value : PROVINCE
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT_PRICE
            },
            {
                $Type : 'UI.DataField',
                Value : TIME_OFF_DELIVERY
            },
            {
                $Type : 'UI.DataField',
                Value : DELIVERY_DATE
            },
            {
                $Type : 'UI.DataField',
                Value : SALES_ORG
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : ORDER_TYPE
            },
            {
                $Type : 'UI.DataField',
                Value : ORDER__REASON
            },
            {
                $Type : 'UI.DataField',
                Value : ORDER_REASON_DESCRIPTION
            },
            {
                $Type : 'UI.DataField',
                Value : VGBEL
            },
            {
                $Type : 'UI.DataField',
                Value : SERIAL_NUMBER
            },
            {
                $Type : 'UI.DataField',
                Value : EXP_DATE
            }
        ],
    }, 
){
    // INVOICE_CREDIT_VBELN@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCINVOICE',
    //             Label : 'Invoice #',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'INVOICE_CREDIT_VBELN',
    //                     ValueListProperty : 'INVOICE_CREDIT_VBELN'
    //                 }
    //             ]
    //         },
    //     } 
        
    // );
    // PRODUCT_DESCRIPTION_MAKTX@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCPRODDESC',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'PRODUCT_DESCRIPTION_MAKTX',
    //                     ValueListProperty : 'PRODUCT_DESCRIPTION_MAKTX'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // LOT_CHARG@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCLOT',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'LOT_CHARG',
    //                     ValueListProperty : 'LOT_CHARG'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // VTEXT_FKART@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCTYPE',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'VTEXT_FKART',
    //                     ValueListProperty : 'VTEXT_FKART'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // BILL_TO_KUNRE_ANA@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCBILLTOID',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'BILL_TO_KUNRE_ANA',
    //                     ValueListProperty : 'BILL_TO_KUNRE_ANA'
    //                 }
    //             ]
    //         },
    //     }
    // );
    // BILL_TO_NAME@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCBILLTO',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'BILL_TO_NAME',
    //                     ValueListProperty : 'BILL_TO_NAME'
    //                 }
    //             ]
    //         },
    //     }
    // );
    // SHIP_TO_KUNWE_ANA@(
    //      Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCSHIPTOID',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'SHIP_TO_KUNWE_ANA',
    //                     ValueListProperty : 'SHIP_TO_KUNWE_ANA'
    //                 }
    //             ]
    //         },
    //     }
    // );
    // SHIP_TO_NAME@(
    //     Common: {
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCSHIPTO',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'SHIP_TO_NAME',
    //                     ValueListProperty : 'SHIP_TO_NAME'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // WAREHOUSE@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCWAREHOUSE',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'WAREHOUSE',
    //                     ValueListProperty : 'WAREHOUSE'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // BILL_TO_TYPE@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCCUSTOMERTYPE',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'BILL_TO_TYPE',
    //                     ValueListProperty : 'BILL_TO_TYPE'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // MFRNR@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCMFRNR',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterInOut',
    //                     LocalDataProperty : 'MFRNR',
    //                     ValueListProperty : 'MFRNR'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // MFRNR_NAME@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCMFRNRNAME',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'MFRNR_NAME',
    //                     ValueListProperty : 'MFRNR_NAME'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // CO_VKORG@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCSALESORG',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'CO_VKORG',
    //                     ValueListProperty : 'CO_VKORG'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // VKBUR@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCSALESOFFICE',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'VKBUR',
    //                     ValueListProperty : 'VKBUR'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // BEZEI@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCBEZEI',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'BEZEI',
    //                     ValueListProperty : 'BEZEI'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // BEZEI_AUART@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCBEZEIAUART',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'BEZEI_AUART',
    //                     ValueListProperty : 'BEZEI_AUART'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
    // PLANT_NAME@(
    //     Common: {
    //         ValueListWithFixedValues,
    //         ValueList : {
    //             $Type : 'Common.ValueListType',
    //             CollectionPath : 'SBCPLANTNAME',
    //             Parameters : [
    //                 {
    //                     $Type : 'Common.ValueListParameterOut',
    //                     LocalDataProperty : 'PLANT_NAME',
    //                     ValueListProperty : 'PLANT_NAME'
    //                 }
    //             ]
    //         },
    //     }
        
    // );
};