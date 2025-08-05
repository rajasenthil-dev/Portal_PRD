using SALES as service from '../../srv/service';
// Annotations for the Filter Bar and TreeTable Columns
// All UI annotations are now consolidated into a single block.
annotate SALES.PIVOTTABLE with @(
    UI: {
        // Defines the fields that will automatically appear in the FilterBar
        SelectionFields: [
            VKORG_ANA_SALES_ORGANIZATION,
            KUNAG_ANA_SOLD_TO_PARTY,
            MATNR_MATERIAL,
            FKDAT_ANA_BILLING_DATE,
            FKART_ANA_BILLING_TYPE
        ],

        // Defines the default columns and their labels for tables/lists
        LineItem: [
            { Value: NodeText, Label: 'Name' },
            { Value: NETWR_NET_VALUE, Label: 'Net Value' },
            { Value: FKIMG_INVOICED_QUANTITY, Label: 'Invoiced Quantity' },
            { Value: PROVINCE, Label: 'Province' },
            { Value: KUNAG_ANA_SOLD_TO_PARTY, Label: 'Customer' }
        ],

        // This tells the mdc.Table how to render the hierarchy.
        PresentationVariant: {
            Visualizations: [
                '@UI.LineItem'
            ],
            SortOrder: [{
                Property: NodeText,
                Descending: false
            }]
        },

        // // Correctly placed inside the main UI block
        // Hierarchy: {
        //     LevelFor: 'HierarchyLevel',
        //     ParentFor: 'ParentNodeID',
        //     NodeFor: 'NodeID',
        //     DrillStateFor: 'DrillState' // The view must provide this field (e.g., 'expanded', 'collapsed')
        // }
    }
);

// Annotations for individual properties to provide better labels and semantics
annotate SALES.PIVOTTABLE with {
    // These annotations will provide nice labels in the filter bar and column headers
    VKORG_ANA_SALES_ORGANIZATION @(
        title: 'Sales Org',
        Common.Label: 'Sales Organization'
    );
    KUNAG_ANA_SOLD_TO_PARTY @(
        title: 'Customer',
        Common.Label: 'Customer'
    );
    MATNR_MATERIAL @(
        title: 'Product',
        Common.Label: 'Product'
    );
    FKDAT_ANA_BILLING_DATE @(
        title: 'Billing Date',
        Common.Label: 'Billing Date'
    );
    FKART_ANA_BILLING_TYPE @(
        title: 'Billing Type',
        Common.Label: 'Billing Type'
    );
    NETWR_NET_VALUE @(
        title: 'Net Value',
        Measures.Unit: 'USD' // You can change the currency code as needed
    );
    FKIMG_INVOICED_QUANTITY @(
        title: 'Invoiced Quantity'
    );
    NodeText @(title: 'Name');
    PROVINCE @(title: 'Province');
};

