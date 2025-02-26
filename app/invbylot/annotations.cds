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
            WAREHOUSE_STATUS
            
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
                Label : 'Sales Office'
            },
            {
                $Type : 'UI.DataField',
                Value : MFRNR,
                Label : 'Manufacturer'
            }
        ],
    },
    
    
)

{   
    MATNR@(title: 'SKU');
    MFRPN@(
        title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTPRODUCTCODE',
                Label : 'Product Code',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : 'MFRPN',
                        ValueListProperty : 'MFRPN'
                    },
                    {
                        $Type             : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                        ValueListProperty : 'MAKTX',
                    },
                    
                ]
            },
        } 
    
    );
    MAKTX@(title: 'Product Description');
    SIZE@(title: 'Size');
    CHARG@(
        title: 'Batch Number',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTLOT',
                Label : 'Batch Number',
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
    VFDAT@(title: 'Shelf Life or Best-Before Date');
    EAN11@(title: 'UPC');
    WAREHOUSE_STATUS@(
        title: 'Warehouse Status',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTWAREHOUSE',
                Label : 'Warehouse/Status',
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
    ON_HAND@(title: 'On Hand');
    UNIT@(title: 'Base Unit of Measure');
    DAYS_UNTIL_EXPIRY@(title: 'Report Date');
    LGNUM@(title:'Warehouse Number');
    DIN@(title: 'DIN');
    PLANT@(title:'Plant');
    VKBUR@(title: 'Sales Office',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTVKBUR',
                Label : 'Sales Office',
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
    MFRNR@(title:'Manufacturer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVBYLOTMFRNR',
                Label : 'Warehouse/Status',
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
};