sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("pricelist.controller.View1", {
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
                    var sAppPath = sap.ui.require.toUrl("pricelist").split("/resources")[0];
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
        }
    });
});