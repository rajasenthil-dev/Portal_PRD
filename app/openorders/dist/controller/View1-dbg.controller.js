sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("openorders.controller.View1", {
        onInit() {
            var oSmartTable = this.byId("table0"); // Get the SmartTable by ID
            var oTable = oSmartTable.getTable();   // Access the underlying table
            
            // Attach event listener for rowsUpdated to recalculate totals when data changes
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        _calculateTotals: function (oEvent) {
            var oTable = oEvent.getSource();
            var oBinding = oTable.getBinding("rows");  // Get the rows binding
            var aContexts = oBinding.getContexts(0, oBinding.getLength());

            // Ensure that the binding exists and is set up
            if (oBinding) {
                var fTotalOpenOrders = oBinding.getLength();
                var fTotalKWMENG = 0;
                var fTotalOpenLines = new Set();
        
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    var oData = oContext.getObject();
                    fTotalKWMENG += parseFloat(oContext.getProperty("KWMENG")) || 0;
                    fTotalOpenLines.add(oData.MAKTX);
                });
                const fTotalOpenLinesCount = fTotalOpenLines.size;
                // Update footer with the calculated totals
                this.byId("_IDGenNumericContent1").setText(fTotalOpenOrders);
                this.byId("_IDGenNumericContent2").setText(fTotalOpenLinesCount);
                this.byId("footerText1").setText(fTotalKWMENG);
            }
        }
    });
});