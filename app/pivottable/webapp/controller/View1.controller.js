sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/m/MessageToast"
], function (Controller, JSONModel, Filter, FilterOperator, MessageToast) {
    "use strict";

    return Controller.extend("pivottable.controller.View1", {
         /**
         * Called when the controller is instantiated.
         */
        onInit: function () {
            // Perform an initial load of the summary data without any filters.
            this._updateSummaryPanel([]);
        },

        /**
         * Triggered when the user clicks the "Search" button.
         * Manually constructs filters from the input fields.
         */
        onFilterBarSearch: function () {
            const aFilters = [];
            const oView = this.getView();

            const sSalesOrg = oView.byId("filterSalesOrg").getValue();
            const sCustomer = oView.byId("filterCustomer").getValue();
            const sProduct = oView.byId("filterProduct").getValue();
            const oDateRange = oView.byId("filterDate");
            const dDateFrom = oDateRange.getDateValue();
            const dDateTo = oDateRange.getSecondDateValue();

            if (sSalesOrg) {
                aFilters.push(new Filter("VKORG_ANA_SALES_ORGANIZATION", FilterOperator.Contains, sSalesOrg));
            }
            if (sCustomer) {
                aFilters.push(new Filter("KUNAG_ANA_SOLD_TO_PARTY", FilterOperator.Contains, sCustomer));
            }
            if (sProduct) {
                aFilters.push(new Filter("MATNR_MATERIAL", FilterOperator.Contains, sProduct));
            }
            if (dDateFrom && dDateTo) {
                aFilters.push(new Filter("FKDAT_ANA_BILLING_DATE", FilterOperator.BT, dDateFrom, dDateTo));
            }
            
            this._applyTableFilters(aFilters);
        },

        /**
         * Clears all filter inputs and resets the table binding.
         */
        onFilterBarClear: function() {
            const oView = this.getView();
            oView.byId("filterSalesOrg").setValue("");
            oView.byId("filterCustomer").setValue("");
            oView.byId("filterProduct").setValue("");
            oView.byId("filterDate").setValue("");
            this._applyTableFilters([]);
        },

        /**
         * Handles the press event for the "Ladega Products" button.
         */
        onFilterLadega: function () {
            const oProductFilter = new Filter("MATNR_MATERIAL", FilterOperator.Contains, "Ladega");
            this._applyTableFilters([oProductFilter]);
        },

        /**
         * Handles the press event for the "Cystadrops Products" button.
         */
        onFilterCystadrops: function () {
            const oProductFilter = new Filter("MATNR_MATERIAL", FilterOperator.Contains, "Cystadrops");
            this._applyTableFilters([oProductFilter]);
        },

        /**
         * Helper function to apply a filter array to the table and update the summary panel.
         * @param {sap.ui.model.Filter[]} aFilters The filters to apply.
         */
        _applyTableFilters: function(aFilters) {
            this.getView().byId("salesTable").getBinding("items").filter(aFilters);
            this._updateSummaryPanel(aFilters);
        },

        /**
         * Fetches aggregated data from the backend to update the summary tiles.
         * @param {sap.ui.model.Filter[]} aFilters The filters to apply to the aggregation.
         */
        _updateSummaryPanel: function (aFilters) {
            const oModel = this.getView().getModel();
            if (!oModel) { return; }
            
            const sApply = "aggregate(" +
                "NETWR_NET_VALUE with sum as TotalSales," +
                "FKIMG_INVOICED_QUANTITY with sum as TotalUnits," +
                "$count as TotalLines," +
                "VBELN_BILLING_DOCUMENT with countdistinct as TotalInvoices" +
            ")";

            const oSummaryBinding = oModel.bindList("/PIVOTTABLE", null, null, aFilters, {
                $apply: sApply
            });

            oSummaryBinding.requestContexts(0, 1).then(aContexts => {
                if (aContexts && aContexts.length > 0) {
                    const oSummaryData = aContexts[0].getObject();
                    this.byId("totalSales").setValue(oSummaryData.TotalSales || "0.00");
                    this.byId("totalUnits").setValue(oSummaryData.TotalUnits || "0");
                    this.byId("totalLines").setValue(oSummaryData.TotalLines || "0");
                    this.byId("totalInvoices").setValue(oSummaryData.TotalInvoices || "0");
                }
            }).catch(oError => {
                console.error("Error fetching summary data:", oError);
                MessageToast.show("Could not load summary data.");
            });
        }
    });
});