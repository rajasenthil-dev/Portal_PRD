sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], (Controller, MessageBox) => {
    "use strict";

    return Controller.extend("pricelist.controller.View1", {
        onInit: async function () {

            // Fetch User Data and Logo
            const oView = this.getView();
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;

            const oLogoModel = this.getOwnerComponent().getModel("logo");

            const sAppPath = sap.ui.require.toUrl("invoicehis").split("/resources")[0] === "." 
                ? "" 
                : sap.ui.require.toUrl("invoicehis").split("/resources")[0];
            const sFallbackImage = sAppPath + "/images/MCKCAN1.jpg";

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
        }
    });
});