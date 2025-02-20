sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"

], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("returns.controller.View1", {
        onInit() {
            var oModel = this.getOwnerComponent().getModel();
            const oSmartTable = this.getView().byId("table0");
            const oTable = oSmartTable.getTable();
            this.bAuthorizationErrorShown = false;
            oModel.attachRequestFailed(function (oEvent) {
                var oParams = oEvent.getParameters();
                if (oParams.response.statusCode === "403") {
                    oTable.setNoData("No data available due to authorization restrictions");
                    oTable.setBusy(false)    
                    if(!this.bAuthorizationErrorShown) {
                        this.bAuthorizationErrorShown = true;
                        MessageBox.error("You do not have the required permissions to access this report.", {
                            title: "Unauthorized Access",
                            id: "messageBoxId1",
                            details: "Permission is required to access this report. Please contact your administrator if you believe this is an error or require access.",
                            contentWidth: "100px",
                        });
                    
                    }
                }
            });
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile");
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("returns").split("/resources")[0];
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
            
            // Attach event listener for rowsUpdated to recalculate totals when data changes
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        _calculateTotals: function (oEvent) {
            var oTable = oEvent.getSource();
            var oBinding = oTable.getBinding("rows");  // Get the rows binding
            var aContexts = oBinding.getContexts(0, oBinding.getLength());
            // Ensure that the binding exists and is set up
            if (oBinding) { // Get the data rows
                var fTotalNetWr = 0;
                let credited = new Set();   // Total for NETWR (Invoice Amount)
                var fTotalCredited = 0;  
                var fTotalOpenRGA = 0;  // Total for CAL_CASH_RECEIVED (Cash Received)
                var fTotalClosedRGA = 0;
                var aData = aContexts.map(oContext => oContext.getObject());
                fTotalClosedRGA = aData.filter(item => item.AUDAT).length
                fTotalOpenRGA = aData.filter(item => !item.AUDAT).length
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    var oData = oContext.getObject();
                    fTotalNetWr += parseFloat(oContext.getProperty("NETWR")) || 0;
                    credited.add(oData.VBELN);
                });
                var formattedNetWr = this._formatCurrency(fTotalNetWr);
                const creditedCount = credited.size;
                // Update footer with the calculated totals
                
                this.byId("TotUnitsPriceText").setText(formattedNetWr);
                this.byId("summaryTile1").setText(creditedCount);
                this.byId("summaryTile2").setText(fTotalOpenRGA);
                this.byId("summaryTile3").setText(fTotalClosedRGA);
                
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
        }
    });
});