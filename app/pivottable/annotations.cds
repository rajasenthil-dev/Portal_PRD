using SALES as service from '../../srv/service';
// Annotations for the Filter Bar and TreeTable Columns
// All UI annotations are now consolidated into a single block.
annotate SALES.PIVOTTABLE with @(
    UI: {
        // Defines the fields that will automatically appear in the FilterBar
        SelectionFields: [
            PROVINCE_REGIO,
            SHIP_TO_NAME,
        ],

        // Defines the default columns and their labels for tables/lists
        LineItem: [
            {
                $Type : 'UI.DataField',
                Value : MAKTX
            },
            {
                $Type : 'UI.DataField',
                Value : PROVINCE_REGIO
            },
            {
                $Type : 'UI.DataField',
                Value : SHIP_TO_NAME
            },
            {
                $Type : 'UI.DataField',
                Value : INVOICE_DATE_FKDAT
            },
            {
                $Type : 'UI.DataField',
                Value : QUANTITY_FKIMG
            },
        ],

        
    }
);




