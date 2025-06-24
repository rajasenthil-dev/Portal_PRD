sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter"
], function(Controller, Filter) {
    "use strict";

    return Controller.extend("shipstatus.ext.ListReportAfterHeader", {

        onInit: async function() {
            await this._refreshUserModel();
            this._fetchAndSetLogo();
        },

        _refreshUserModel: async function() {
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            let sAppPath = sap.ui.require.toUrl("shipstatus").split("/resources")[0];
            if (sAppPath === ".") sAppPath = "";

            const url = `${sAppPath}/user-api/attributes`;

            try {
                const oResponse = await fetch(url);
                const oUserData = await oResponse.json();
                oUserModel.setData(oUserData);
                console.log("User model refreshed:", oUserData);
            } catch (err) {
                console.error("Failed to fetch user info", err);
            }
        },

        _fetchAndSetLogo: function() {
            const oView = this.getView();
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;
            const oLogoImage = oView.byId("logoImage");

            let sAppPath = sap.ui.require.toUrl("shipstatus").split("/resources")[0];
            if (sAppPath === ".") sAppPath = "";

            const sFallbackImage = `${sAppPath}/images/MCKCAN1.jpg`;

            if (!mfgNumber) {
                console.warn("No ManufacturerNumber found; using fallback logo.");
                oLogoImage.setSrc(sFallbackImage);
                return;
            }

            const oLogoModel = this.getOwnerComponent().getModel("logo");
            const oFilter = new Filter("manufacturerNumber", "EQ", mfgNumber);
            const oListBinding = oLogoModel.bindList("/MediaFile", undefined, undefined, [oFilter]);

            oListBinding.requestContexts()
                .then((aContexts) => {
                    if (aContexts.length > 0) {
                        const oData = aContexts[0].getObject();
                        const sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                        const sSrcUrl = sAppPath + sCleanUrl;
                        oLogoImage.setSrc(sSrcUrl);
                    } else {
                        console.warn("No logo found; using fallback.");
                        oLogoImage.setSrc(sFallbackImage);
                    }
                })
                .catch((err) => {
                    console.error("Error fetching logo:", err);
                    oLogoImage.setSrc(sFallbackImage);
                });
        }

    });
});
