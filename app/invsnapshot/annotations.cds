using INVENTORY as service from '../../srv/service';

annotate INVENTORY.INVENTORYSNAPSHOT with @(
Search.defaultSearchElement: true,
    odata: {
        filterable: {
            MATNR: true,
            MFRPN: true, 
            MAKTX: true, 
            SIZE:true,
            CHARG:true,
            WAREHOUSE_STATUS:true,
            VKORG:true,
            MFRNR:true,
            LGNUM: true,
            EAN11: true
        }
    },
    UI : {
        SelectionFields  : [
            MFRPN,
            MAKTX, 
            CHARG,
            WAREHOUSE_STATUS, 
            REPORT_DATE,
            
        ],
        
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : MATNR,
                Label : 'SKU'

            },
            {
                $Type : 'UI.DataField',
                Value : MFRPN,
                Label : 'Product Code'

            },
            {
                $Type : 'UI.DataField',
                Value : MAKTX,
                Label : 'Product Description'
                
            },
            {
                $Type : 'UI.DataField',
                Value : SIZE,
                Label : 'Size',
                ![@HTML5.CssDefaults] : {width : '5rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : CHARG,
                Label : 'Batch Number'
            },
            {
                $Type : 'UI.DataField',
                Value : VFDAT,
                Label : 'Shelf Life Expiration or Best-Before Date'  
            },
            {
                $Type : 'UI.DataField',
                Value : LGNUM,
                Label : 'Warehouse Number/Warehouse Complex',
                ![@HTML5.CssDefaults] : {width : '15rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : WAREHOUSE_STATUS,
                Label : 'Warehouse Status'
            },
            {
                $Type : 'UI.DataField',
                Value : ON_HAND,
                Label : 'On Hand'
            },
            {
                $Type : 'UI.DataField',
                Value : UNIT,
                Label : 'Base Unit of Measure',
                ![@HTML5.CssDefaults] : {width : '10rem'}
            },
            {
                $Type : 'UI.DataField',
                Value : DAYS_UNTIL_EXPIRY,
                Label : 'Days Until Expiry'
            },
            {
                $Type : 'UI.DataField',
                Value : REPORT_DATE,
                Label : 'Report Date'
            },
            {
                $Type : 'UI.DataField',
                Value : EAN11,
                Label : 'UPC'
            },
            {
                $Type : 'UI.DataField',
                Value : VKORG,
                Label : 'Sales Org.'
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
    MFRPN@(title: 'Product Code',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPPROD',
                Label : 'Product Code',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterOut',
                        LocalDataProperty : 'MFRPN',
                        ValueListProperty : 'MFRPN'
                    }
                ]
            },
        }      
    );
    MAKTX@(
        title: 'Product Description',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPPRODDESC',
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
    SIZE@(title: 'Size');
    CHARG@(
        title: 'Batch Number',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPLOT',
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
    VFDAT@(title: 'Shelf Life Expiration or Best-Before Date');
    LGNUM@(title: 'Warehouse Number/Warehouse Complex');
    WAREHOUSE_STATUS@(
        title: 'Warehouse Status',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPWARESTAT',
                Label : 'Warehouse Status',
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
    DAYS_UNTIL_EXPIRY@(title: 'Days Until Expiry');
    REPORT_DATE@(title: 'Report Date');
    EAN11@(title: 'UPC');
    VKORG@(
        title: 'Sales Org.',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPVKORG',
                Label : 'Sales Organization',
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
    MFRNR@(
        title: 'Manufacturer',
        Common: {
            ValueListWithFixedValues,
            ValueList : {
                $Type : 'Common.ValueListType',
                CollectionPath : 'INVSNAPMFRNR',
                Label : 'Manufacturer',
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