sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("customermaster.controller.View1", {
        onInit: function () {
            this._oSmartTable = this.byId("_IDGenSmartTable1");
        },
        onTableLayoutChange: function (oEvent) {
            var selectedItem = oEvent.getSource().aRBs[1].mProperties.text; // Get selected text
            
            var oTable = this._oSmartTable.getTable();
            
            if (selectedItem === "Responsive") {
                if (oTable instanceof sap.ui.table.Table) {
                oTable.setVisibleRowCountMode(sap.ui.table.VisibleRowCountMode.Auto);
                oTable.setFixedColumnCount(0);
                }
            } else if (selectedItem === "Scrollable") {
                if (oTable instanceof sap.ui.table.Table) {
                oTable.setVisibleRowCountMode(sap.ui.table.VisibleRowCountMode.Fixed);
                oTable.setFixedColumnCount(20); // Example for fixing columns
                }
            }
        },
        _formatRowHighlight: function (oValue) {
			// Your logic for rowHighlight goes here
			if (oValue === "I") {
				return "Error";
            }
			return "Success";
		},
        _formatStatusText: function (oValue) {
            switch (oValue) {
                case "A":
                    return "Active";
                case "I":
                    return "Inactive";
                default:
                    return "Unknown"
            }
        },
        _formatStatusIcon: function (oValue) {
            switch (oValue) {
                case "A":
                    return "sap-icon://sys-enter-2";
                case "I":
                    return "sap-icon://error";
                default:
                    return "sap-icon://alert"
            }
        },
        _formatStatusState: function (oValue) {
            switch (oValue) {
                case "A":
                    return "Success";
                case "I":
                    return "Error";
                default:
                    return "Warning"
            }
        }
    });
});