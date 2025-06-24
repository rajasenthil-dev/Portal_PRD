sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox",
    "sap/ui/model/Filter"
], (Controller, MessageBox, Filter) => {
    "use strict";

    return Controller.extend("invstatus.controller.View1", {
        
        onInit() {
            this._attachRouterPatternMatched();
            this._initSmartFilterBar();
            this._initModelErrorHandling();
            this._attachTableEvents();
        },

        _attachRouterPatternMatched() {
            const oRouter = this.getOwnerComponent().getRouter();
            oRouter.getRoute("RouteView1").attachPatternMatched(this._onPatternMatched, this);
        },

        _initSmartFilterBar() {
            const oView = this.getView();
            const oSmartFilterBar = oView.byId("bar0");

            oView.setBusy(true);

            oSmartFilterBar.attachInitialized(() => {
                oView.setBusy(false);
            });
        },

        _initModelErrorHandling() {
            const oModel = this.getOwnerComponent().getModel();
            const oTable = this.getView().byId("table0").getTable();
            this.bAuthorizationErrorShown = false;

            oModel.attachRequestFailed((oEvent) => {
                const { statusCode } = oEvent.getParameters().response;

                if (statusCode === "403") {
                    oTable.setNoData("No data available due to authorization restrictions");
                    oTable.setBusy(false);

                    if (!this.bAuthorizationErrorShown) {
                        this.bAuthorizationErrorShown = true;
                        MessageBox.error("You do not have the required permissions to access this report.", {
                            title: "Unauthorized Access",
                            id: "messageBoxId1",
                            details: "Permission is required to access this report. Please contact your administrator if you believe this is an error or require access.",
                            contentWidth: "100px"
                        });
                    }
                }
            });
        },

        _attachTableEvents() {
            const oTable = this.getView().byId("table0").getTable();
            oTable.attachEvent("rowsUpdated", this.calculateTotals.bind(this));
        },

        async _refreshUserModel() {
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            let sAppPath = sap.ui.require.toUrl("invstatus").split("/resources")[0];
            sAppPath = (sAppPath === ".") ? "" : sAppPath;

            const url = `${sAppPath}/user-api/attributes`;

            try {
                const oResponse = await fetch(url);
                const oUserData = await oResponse.json();

                oUserModel.setData(oUserData);
                console.log("✅ User model refreshed:", oUserData);
            } catch (err) {
                console.error("❌ Failed to fetch user info", err);
            }
        },

        _fetchAndSetLogo() {
            const oView = this.getView();
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel?.getData() || {};
            const mfgNumber = userData.ManufacturerNumber;
            const oLogoImage = oView.byId("logoImage");

            let sAppPath = sap.ui.require.toUrl("invstatus").split("/resources")[0];
            sAppPath = (sAppPath === ".") ? "" : sAppPath;

            const sFallbackImage = `${sAppPath}/images/MCKCAN1.jpg`;

            if (!mfgNumber) {
                console.warn("No ManufacturerNumber in user model. Showing fallback logo.");
                oLogoImage.setSrc(sFallbackImage);
                return;
            }

            const oLogoModel = this.getOwnerComponent().getModel("logo");
            const oFilter = new Filter("manufacturerNumber", "EQ", mfgNumber);
            const oListBinding = oLogoModel.bindList("/MediaFile", undefined, undefined, [oFilter]);

            oListBinding.requestContexts()
                .then((aContexts) => {
                    if (aContexts?.length > 0) {
                        const oData = aContexts[0].getObject();
                        const sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                        const sSrcUrl = `${sAppPath}${sCleanUrl}`;
                        oLogoImage.setSrc(sSrcUrl);
                    } else {
                        console.warn("No matching logo found. Fallback image used.");
                        oLogoImage.setSrc(sFallbackImage);
                    }
                })
                .catch((err) => {
                    console.error("Binding error:", err);
                    oLogoImage.setSrc(sFallbackImage);
                });
        },

        async _onPatternMatched() {
            await this._refreshUserModel();
            console.log("RouteView1 pattern matched – fetching logo...");
            this._fetchAndSetLogo();
        },

        calculateTotals() {
            const oTable = this.getView().byId("table0").getTable();
            const oBinding = oTable.getBinding("rows");
            const aContexts = oBinding.getContexts(0, oBinding.getLength());

            const fields = [
                { prop: "OPEN_STOCK", footerId: "footerText1" },
                { prop: "QUARANTINE", footerId: "footerText2" },
                { prop: "RETAINS", footerId: "footerText3" },
                { prop: "QUALITY_HOLD", footerId: "footerText4" },
                { prop: "RETURNS_CAL", footerId: "footerText5" },
                { prop: "RECALLS", footerId: "footerText6" },
                { prop: "INVENTORY_HOLD", footerId: "footerText7" },
                { prop: "RELABEL_QTY", footerId: "footerText8" },
                { prop: "DAMAGE_DESTRUCTION", footerId: "footerText9" },
                { prop: "SAMPLE_QTY", footerId: "footerText10" }
            ];

            const totals = fields.map(field => {
                return aContexts.reduce((sum, oContext) => {
                    return sum + (parseFloat(oContext.getProperty(field.prop)) || 0);
                }, 0);
            });

            fields.forEach((field, index) => {
                const formattedValue = this._formatNumber(totals[index]);
                this.byId(field.footerId).setText(formattedValue);
            });
        },

        _formatNumber(value) {
            return new Intl.NumberFormat("en-US", {
                maximumFractionDigits: 0
            }).format(value);
        }

    });
});
