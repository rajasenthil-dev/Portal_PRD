sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("customermaster.controller.View1", {
        onInit: function () {
            this._oSmartTable = this.byId("_IDGenSmartTable1");
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile");
            // Fetch data
             oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("customermaster").split("/resources")[0];
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