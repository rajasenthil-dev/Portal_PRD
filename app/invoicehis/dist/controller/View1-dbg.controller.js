sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/format/NumberFormat"
], (Controller, JSONModel, NumberFormat) => {
    "use strict";

    return Controller.extend("invoicehis.controller.View1", {
        onInit: function () {
            const oSmartTable = this.byId("table0");
            const oTable = oSmartTable.getTable();
            //oTable.attachEvent("rowsUpdated", this._fetchVisibleData.bind(this));
        },

        // _fetchVisibleData: function () {
        //     debugger
        //     const oModel = this.getView().getModel(); // OData v2 model
        //     const sPath = "/SalesSummary"; // Aggregation endpoint

        //     oModel.read(sPath, {
        //         success: (oData) => {
        //             const { TotalSales, UniqueInvoices, TotalPST, TotalGST } = oData;

        //             // Update summary panel
        //             this.getView().setModel(new JSONModel({
        //                 totalSales: this._formatLargeNumber(TotalSales),
        //                 totalInvoices: this._formatLargeNumber(UniqueInvoices)
        //             }), "summary");

        //             // Update footer
        //             this._updateFooter(TotalSales, TotalPST, TotalGST);
        //         },
        //         error: (oError) => {
        //             console.error("Failed to fetch aggregated data", oError);
        //         }
        //     });
        // },

        _updateFooter: function (totalSales, totalPST, totalGST) {
            const oTable = this.byId("table");
            const oFooterData = {
                sales: this._formatCurrency(totalSales),
                pst: this._formatCurrency(totalPST),
                gst: this._formatCurrency(totalGST)
            };

            // Assuming footer is rendered with custom rows or JSON binding
            const oFooterModel = new JSONModel(oFooterData);
            oTable.setModel(oFooterModel, "footer");
        },

        _formatLargeNumber: function (value) {
            const oNumberFormat = NumberFormat.getFloatInstance({
                style: "short",
                minFractionDigits: 0,
                maxFractionDigits: 1
            });
            return oNumberFormat.format(value);
        },

        _formatCurrency: function (value) {
            const oCurrencyFormat = NumberFormat.getCurrencyInstance({
                currencyCode: false
            });
            return oCurrencyFormat.format(value, "USD");
        },
        // _formatCurrency : function(value) {
        //     return new Intl.NumberFormat('en-US', {
        //         style: 'currency',
        //         currency: 'USD',
        //         minimumFractionDigits: 2,
        //         maximumFractionDigits: 2,
        //     }).format(value);
        // },
        _formatDate: function (date) {
            if (!date) return ""; // Return empty string if no date is provided
        
            let oDate;
        
            // Handle string date (e.g., 'yyyyMMdd')
            if (typeof date === "string") {
                if (date.length === 8) { // Ensure the format is correct
                    const formattedDateString = date.slice(0, 4) + '-' + date.slice(4, 6) + '-' + date.slice(6, 8);
                    oDate = new Date(formattedDateString + "T00:00:00Z"); // Force UTC for consistency
                } else {
                    return ""; // Invalid string format
                }
            }
            // Handle Date object
            else if (date instanceof Date) {
                oDate = new Date(date.getTime()); // Clone to avoid mutation
            } else {
                return ""; // Unsupported type
            }
        
            // Check if the date is valid
            if (isNaN(oDate.getTime())) {
                return ""; // Return empty string for invalid date
            }
        
            // Adjust for local timezone only if necessary
            // Remove the offset adjustment if using UTC consistently across your app
            oDate.setMinutes(oDate.getMinutes() + oDate.getTimezoneOffset());
        
            // Format the date into a more readable string
            const oDateFormat = sap.ui.core.format.DateFormat.getDateInstance({
                style: "medium" // Use 'medium' style or customize as needed
            });
        
            // Return the formatted date
            return oDateFormat.format(oDate);
        },
        _removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        },
        _formatNumberSuffix : function (value, isDollarAmount = true) {
            if (typeof value !== "number") {
                return value;
            }

            var absValue = Math.abs(value);
            let formattedValue;

            if (absValue >= 1_000_000) {
                if (isDollarAmount){
                    formattedValue = (value / 1_000_000).toFixed(2) + "M";
                }
                formattedValue = (value / 1_000_000) + "M";
            } else if (absValue >= 1_000) {
                if (isDollarAmount) {
                    formattedValue = (value / 1_000).toFixed(2) + "K"
                }
                formattedValue = (value / 1_000) + "K"
            } else {
                if (isDollarAmount) {
                    formattedValue = formattedValue.toFixed(2);
                }
                formattedValue = value
            }

            return formattedValue;
        }
    });
});