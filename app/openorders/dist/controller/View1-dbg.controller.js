sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("openorders.controller.View1", {
        onInit() {
            var oModel = this.getOwnerComponent().getModel();
            const oView = this.getView();
            const oSmartFilterBar = oView.byId("bar0");
        
            oView.setBusy(true);
        
            oSmartFilterBar.attachInitialized(function () {
                oView.setBusy(false); // Once filter bar + value helps are ready
            });
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
                    var sAppPath = sap.ui.require.toUrl("openorders").split("/resources")[0];
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
            if (oBinding) {
                var fTotalOpenOrders = oBinding.getLength();
                var fTotalKWMENG = 0;
                var fTotalOpenLines = new Set();
        
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    var oData = oContext.getObject();
                    fTotalKWMENG += parseFloat(oContext.getProperty("KWMENG")) || 0;
                    fTotalOpenLines.add(oData.MAKTX);
                });
                const fTotalOpenLinesCount = fTotalOpenLines.size;
                // Update footer with the calculated totals
                this.byId("_IDGenNumericContent1").setText(fTotalOpenOrders);
                this.byId("_IDGenNumericContent2").setText(fTotalOpenLinesCount);
                this.byId("footerText1").setText(fTotalKWMENG);
            }
        }
    });
});