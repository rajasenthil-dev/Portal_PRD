using PROCESSING as service from '../../srv/service';

annotate PROCESSING.SHIPPINGSTATUS with @(
    Search.defaultSearchElement: true,
    UI : {
        SelectionFields  : [
            OBD_ITEM_NO_ITEMNO,
            CUSTOMER_PO_BSTNK,
            PRODUCT_DESCRIPTION_MAKTX,
            PICK_AND_PACK_STATUS_SALES_SHIPPING_STATUS,
            VKORG

        ],
        LineItem : [
            {
                $Type : 'UI.DataField',
                Value : CUSTOMER_PO_BSTNK
            },
            {
                $Type : 'UI.DataField',
                Value : OBD_ITEM_NO_ITEMNO
            },
            {
                $Type : 'UI.DataField',
                Value : OBD_NO_DOCNO_C
            },
            {
                $Type : 'UI.DataField',
                Value : OBD_TIMESTAMP_LAST_STATUS_TIME_PLANT_BASED
            },
            {
                $Type : 'UI.DataField',
                Value : PICK_AND_PACK_STATUS_SALES_SHIPPING_STATUS
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_DESCRIPTION_MAKTX
            },
            {
                $Type : 'UI.DataField',
                Value : QUANTITY_ORDERED_QTY
            },
            {
                $Type : 'UI.DataField',
                Value : REQUESTED_DELIVERY_DATE_VDATU
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_NAME_PARTNER
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_PARTYNO
            },
            {
                $Type : 'UI.DataField',
                Value : SO_NO_REFDOCNO
            },
            {
                $Type : 'UI.DataField',
                Value : STORAGE_CONDITIONS_STOKEY1
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_NAME_LNUMT
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_TIME_ZONE
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG
            }
        ]
    } 
);