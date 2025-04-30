using INVENTORY.INVENTORYAUDITTRAIL as service from '../../srv/service';

annotate INVENTORY.INVENTORYAUDITTRAIL with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            MATNR: true,
            MFRNR_PROD_CODE: true,
            MAKTX: true, 
            CHARG: true,
            POSTING_DATE: true, 
            WAREHOUSE_STATUS:true, 
            KUNNR:true, 
            CUSTOMER_NAME:true, 
            INV_MATDOC_ITEM:true, 
            WERKS:true, 
            PLANT_NAME: true,
            LGORT:true, 
            MFRNR:true
        }
    },
    UI : {
        SelectionFields  : [
            MFRNR_PROD_CODE,
            POSTING_DATE,
            CHARG, 
            WAREHOUSE_STATUS, 
            KUNNR,
            CUSTOMER_NAME,
            MFRNR,
            MFRNR_NAME
        ],
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : CURRENT,
                Label : '{i18n>INVENTORYAUDITTRAIL.CURRENT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : '{i18n>INVENTORYAUDITTRAIL.MATNR}',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_PROD_CODE,
                Label : '{i18n>INVENTORYAUDITTRAIL.MFRNR_PROD_CODE}',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : '{i18n>INVENTORYAUDITTRAIL.MAKTX}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : POSTING_DATE,
                Label : '{i18n>INVENTORYAUDITTRAIL.POSTING_DATE}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TRAN_TYPE,
                Label : '{i18n>INVENTORYAUDITTRAIL.TRAN_TYPE}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MENGE,
                Label : '{i18n>INVENTORYAUDITTRAIL.MENGE}',
                ![@HTML5.CssDefaults] : {width : '6rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MEINS,
                Label : '{i18n>INVENTORYAUDITTRAIL.MEINS}',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CHARG,
                Label : '{i18n>INVENTORYAUDITTRAIL.CHARG}',
                ![@HTML5.CssDefaults] : {width : '4rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : SHELF_LIFE_EXP_DT,
                Label : '{i18n>INVENTORYAUDITTRAIL.SHELF_LIFE_EXP_DT}'
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_STATUS,
                Label : '{i18n>INVENTORYAUDITTRAIL.WAREHOUSE_STATUS}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : KUNNR,
                Label : '{i18n>INVENTORYAUDITTRAIL.KUNNR}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_NAME,
                Label : '{i18n>INVENTORYAUDITTRAIL.CUSTOMER_NAME}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : INV_MATDOC_ITEM,
                Label : '{i18n>INVENTORYAUDITTRAIL.INV_MATDOC_ITEM}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : WERKS,
                Label : '{i18n>INVENTORYAUDITTRAIL.WERKS}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT_NAME,
                Label : '{i18n>INVENTORYAUDITTRAIL.NAME1_PLANT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DIN,
                Label : '{i18n>INVENTORYAUDITTRAIL.DIN}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : RBTXT,
                Label : '{i18n>INVENTORYAUDITTRAIL.RBTXT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : TBTXT,
                Label : '{i18n>INVENTORYAUDITTRAIL.TBTXT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LGORT,
                Label : '{i18n>INVENTORYAUDITTRAIL.LGORT}',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : '{i18n>INVENTORYAUDITTRAIL.MFRNR}'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : '{i18n>INVENTORYAUDITTRAIL.MFRNR_NAME}'
            }
        ],
    },
    
)

{   
    MFRNR_PROD_CODE@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATPRODUCTCODE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRNR_PROD_CODE',
                        ValueListProperty : 'MFRNR_PROD_CODE'
                    }
                ]
            },
        } 
    );
    CHARG@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATLOT',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CHARG',
                        ValueListProperty : 'CHARG'
                    }
                ]
            },
        }    
    );
    WAREHOUSE_STATUS@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATWAREHOUSE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'WAREHOUSE_STATUS',
                        ValueListProperty : 'WAREHOUSE_STATUS'
                    }
                ]
            },
        }     
    );
    KUNNR@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATCUSTSUPP',
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
    CUSTOMER_NAME@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATCUSTSUPPNAME',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'CUSTOMER_NAME',
                        ValueListProperty : 'CUSTOMER_NAME'
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
                CollectionPath : 'IATMFRNR',
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
    MFRNR_NAME@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'IATMFRNRNAME',
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