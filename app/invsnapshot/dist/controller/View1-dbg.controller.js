sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("invsnapshot.controller.View1", {
        onInit: function () {
            
            const oTable = this.byId("table");

            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
            oTable.attachEvent("rowsUpdated", this.onGetManufacturerMedia.bind(this));

        },
        onGetManufacturerMedia: function (sManufacturerNumber) {
            var oModel = this.getView().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModel.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invsnapshot").split("/resources")[0];
                    if(sAppPath === ".") {
                        sAppPath = "";
                    }
                    console.log("✅ Dynamic Base Path:", sAppPath);
    
                    var sSrcUrl = sAppPath + oData.url;
                    // Example: Set the image source
                    this.getView().byId("logoImage").setSrc(sSrcUrl);
                } else {
                    console.log("No media found for this manufacturer.");
                }
            }.bind(this));
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
        
        _formatCurrency: function (value) {
            if (value == null || value === undefined) {
            return "";
            }
        
            // Get the locale
            var sLocale = sap.ui.getCore().getConfiguration().getLocale().getLanguage();
            var sCurrencyCode;
        
            switch (sLocale) {
                case "en-US":
                    sCurrencyCode = "USD";
                    break;
                case "en-CA":
                    sCurrencyCode = "CAD";
                    break;
                case "fr-CA":
                    sCurrencyCode = "CAD";
                    break;
            // Add more cases as needed for other languages/regions
                default:
                    sCurrencyCode = "USD"; // Default currency code
                    break;
            }
        
            // Create a NumberFormat instance with currency type
            var oNumberFormat = sap.ui.core.format.NumberFormat.getCurrencyInstance({
            "currencyCode": false,
            "customCurrencies": {
                "MyDollar": {
                    "isoCode": sCurrencyCode,
                    "decimals": 2
                }
            },
            groupingEnabled: true,
            showMeasure: true
            });
            return oNumberFormat.format(value, "MyDollar");
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