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
        _calculateTotals: function () {
            debugger
            const oSmartTable = this.getView().byId("table0");
            const oTable = oSmartTable.getTable();
            const oBinding = oTable.getBinding("rows");
        
            if (oBinding) {
                // Extract filter criteria applied to the table
                const aFilters = oBinding.aFilters || [];
        
                // Build filters JSON string to send to CAP
                const sFilters = JSON.stringify(aFilters.map((filter) => {
                    return {
                        path: filter.sPath,
                        operator: filter.sOperator,
                        value1: filter.oValue1,
                        value2: filter.oValue2
                    };
                }));
        
                // Call CAP service
                const sServiceUrl = "/odata/v2/processing/calculateTotals";

                // Prepare the request body
                const oData = {
                    entityName: "OPENORDERS", // Specify the entity
                    filters: JSON.stringify(aFilters) // Include dynamic filters
                };

                fetch(sServiceUrl, {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: JSON.stringify(oData)
                })
                    .then((response) => {
                        if (!response.ok) {
                            throw new Error("Failed to fetch totals");
                        }
                        return response.json();
                    })
                    .then((result) => {
                        // Update UI with the response
                        this.byId("_IDGenNumericContent1").setText(result.totalOpenLines);
                        this.byId("footerText1").setText(result.totalKWMENG);
                    })
                    .catch((error) => {
                        console.error("Error fetching totals:", error);
                    });

            }
        },
        // _calculateTotals: function (oEvent) {
        //     debugger
        //     var oSmartTable = this.getView().byId("table0");
        //     var oTable = oSmartTable.getTable();
        //     var oBinding = oTable.getBinding("rows"); // For GridTable

        //     var fTotalOpenLines = 0;
        //     fTotalOpenLines = oBinding.getCount();
            
        //     // Ensure that the binding exists and is set up
        //     if (oBinding) {
        //         var aContexts = oBinding.getContexts(0, oBinding.getLength());  // Get the data rows
        //         var fTotalKWMENG = 0;
        
        //         // Iterate through the rows to sum the values
        //         aContexts.forEach(function (oContext) {
        //             fTotalKWMENG += parseFloat(oContext.getProperty("KWMENG")) || 0;
        //         });
        //         // Update footer with the calculated totals
        //         this.byId("_IDGenNumericContent1").setText(fTotalOpenLines);
        //         this.byId("footerText1").setText(fTotalKWMENG);
        //     }
        // }
    });
});