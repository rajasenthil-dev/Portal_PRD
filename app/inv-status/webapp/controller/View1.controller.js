sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("invstatus.controller.View1", {
        onInit() {
            
            const oView = this.getView();
            const oSmartFilterBar = oView.byId("bar0");
        
            oView.setBusy(true);
        
            oSmartFilterBar.attachInitialized(function () {
                oView.setBusy(false); // Once filter bar + value helps are ready
            });
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invstatus").split("/resources")[0];
                    if(sAppPath === ".") {
                        sAppPath = "";
                    }
                    console.log("✅ Dynamic Base Path:", sAppPath);
                    
                    var sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                    var sSrcUrl = sAppPath + sCleanUrl;
                    // Example: Set the image source
                    this.getView().byId("logoImage").setSrc(sSrcUrl);
                } else {
                    console.log("No media found for this manufacturer.");
                }
            }.bind(this));
            var oModel = this.getOwnerComponent().getModel();
            const oSmartTable = this.getView().byId("table0");
            const oTable = oSmartTable.getTable();
            this.bAuthorizationErrorShown = false;
            oModel.attachRequestFailed(function (oEvent) {
                var oParams = oEvent.getParameters();
                if (oParams.response.statusCode === "403") {
                    oTable.setNoData("No data available due to authorization restrictions");
                    oTable.setBusy(false); 
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

            oTable.attachEvent("rowsUpdated",this.calculateTotals.bind(this));// For GridTable
            
        },
        
        calculateTotals: function () {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows"); // For GridTable
            var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts
            
            var fTotalOpenStock = 0;
            var fTotalQuarantine = 0;
            var fTotalRetains = 0;
            var fTotalQualityHold = 0;
            var fTotalReturns = 0;
            var fTotalRecalls = 0;
            var fTotalInventoryHold = 0;
            var fTotalReLabel = 0;
            var fTotalDamage= 0;
            var fTotalSample = 0;

            
            aContexts.forEach(function (oContext) {
                fTotalOpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
                fTotalQuarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
                fTotalRetains += parseFloat(oContext.getProperty("RETAINS")) || 0;
                fTotalQualityHold += parseFloat(oContext.getProperty("QUALITY_HOLD")) || 0;
                fTotalReturns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
                fTotalRecalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
                fTotalInventoryHold += parseFloat(oContext.getProperty("INVENTORY_HOLD")) || 0;
                fTotalReLabel += parseFloat(oContext.getProperty("RELABEL_QTY")) || 0;
                fTotalDamage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
                fTotalSample += parseFloat(oContext.getProperty("SAMPLE_QTY")) || 0;
                
                
            });
            var formattedOpenStock = this._formatNumber(fTotalOpenStock);
            var formattedQuarantine = this._formatNumber(fTotalQuarantine);
            var formattedRetains = this._formatNumber(fTotalRetains);
            var formattedQualityHold = this._formatNumber(fTotalQualityHold);
            var formattedReturns = this._formatNumber(fTotalReturns);
            var formattedRecalls = this._formatNumber(fTotalRecalls);
            var formattedInventoryHold = this._formatNumber(fTotalInventoryHold);
            var formattedReLabel = this._formatNumber(fTotalReLabel);
            var formattedDamage = this._formatNumber(fTotalDamage);
            var formattedSample = this._formatNumber(fTotalSample);
            // Update the model with calculated totals
            this.byId("footerText1").setText(formattedOpenStock);
            this.byId("footerText2").setText(formattedQuarantine);
            this.byId("footerText3").setText(formattedRetains);
            this.byId("footerText4").setText(formattedQualityHold);
            this.byId("footerText5").setText(formattedReturns);
            this.byId("footerText6").setText(formattedRecalls);
            this.byId("footerText7").setText(formattedInventoryHold);
            this.byId("footerText8").setText(formattedReLabel);
            this.byId("footerText9").setText(formattedDamage);
            this.byId("footerText10").setText(formattedSample);
        },
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);

        },
    });
});