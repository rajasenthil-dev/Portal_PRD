sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("invbylot.controller.View1", {
        onInit: function () {
            var oTileCountsModel = new JSONModel({
                counts: {
                    OpenStock: 0,
                    Quarantine: 0,
                    Damage: 0,
                    Retains: 0,
                    QualityHold: 0,
                    Returns: 0,
                    Recalls: 0
                }
            });
            
            this.getView().setModel(oTileCountsModel, "summaryCounts"); //GridTable
            // Get the SmartTable and bind the data change event
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows");
            
            oTable.attachEvent("rowsUpdated",this._calculateTotals.bind(this));// For GridTable
        },
        removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        },
        // Added by Bryan Cash calculate totals for table. This code will need to be updated when backend is finished to refelct correct data
        _calculateTotals: function (oModel) {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows"); // For GridTable
            var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts
            var oTileCounts = {
                OpenStock: 0,
                Quarantine: 0,
                Damage: 0,
                Retains: 0,
                QualityHold: 0,
                Returns: 0,
                Recalls: 0
            };
            var fTotalQuantityOnHand = 0;
            var fTotalDaysUntilExpiry = 0;
            
            aContexts.forEach(function (oContext) {
                // oTileCounts.OpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
                // oTileCounts.Quarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
                // oTileCounts.Damage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
                // oTileCounts.Retains += parseFloat(oContext.getProperty("RETAINS")) || 0;
                // oTileCounts.QualityHold += parseFloat(oContext.getProperty("QUALITY_HOLD")) || 0;
                // oTileCounts.Returns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
                // oTileCounts.Recalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
                fTotalDaysUntilExpiry += parseFloat(oContext.getProperty("DAYS_UNTIL_EXPIRY")) || 0;
                fTotalQuantityOnHand += parseFloat(oContext.getProperty("QTY_ON_HAND")) || 0;
            });
            var formattedQuantityOnHand = this._formatNumber(fTotalQuantityOnHand);
            var formattedDaysUntilExpiry = this._formatNumber(fTotalDaysUntilExpiry);

            // Update the model with calculated totals
            this.getView().getModel("summaryCounts").setProperty("/counts", oTileCounts);
            this.byId("footerText1").setText(formattedQuantityOnHand);
            this.byId("footerText2").setText(formattedDaysUntilExpiry);

        },
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);
        },
        _formatRowHighlight: function (oValue) {
			// Your logic for rowHighlight goes here
			if (oValue >= 120) {
                return "Success";
            } else if (oValue > 0) {
                return "Warning";
            } else if (oValue = 0) {
                return "Error"
            } else {
                return "Error"
            }
		},
    });
});