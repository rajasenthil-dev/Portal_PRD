sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("cashjour.controller.View1", {
        onInit: function () {
            var oSmartTable = this.byId("table0"); // Get the SmartTable by ID
            var oTable = oSmartTable.getTable();   // Access the underlying table
            
            this._debouncedCalculateTotals = this._debounce(this._calculateTotals.bind(this), 300);
            oTable.attachEvent("rowsUpdated", this._debouncedCalculateTotals);
        },
        _calculateTotals: function (oEvent) {
            var oTable = oEvent.getSource();
            var oBinding = oTable.getBinding("rows");  // Get the rows binding
            
            // Ensure that the binding exists and is set up
            if (oBinding) {
                var aContexts = oBinding.getContexts();  // Get the data rows
                var fTotalNetWr = 0;   // Total for NETWR (Invoice Amount)
                var fTotalCashReceived = 0;  // Total for CAL_CASH_RECEIVED (Cash Received)
                var fTotalDiscount = 0;  // Total for CAL_CASH_RECEIVED (Cash Received)
        
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    fTotalNetWr += parseFloat(oContext.getProperty("NETWR")) || 0;
                    fTotalCashReceived += parseFloat(oContext.getProperty("CAL_CASH_RECEIVED")) || 0;
                    fTotalDiscount += parseFloat(oContext.getProperty("CAL_DISCOUNT")) || 0;
                });
                var formattedNetWr = this._formatCurrency(fTotalNetWr);
                var formattedCashReceived = this._formatCurrency(fTotalCashReceived);
                var formattedDiscount = this._formatCurrency(fTotalDiscount);
                // Update footer with the calculated totals
                
                this.byId("TotUnitsPriceText").setText(formattedNetWr);
                this.byId("TotUnitsInStockText").setText(formattedCashReceived);
                this.byId("TotUnitsOnOrderText").setText(formattedDiscount);
            }
        },
        _debounce: function(func, wait) {
            let timeout;
            return function (...args) {
                const context = this;
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(context, args), wait);
            };
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
        }
    });
});