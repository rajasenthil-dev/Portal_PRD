using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYBYLOT with @(
    odata: {
        filterable: {
            MATNR: true, 
            WAREHOUSE_STATUS: true, 
            EAN11: true, 
            MFRPN: true, 
            LGNUM: true, 
            MFRNR: true, 
            MAKTX: true, 
            CHARG: true, 
            PLANT: true, 
            DIN: true, 
            VKBUR: true
        }
    },
    UI : {
        SelectionFields  : [
            MFRPN, 
            CHARG,
            WAREHOUSE_STATUS,
            MFRNR,
            MFRNR_NAME,
            VKBUR
            
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'SKU',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MFRPN,
                Label : 'Product Code',
                ![@HTML5.CssDefaults] : {width : '10rem'}

            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description',
                ![@HTML5.CssDefaults] : {width : '10rem'}
                
            },
            {
                $Type : 'UI.DataField',
                Value : SIZE,
                Label : 'Size',
            },
            {
                $Type : 'UI.DataField',
                Value : CHARG,
                Label : 'Batch Number',
            },
            {
                $Type : 'UI.DataField',
                Value : VFDAT,
                Label : 'Shelf Life or Best-Before Date',
                
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_STATUS,
                Label : 'Warehouse Status'
            },
            {
                $Type : 'UI.DataField',
                Value : EAN11,
                Label : 'UPC'
            },
            {
                $Type : 'UI.DataField',
                Value : ON_HAND,
                Label : 'Qty On Hand'
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT,
                Label : 'Base Unit of Measure'
            },
            {
                $Type : 'UI.DataField',
                Value : DAYS_UNTIL_EXPIRY,
                Label : 'Days Until Expiry',
                ![@HTML5.CssDefaults] : {width : '7.813rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : LGNUM,
                Label : 'Warehouse Number'
            },
            {
                $Type : 'UI.DataField',
                Value : DIN,
                Label : 'DIN'
            },
            {
                $Type : 'UI.DataField',
                Value : PLANT,
                Label : 'Plant'
            },
            {
                $Type : 'UI.DataField',
                Value : VKBUR,
                Label : 'Sales Org.'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer #'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR_NAME,
                Label : 'Manufacturer Name'
            }
        ],
    },
    
    
)

{   
    
    MFRPN@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTPRODUCTCODE',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : 'MFRPN',
                        ValueListProperty : 'MFRPN'
                    }
                    
                ]
            },
        } 
    
    );
    
    CHARG@(
        Common: {
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTLOT',
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
                CollectionPath : 'INVBYLOTWAREHOUSE',
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
    
    VKBUR@(
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTVKBUR',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'VKBUR',
                        ValueListProperty : 'VKBUR'
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
                CollectionPath : 'INVBYLOTMFRNR',
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
                CollectionPath : 'INVBYLOTMFRNRNAME',
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