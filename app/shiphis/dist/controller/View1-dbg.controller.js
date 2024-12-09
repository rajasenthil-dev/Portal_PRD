sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("shiphis.controller.View1", {
        onInit: function () {
            var oSmartTable = this.byId("table0"); // Get the SmartTable by ID
            var oTable = oSmartTable.getTable();   // Access the underlying table
        
            // Attach event for rowsUpdated to handle dynamic updates
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        
            // Listen to binding's dataReceived event to get the full dataset after initial loading
            var oBinding = oTable.getBinding("rows");
            if (oBinding) {
                oBinding.attachEventOnce("dataReceived", function () {
                    this._calculateInitialTotals(oBinding); // Pass the binding directly
                }.bind(this));
            }
        },
        
        /**
         * Calculate totals on initialization with full dataset.
         */
        _calculateInitialTotals: function (oBinding) {
            debugger
            if (oBinding) {
                var oModel = oBinding.getModel();
                var sPath = oBinding.getPath();
                
                // Get all data directly from the model
                var aData = oModel.getProperty(sPath) || [];
                this._updateTotals(aData); // Use the shared function to calculate totals
            }
        },
        
        /**
         * Event-driven totals calculation for visible/filtered data.
         */
        _calculateTotals: function () {
            debugger
            var oTable = this.byId("table0").getTable();
            var oBinding = oTable.getBinding("rows");
            var fTotalLinesShipped = 0;
            fTotalLinesShipped = oBinding.getCount();
             
        
            if (oBinding) {
                // Get only the currently visible/filtered data
                var aContexts = oBinding.getContexts(0, fTotalLinesShipped);
                var aFilteredData = aContexts.map(function (oContext) {
                    return oContext.getObject();
                });
                var formattedLinesShipped = fTotalLinesShipped.toString();
                this.byId("_IDGenNumericContent2").setText(formattedLinesShipped);
                this._updateTotals(aFilteredData);
            }
        },
        
        /**
         * Perform totals calculation and update UI elements.
         */
        _updateTotals: function (aData) {
            var oTable = this.byId("table0").getTable();
            var oBinding = oTable.getBinding("rows");
            debugger
            if (aData.length > 0) {
                var fTotalOrdersShipped = 0;   // Total for Orders Shipped
                
                var fTotalItemAmount = 0;     // Total for Item Amount
        
                var oUniqueInvoices = new Set(); // Track unique invoices
                
                // Iterate through the data
                aData.forEach(function (oRowData) {
                    var sInvoice = oRowData["VBELN"]; // Invoice number (adjust if necessary)
                    var fItemAmount = parseFloat(oRowData["FKIMG"]) || 0; // Item amount (adjust if necessary)
        
                    if (sInvoice) {
                        oUniqueInvoices.add(sInvoice); // Track unique invoices
                    }
        
                    // Increment total lines shipped
                    
        
                    // Sum up item amount
                    fTotalItemAmount += fItemAmount;
                });
                
                // Total unique invoices equals Orders Shipped
                fTotalOrdersShipped = oUniqueInvoices.size;
        
                // Format totals (adjust formatting as needed)
                var formattedOrdersShipped = fTotalOrdersShipped.toString();
                var formattedItemAmount = fTotalItemAmount.toFixed(2); // Format as currency if needed
        
                // Bind the totals to respective UI elements
                this.byId("_IDGenNumericContent1").setText(formattedOrdersShipped); // Orders Shipped
                  // Lines Shipped
                this.byId("_IDGenNumericContent3").setText(formattedItemAmount);     // Item Amount
            } else {
                // If no data, clear the UI fields
                this.byId("_IDGenNumericContent1").setText("0");
                this.byId("_IDGenNumericContent3").setText("0.00");
            }
        },
        _formatCurrency : function(value) {
            return new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
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
        },
        /** 
         * @param {boolean} [b12HourFomat]
        **/
        _formatTime: function (sTime, b12HourFomat) {
            if (!sTime) {
                return ""
            }

            var iHours = parseInt(sTime.substr(0, 2), 10);
            var iMinutes = parseInt(sTime.substr(2, 2), 10);
            var iSeconds = parseInt(sTime.substr(4, 2), 10);

            var sPeriod = iHours > 12 ? "PM" : "AM";
            iHours = iHours % 12 || 12;
            
            var sFormattedTime = iHours + ":" + String(iMinutes).padStart(2, "0") + ":" + String(iSeconds).padStart(2, "0") + " " + sPeriod;

            return sFormattedTime;
        },
        _removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        }
    });
});