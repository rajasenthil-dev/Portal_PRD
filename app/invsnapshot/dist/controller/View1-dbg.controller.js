sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("invsnapshot.controller.View1", {
        onInit: function () {
            
            const oTable = this.byId("table");

            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        _calculateTotals: function (oEvent) {
            var oTable = oEvent.getSource();
            var oBinding = oTable.getBinding("rows");  // Get the rows binding
            var aContexts = oBinding.getContexts(0, oBinding.getLength());
            // Ensure that the binding exists and is set up
            if (oBinding) { // Get the data rows
                var fTotalOnHand = 0;
                
                var aData = aContexts.map(oContext => oContext.getObject());
                
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    var oData = oContext.getObject();
                    fTotalOnHand += parseFloat(oContext.getProperty("ON_HAND")) || 0;
                });
                
                // Update footer with the calculated totals
                
                this.byId("footerText1").setText(fTotalOnHand);
                
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
        _removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        }
    });
});