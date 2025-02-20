sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageBox"
], (Controller, JSONModel, MessageBox) => {
    "use strict";

    return Controller.extend("invbylot.controller.View1", {
        onInit: function () {
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
            var oTileCountsModel = new JSONModel({
                counts: {
                    OpenStock: 0,
                    Quarantine: 0,
                    Damage: 0,
                    Retains: 0,
                    QualityHold: 0,
                    Returns: 0,
                    Recalls: 0
                }
            });
            
            this.getView().setModel(oTileCountsModel, "summaryCounts"); //GridTable
            // Get the SmartTable and bind the data change event
            
            var oBinding = oTable.getBinding("rows");
            
            oTable.attachEvent("rowsUpdated",this._calculateTotals.bind(this));// For GridTable

            var oModelLogo = this.getOwnerComponent().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invbylot").split("/resources")[0];
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
        removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        },
       
        // Added by Bryan Cash calculate totals for table. This code will need to be updated when backend is finished to refelct correct data
        _calculateTotals: function (oModel) {
            
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows"); // For GridTable
            var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts
            var oTileCounts = {
                OpenStock: 0,
                Quarantine: 0,
                Damage: 0,
                Retains: 0,
                QualityHold: 0,
                Returns: 0,
                Recalls: 0
            };
            var fTotalQuantityOnHand = 0;
            var fTotalDaysUntilExpiry = 0;
            
            aContexts.forEach(function (oContext) {
                // oTileCounts.OpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
                // oTileCounts.Quarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
                // oTileCounts.Damage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
                // oTileCounts.Retains += parseFloat(oContext.getProperty("RETAINS")) || 0;
                // oTileCounts.QualityHold += parseFloat(oContext.getProperty("QUALITY_HOLD")) || 0;
                // oTileCounts.Returns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
                // oTileCounts.Recalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
                fTotalDaysUntilExpiry += parseFloat(oContext.getProperty("DAYS_UNTIL_EXPIRY")) || 0;
                fTotalQuantityOnHand += parseFloat(oContext.getProperty("QTY_ON_HAND")) || 0;
            });
            var formattedQuantityOnHand = this._formatNumber(fTotalQuantityOnHand);
            var formattedDaysUntilExpiry = this._formatNumber(fTotalDaysUntilExpiry);

            // Update the model with calculated totals
            this.getView().getModel("summaryCounts").setProperty("/counts", oTileCounts);
            this.byId("footerText1").setText(formattedQuantityOnHand);
            this.byId("footerText2").setText(formattedDaysUntilExpiry);

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
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);
        },
        _formatRowHighlight: function (oValue) {
			// Your logic for rowHighlight goes here
			if (oValue >= 120) {
                return "Success";
            } else if (oValue > 0) {
                return "Warning";
            } else if (oValue = 0) {
                return "Error"
            } else {
                return "Error"
            }
		},
    });
});