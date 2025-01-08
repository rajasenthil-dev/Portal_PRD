sap.ui.define([
  "sap/ui/core/mvc/Controller",
  "bckorders/model/formatter"
], (Controller, formatter) => {
  "use strict";

  return Controller.extend("bckorders.controller.View1", {
      formatter: formatter,

      onInit: function () {
          const oSmartTable = this.getView().byId("table0");
          const oTable = oSmartTable.getTable();
          oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
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
          this._updateTile("TileContent1", totals.totalBackOrders);
          this._updateTile("TileContent2", impactedCustomersCount);
          this._updateTile("TileContent3", totalItemsOnBackOrderCount);
          this._updateTile("TileContent4", totals.totalUnitsBackOrdered);
          this._updateTile("TileContent5", totals.totalUnitsToBeReceived);

          // Update footer elements
          this._updateFooter("footerText1", totalQtyFormatted);
          this._updateFooter("footerText2", totalExtensionFormatted);
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
