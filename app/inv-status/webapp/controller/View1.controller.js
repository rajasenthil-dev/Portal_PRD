sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("invstatus.controller.View1", {
        onInit() {
            

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
                    
                    var sSrcUrl = sAppPath + oData.url;

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
            var fTotalDamage= 0;
            var fTotalQualityHold = 0;
            var fTotalRetains = 0;
            var fTotalReturns = 0;
            var fTotalRecalls = 0;
            
            aContexts.forEach(function (oContext) {
                fTotalOpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
                fTotalQuarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
                fTotalDamage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
                //fTotalQualityHold += parseFloat(oContext.getProperty("MENGE")) || 0;
                fTotalRetains += parseFloat(oContext.getProperty("RETAINS")) || 0;
                fTotalReturns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
                fTotalRecalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
                
                
            });
            var formattedOpenStock = this._formatNumber(fTotalOpenStock);
            var formattedQuarantine = this._formatNumber(fTotalQuarantine);
            var formattedDamage = this._formatNumber(fTotalDamage);
            var formattedRetains = this._formatNumber(fTotalRetains);
            var formattedReturns = this._formatNumber(fTotalReturns);
            var formattedRecalls = this._formatNumber(fTotalRecalls);

            // Update the model with calculated totals
            this.byId("footerText1").setText(formattedOpenStock);
            this.byId("footerText2").setText(formattedQuarantine);
            this.byId("footerText3").setText(formattedDamage);
            this.byId("footerText4").setText(formattedRetains);
            this.byId("footerText6").setText(formattedReturns);
            this.byId("footerText7").setText(formattedRecalls);
        },
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);

        },
    });
});