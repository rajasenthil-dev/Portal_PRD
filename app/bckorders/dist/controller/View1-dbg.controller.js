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

                var sSrcUrl = sAppPath + oData.url;
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
              return;
          }

          const aContexts = oBinding.getContexts(0, oBinding.getLength());
          if (!aContexts) {
              console.warn("Data is not available for calculation.");
              return;
          }

          // Use reduce for consolidated calculations
          const totals = aContexts.reduce((acc, oContext) => {
              const oData = oContext.getObject();
              if (!oData) return acc;

              acc.totalBackOrders++;
              acc.impactedCustomers.add(oData.KUNRE_ANA);
              acc.totalItemsOnBackOrder.add(oData.MATNR);
              acc.totalUnitsBackOrdered += parseFloat(oData.BACK_ORD_QTY || 0);
              acc.totalExtension += parseFloat(oData.EXTENSION || 0);

              // Logic for units to be received (if applicable)
              if (oData.DATE_DIFF > 0 && !oData.UDATE) {
                  acc.totalUnitsToBeReceived += parseFloat(oData.BACK_ORD_QTY || 0);
              }

              return acc;
          }, {
              totalBackOrders: 0,
              impactedCustomers: new Set(),
              totalItemsOnBackOrder: new Set(),
              totalUnitsBackOrdered: 0,
              totalUnitsToBeReceived: 0,
              totalExtension: 0
          });

          // Calculate unique counts
          const impactedCustomersCount = totals.impactedCustomers.size;
          const totalItemsOnBackOrderCount = totals.totalItemsOnBackOrder.size;

          // Format values
          const totalExtensionFormatted = this.formatter.formatCurrency(totals.totalExtension, "USD");
          const totalQtyFormatted = this.formatter.formatNumber(totals.totalUnitsBackOrdered);

          // Update UI elements (tiles)
          this._updateTile("TileContent1", this.formatNumberWithCommas(totals.totalBackOrders));
          this._updateTile("TileContent2", this.formatNumberWithCommas(impactedCustomersCount));
          this._updateTile("TileContent3", this.formatNumberWithCommas(totalItemsOnBackOrderCount));
          this._updateTile("TileContent4", this.formatNumberWithCommas(totals.totalUnitsBackOrdered));
          this._updateTile("TileContent5", this.formatNumberWithCommas(totals.totalUnitsToBeReceived));

          // Update footer elements
          this._updateFooter("footerText1", totalQtyFormatted);
          this._updateFooter("footerText2", totalExtensionFormatted);
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
