sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/m/MessageToast"
], function (Controller, Filter, FilterOperator, MessageToast) {
    "use strict";

    return Controller.extend("pivottable.controller.View1", {

        onInit: function () {
            const oRouter = this.getOwnerComponent().getRouter();
            oRouter.getRoute("RouteView1").attachPatternMatched(this._onPatternMatched, this);
           
            this._oSmartTable = this.byId("table0");
            const oSmartTable = this.getView().byId("table0");
            const oTable = oSmartTable.getTable();
            // Listen when SmartTable finishes its initial binding
            this._oSmartTable.attachInitialise(this._onSmartTableInit, this);

            // Attach rebind handler to inject tab filters before binding
            this._oSmartTable.attachBeforeRebindTable(this._onBeforeRebindTable, this);

            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        _refreshUserModel: async function () {
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            var sAppPath = sap.ui.require.toUrl("salesbycus").split("/resources")[0];
            if(sAppPath === ".") {
                sAppPath = "";
            }
            const url = sAppPath + "/user-api/attributes"
            try {
                const oResponse = await fetch(url); // or /me or /currentUser
                const oUserData = await oResponse.json();
        
                oUserModel.setData(oUserData);
                console.log("✅ User model refreshed:", oUserData);
            } catch (err) {
                console.error("❌ Failed to fetch user info", err);
            }
        },     
        _fetchAndSetLogo: function () {
            const oView = this.getView();
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;
            const oLogoImage = oView.byId("logoImage");
        
            var sAppPath = sap.ui.require.toUrl("salesbycus").split("/resources")[0];
            if (sAppPath === ".") {
                sAppPath = "";
            }
            
            const sFallbackImage = sAppPath + "/images/MCKCAN1.jpg";
        
            if (!mfgNumber) {
                console.warn("No ManufacturerNumber in user model. Showing fallback logo.");
                oLogoImage.setSrc(sFallbackImage);
                return;
            }
        
            const oLogoModel = this.getOwnerComponent().getModel("logo");
            const oFilter = new sap.ui.model.Filter("manufacturerNumber", "EQ", mfgNumber);
            const oListBinding = oLogoModel.bindList("/MediaFile", undefined, undefined, [oFilter]);
        
            oListBinding.requestContexts().then(function (aContexts) {
                if (aContexts && aContexts.length > 0) {
                    const oData = aContexts[0].getObject();
                    const sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                    const sSrcUrl = sAppPath + sCleanUrl;
                    oLogoImage.setSrc(sSrcUrl);
                } else {
                    console.warn("No matching logo found. Fallback image used.");
                    oLogoImage.setSrc(sFallbackImage);
                }
            }.bind(this)).catch(function (err) {
                console.error("Binding error:", err);
                oLogoImage.setSrc(sFallbackImage);
            }.bind(this));
        }, 
        _onPatternMatched: async function () {
            await this._refreshUserModel(); 
            // This function runs every time the route matching this view is hit.
            // Call the logo fetching logic here to ensure it's always up-to-date.
            console.log("RouteView1 pattern matched – fetching logo...");
            this._fetchAndSetLogo();
        },

        _onSmartTableInit: function () {
            this._oTable = this._oSmartTable.getTable();
        },

        onFilterSelect: function (oEvent) {
            this._sSelectedKey = oEvent.getParameter("key"); // Save key for later
            this._oSmartTable.rebindTable(); // Trigger rebind
        },

        _onBeforeRebindTable: function (oEvent) {
            const mParams = oEvent.getParameter("bindingParams");
            const aFilters = [];

            switch (this._sSelectedKey) {
                case "Ladega":
                aFilters.push(new sap.ui.model.Filter("MAKTX", sap.ui.model.FilterOperator.Contains, "LEDAGA"));
                break;
                case "SIGNIFOR":
                aFilters.push(new sap.ui.model.Filter("MAKTX", sap.ui.model.FilterOperator.Contains, "SIGNIFOR"));
                break;
                case "Cystadrops":
                aFilters.push(new sap.ui.model.Filter("MAKTX", sap.ui.model.FilterOperator.Contains, "CYSTADROP"));
                break;
                default:
                // All products, no filters
                break;
            }

            // Inject filters before SmartTable binds
            mParams.filters.push.apply(mParams.filters, aFilters);
        },

        formatOrDash: function (date) { 
            if (date === '00000000' || !date) { return '--' } else { return date ? date : '--'; } 
        },
        _calculateTotals: function () {
            const oSmartTable = this.getView().byId("table0");
            const oTable = oSmartTable.getTable();
            const oBinding = oTable.getBinding("rows");
        
            if (!oBinding) {
                console.warn("Table binding is missing.");
                this._updateTile("FooterText1", "0");
                return;
            }
        
            const aContexts = oBinding.getContexts(0, oBinding.getLength());
            // Check if contexts array is available and not empty
            if (!aContexts || aContexts.length === 0) {
                console.warn("Data is not available for calculation.");
                
                this._updateTile("FooterText1", "0");
                return;
            }
        
            // Initialize totals and sets
            const totals = aContexts.reduce((acc, oContext) => {
                const oData = oContext.getObject();
                if (!oData) return acc;
    
        
                // Units Calculation (Units per case * Quantity - Applied to all rows)
                // const unitsPerCase = parseFloat(oData.UNITS_PER_CASE || 0);
                const quantity = parseFloat(oData.QUANTITY_FKIMG || 0);
                acc.unitsTotal += quantity;
        
                // Footer Quantity Calculation (Sum QUANTITY_FKIMG - Applied to all rows)
                acc.quantityTotal += quantity;
        
                return acc;
            }, {
                quantityTotal: 0
            });
        
        
            // Format values
            // Ensure formatter, formatLargeNumber, formatNumberWithCommas, and formatCurrency are available
            // Added basic checks for formatter and functions
            
            const quantityTotalFormatted = this.formatLargeNumber ? this.formatLargeNumber(totals.quantityTotal) : totals.quantityTotal;
        
            // Update Footer
            this._updateTile("FooterText1", quantityTotalFormatted); // Quantity (Assuming FooterText1 is updated by _updateTile)
            
        },
        // Assuming these helper functions exist in your controller or a formatter file
        // Example placeholder for _updateTile
        _updateTile: function(sTileId, sText) {
            const oTile = this.getView().byId(sTileId);
            if (oTile) {
                // Assuming the tile has a setText method or a content with setText
                if (oTile.setText) {
                    oTile.setText(sText);
                } else if (oTile.getContent && oTile.getContent() && oTile.getContent().setText) {
                    oTile.getContent().setText(sText);
                } else {
                    console.warn("Tile or its content does not have a setText method:", sTileId);
                }
            } else {
                console.warn("Tile not found:", sTileId);
            }
        },
    });
});