sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/BusyIndicator"
], (Controller, JSONModel, BusyIndicator) => {
    "use strict";

    return Controller.extend("invaudittrail.controller.View1", {
        onInit: function () {
            // Initialize a model for tile counts
            var oTileCountsModel = new JSONModel({
                counts: {
                    Order: 0,
                    Receipt: 0,
                    Adjustments: 0,
                    Returns: 0,
                    PhysicalCount: 0
                }
            });
            this.getView().setModel(oTileCountsModel, "transactionCounts");

            // Get the SmartTable and bind the data change event
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
         },
        _calculateTotals: function () {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows");

            var aContexts = oBinding.getContexts(0, oBinding.getLength());
            var oTileCounts = {
                Order: 0,
                Receipt: 0,
                Adjustments: 0,
                Returns: 0,
                PhysicalCount: 0
            };
            var fTotalQuantity = 0;
            
            aContexts.forEach(function (oContext) {
            fTotalQuantity += parseFloat(oContext.getProperty("MENGE")) || 0;
                var oData = oContext.getObject();
                if (oData.TRAN_TYPE && oData.MENGE) {
                    var iQuantity = parseFloat(oData.MENGE);
                    if (!isNaN(iQuantity)){
                        switch (oData.TRAN_TYPE) {
                            case "Order":
                                oTileCounts.Order += iQuantity;
                                break;
                            case "Receipt":
                                oTileCounts.Receipt += iQuantity;
                                break;
                            case "Adjustments":
                                oTileCounts.Adjustments += iQuantity;
                                break;
                            case "Returns":
                                oTileCounts.Returns += iQuantity;
                                break;
                            case "PhysicalCount":
                                oTileCounts.PhysicalCount += iQuantity;
                                break;
                        }
                    }
                }
            });
            var formattedQuantity = this._formatNumber(fTotalQuantity);

            // Update the model with calculated totals
            this.getView().getModel("transactionCounts").setProperty("/counts", oTileCounts);
            this.byId("footerText1").setText(formattedQuantity);
            
        },
        
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);
        },
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
        }
        
        
    });
});