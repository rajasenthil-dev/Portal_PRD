sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("invstatus.controller.View1", {
        onInit() {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();

            oTable.attachEvent("rowsUpdated",this.calculateTotals.bind(this));// For GridTable
        },
        calculateTotals: function () {
            debugger
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows"); // For GridTable
            var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts
            var oTotalCounts = {
                Order: 0,
                Receipt: 0,
                Adjustments: 0,
                Returns: 0,
                PhysicalCount: 0
            };
            var fTotalOpenStock = 0;
            var fTotalQuarantine = 0;
            var fTotalDamage= 0;
            var fTotalQualityHold = 0;
            var fTotalRetains = 0;
            var fTotalReturns = 0;
            var fTotalRecalls = 0;
            
            aContexts.forEach(function (oContext) {
                fTotalOpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
                fTotalQuarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
                fTotalDamage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
                //fTotalQualityHold += parseFloat(oContext.getProperty("MENGE")) || 0;
                fTotalRetains += parseFloat(oContext.getProperty("RETAINS")) || 0;
                fTotalReturns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
                fTotalRecalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
                
                
            });
            var formattedOpenStock = this._formatNumber(fTotalOpenStock);
            var formattedQuarantine = this._formatNumber(fTotalQuarantine);
            var formattedDamage = this._formatNumber(fTotalDamage);
            var formattedQualityHold = this._formatNumber(fTotalQualityHold);
            var formattedRetains = this._formatNumber(fTotalRetains);
            var formattedReturns = this._formatNumber(fTotalReturns);
            var formattedRecalls = this._formatNumber(fTotalRecalls);

            // Update the model with calculated totals
            this.byId("footerText1").setText(formattedOpenStock);
            this.byId("footerText2").setText(formattedQuarantine);
            this.byId("footerText3").setText(formattedDamage);
            this.byId("footerText4").setText(formattedRetains);
            this.byId("footerText5").setText(formattedQualityHold);
            this.byId("footerText6").setText(formattedReturns);
            this.byId("footerText7").setText(formattedRecalls);
        },
        _formatNumber : function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);

            oTileCounts.Order = formatNumber(oTileCounts.Order);
            oTileCounts.Receipt = formatNumber(oTileCounts.Receipt);
            oTileCounts.Adjustments = formatNumber(oTileCounts.Adjustments);
            oTileCounts.Returns = formatNumber(oTileCounts.Returns);
            oTileCounts.PhysicalCount = formatNumber(oTileCounts.PhysicalCount);

        },
    });
});