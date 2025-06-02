sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "bckorders/model/formatter",
  "sap/m/MessageBox"
], (Controller, formatter, MessageBox) => {
  "use strict";

  var sResponsivePaddingClasses = "sapUiResponsivePadding--header sapUiResponsivePadding--content sapUiResponsivePadding--footer";

  return Controller.extend("bckorders.controller.View1", {
    formatter: formatter,

    onInit: function () {
        var oModel = this.getOwnerComponent().getModel();
        const oView = this.getView();
        const oSmartFilterBar = oView.byId("smartFilterBar");
    
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
        
        oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));

        var oModelLogo = this.getOwnerComponent().getModel("logo");
            // Bind to the MediaFile entity with a filter
        var oBinding = oModelLogo.bindList("/MediaFile");
        // Fetch data
        oBinding.requestContexts().then(function (aContexts) {
            if (aContexts.length > 0) {
                var oData = aContexts[0].getObject();
                console.log("Manufacturer:", oData.MFGName);
                console.log("File URL:", oData.url);
                var sAppPath = sap.ui.require.toUrl("bckorders").split("/resources")[0];
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
    },
    _calculateTotals: function () {
        const oSmartTable = this.getView().byId("table0");
        const oTable = oSmartTable.getTable();
        const oBinding = oTable.getBinding("rows");
    
        if (!oBinding) {
            console.warn("Table binding is missing.");
            // Optionally clear tiles/footers if no binding
            this._updateTile("TileContent1", "0");
            this._updateTile("TileContent2", "0");
            this._updateTile("TileContent3", "0");
            this._updateTile("TileContent4", "0");
            this._updateTile("TileContent5", "0");
            this._updateFooter("footerText1", "0");
            this._updateFooter("footerText2", "0");
            return;
        }
    
        const aContexts = oBinding.getContexts(0, oBinding.getLength());
        if (!aContexts || aContexts.length === 0) { // Also check if contexts array is empty
            console.warn("Data is not available for calculation.");
            // Clear tiles/footers if no data
            this._updateTile("TileContent1", "0");
            this._updateTile("TileContent2", "0");
            this._updateTile("TileContent3", "0");
            this._updateTile("TileContent4", "0");
            this._updateTile("TileContent5", "0");
            this._updateFooter("footerText1", "0");
            this._updateFooter("footerText2", "0");
            return;
        }
    
        // Use reduce for consolidated calculations
        const totals = aContexts.reduce((acc, oContext) => {
            const oData = oContext.getObject();
            if (!oData) return acc;
    
            // Add VBELN to the Set for unique back order count
            if (oData.VBELN) {
                acc.uniqueBackOrders.add(oData.VBELN);
            }
    
            // Add KUNRE_ANA to the Set for unique impacted customers
            if (oData.KUNRE_ANA) {
                 acc.impactedCustomers.add(oData.KUNRE_ANA);
            }
    
            // Add MATNR to the Set for unique items on back order
            if (oData.MATNR) {
                 acc.totalItemsOnBackOrder.add(oData.MATNR);
            }
    
    
            // Sum total units back ordered
            acc.totalUnitsBackOrdered += parseFloat(oData.BACK_ORD_QTY || 0);
    
            // Sum total extension
            acc.totalExtension += parseFloat(oData.EXTENSION || 0);
    
            // Logic for units to be received (if applicable)
            if (oData.DATE_DIFF > 0 && !oData.UDATE) {
                acc.totalUnitsToBeReceived += parseFloat(oData.BACK_ORD_QTY || 0);
            }
    
            return acc;
        }, {
            uniqueBackOrders: new Set(), // Use a Set for unique VBELN
            impactedCustomers: new Set(),
            totalItemsOnBackOrder: new Set(),
            totalUnitsBackOrdered: 0,
            totalUnitsToBeReceived: 0,
            totalExtension: 0
        });
    
        // Calculate unique counts from the Sets
        const uniqueBackOrdersCount = totals.uniqueBackOrders.size; // Get the size of the Set
        const impactedCustomersCount = totals.impactedCustomers.size;
        const totalItemsOnBackOrderCount = totals.totalItemsOnBackOrder.size;
    
        // Format values
        // Ensure formatter and formatNumberWithCommas are available in your controller
        const totalExtensionFormatted = this.formatter ? (this.formatter.formatCurrency ? this.formatter.formatCurrency(totals.totalExtension, "USD") : totals.totalExtension) : totals.totalExtension; // Basic check for formatter
        const totalQtyFormatted = this.formatter ? (this.formatter.formatNumber ? this.formatter.formatNumber(totals.totalUnitsBackOrdered) : totals.totalUnitsBackOrdered) : totals.totalUnitsBackOrdered; // Basic check for formatter
    
        // Update UI elements (tiles)
        // Update TileContent1 with the unique back order count
        this._updateTile("TileContent1", this.formatNumberWithCommas ? this.formatNumberWithCommas(uniqueBackOrdersCount) : uniqueBackOrdersCount); // Use unique count
        this._updateTile("TileContent2", this.formatNumberWithCommas ? this.formatNumberWithCommas(impactedCustomersCount) : impactedCustomersCount);
        this._updateTile("TileContent3", this.formatNumberWithCommas ? this.formatNumberWithCommas(totalItemsOnBackOrderCount) : totalItemsOnBackOrderCount);
        this._updateTile("TileContent4", this.formatNumberWithCommas ? this.formatNumberWithCommas(totals.totalUnitsBackOrdered) : totals.totalUnitsBackOrdered);
        this._updateTile("TileContent5", this.formatNumberWithCommas ? this.formatNumberWithCommas(totals.totalUnitsToBeReceived) : totals.totalUnitsToBeReceived);
    
        // Update footer elements
        this._updateFooter("footerText1", totalQtyFormatted);
        this._updateFooter("footerText2", totalExtensionFormatted);
    },
    
    // Assuming these helper functions exist in your controller or a formatter file
    // Example placeholder for _updateTile
    _updateTile: function(sTileId, sText) {
        const oTile = this.getView().byId(sTileId);
        if (oTile && oTile.getContent()) {
            // Assuming the tile content has a setText method, adjust if needed
            if (oTile.getContent().setText) {
                oTile.getContent().setText(sText);
            } else if (oTile.setText) { // Some tiles might have setText directly
                oTile.setText(sText);
            }
        } else {
            console.warn("Tile or Tile Content not found:", sTileId);
        }
    },
    
        // Example placeholder for _updateFooter
        _updateFooter: function(sFooterId, sText) {
            const oFooterElement = this.getView().byId(sFooterId);
            if (oFooterElement && oFooterElement.setText) {
                oFooterElement.setText(sText);
            } else {
                console.warn("Footer element not found:", sFooterId);
            }
        },
    
        // Example placeholder for formatNumberWithCommas (if not using a dedicated formatter)
        formatNumberWithCommas: function(number) {
            if (number === null || number === undefined) {
                return "";
            }
            return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },
        formatNumberWithCommas: function(value) {
            if (!value || isNaN(value)) return "0";
        
            return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        },

    _updateTile: function (sTileId, value) {
        const oTile = this.byId(sTileId);
        if (oTile) {
            oTile.setText(value);
        } else {
            console.warn(`Tile with ID ${sTileId} not found.`);
        }
    },

    _updateFooter: function (sFooterId, value) {
        const oFooter = this.byId(sFooterId);
        if (oFooter) {
            oFooter.setText(value);
        } else {
            console.warn(`Footer with ID ${sFooterId} not found.`);
        }
    }
  });
});
