sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("invstatus.controller.View1", {
        onInit: async function () {
            
            const oView = this.getView();
            const oSmartFilterBar = oView.byId("bar0");
        
            oView.setBusy(true);
        
            oSmartFilterBar.attachInitialized(function () {
                oView.setBusy(false); // Once filter bar + value helps are ready
            });
            // Fetch User Data and Logo
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;

            const oLogoModel = this.getOwnerComponent().getModel("logo");

            const sAppPath = sap.ui.require.toUrl("invoicehis").split("/resources")[0] === "." 
                ? "" 
                : sap.ui.require.toUrl("invoicehis").split("/resources")[0];
            const sFallbackImage = sAppPath + "./images/MCKCAN1.jpg";

            if (!mfgNumber) {
                console.warn("No ManufacturerNumber in user model. Showing fallback logo.");
                oView.byId("logoImage").setSrc(sFallbackImage);
                return;
            }

            //const paddedMfg = mfgNumber.padStart(9, "0");

            const oFilter = new sap.ui.model.Filter("manufacturerNumber", "EQ", mfgNumber);
            const oListBinding = oLogoModel.bindList("/MediaFile", undefined, undefined, [oFilter]);

            oListBinding.requestContexts().then(function (aContexts) {
                if (aContexts && aContexts.length > 0) {
                const oData = aContexts[0].getObject();
                const sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                const sSrcUrl = sAppPath + sCleanUrl;
                oView.byId("logoImage").setSrc(sSrcUrl);
                } else {
                console.warn("No matching logo found. Fallback image used.");
                oView.byId("logoImage").setSrc(sFallbackImage);
                }
            }.bind(this)).catch(function (err) {
                console.error("Binding error:", err);
                oView.byId("logoImage").setSrc(sFallbackImage);
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