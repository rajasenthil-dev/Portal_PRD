sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel"
], (Controller, JSONModel) => {
    "use strict";

    return Controller.extend("pivottable.controller.View1", {
        onInit: async function () {
            // Fetch User Data and Logo
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;

            const oLogoModel = this.getOwnerComponent().getModel("logo");

            var sAppPath = sap.ui.require.toUrl("pivottable").split("/resources")[0];
            if(sAppPath === ".") {
                sAppPath = "";
            }
            const sFallbackImage = sAppPath + "/images/MCKCAN1.jpg";

            if (!mfgNumber) {
                console.warn("No ManufacturerNumber in user model. Showing fallback logo.");
                oView.byId("logoImage").setSrc(sFallbackImage);
                return;
            }

            //const paddedMfg = mfgNumber.padStart(9, "0");

            const oFilter = new sap.ui.model.Filter("manufacturerNumber", "EQ", mfgNumber);
            const oListBinding = oLogoModel.bindList("/MediaFile", undefined, undefined, [oFilter]);

            oListBinding.requestContexts().then(function (aContexts) {
                if (aContexts && aContexts.length > 0) {
                const oData = aContexts[0].getObject();
                const sCleanUrl = oData.url.replace(/^.*(?=\/odata\/v4\/media)/, "");
                const sSrcUrl = sAppPath + sCleanUrl;
                oView.byId("logoImage").setSrc(sSrcUrl);
                } else {
                console.warn("No matching logo found. Fallback image used.");
                oView.byId("logoImage").setSrc(sFallbackImage);
                }
            }.bind(this)).catch(function (err) {
                console.error("Binding error:", err);
                oView.byId("logoImage").setSrc(sFallbackImage);
            }.bind(this));
            // Define month keys for easier iteration
            const monthKeys = ["jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"];

            // Initial raw sales data (mock)
            // Provinces can have their own sales figures and also contain customer sales data.
            let rawSalesData = [
                {
                    name: "Ontario",
                    type: "Province", // To distinguish node types if needed later
                    jan: 1000, feb: 1100, mar: 1200, apr: 1050, may: 1150, jun: 1250,
                    jul: 1300, aug: 1350, sep: 1400, oct: 1450, nov: 1500, dec: 1600,
                    children: [
                        { name: "Customer Alpha (ON)", type: "Customer", jan: 500, feb: 600, mar: 700, apr: 550, may: 650, jun: 750, jul: 800, aug: 850, sep: 900, oct: 950, nov: 1000, dec: 1100 },
                        { name: "Customer Beta (ON)", type: "Customer", jan: 300, feb: 300, mar: 300, apr: 300, may: 300, jun: 300, jul: 300, aug: 300, sep: 300, oct: 300, nov: 300, dec: 300 },
                        { name: "Customer Gamma (ON)", type: "Customer", jan: 200, feb: 200, mar: 200, apr: 200, may: 200, jun: 200, jul: 200, aug: 200, sep: 200, oct: 200, nov: 200, dec: 200 }
                    ]
                },
                {
                    name: "Quebec",
                    type: "Province",
                    jan: 800, feb: 850, mar: 900, apr: 750, may: 820, jun: 880,
                    jul: 920, aug: 950, sep: 980, oct: 1000, nov: 1020, dec: 1050,
                    children: [
                        { name: "Customer Delta (QC)", type: "Customer", jan: 400, feb: 450, mar: 500, apr: 350, may: 420, jun: 480, jul: 520, aug: 550, sep: 580, oct: 600, nov: 620, dec: 650 },
                        { name: "Customer Epsilon (QC)", type: "Customer", jan: 400, feb: 400, mar: 400, apr: 400, may: 400, jun: 400, jul: 400, aug: 400, sep: 400, oct: 400, nov: 400, dec: 400 }
                    ]
                },
                {
                    name: "British Columbia", // Province with own sales but no customers in this mock data
                    type: "Province",
                    jan: 1200, feb: 1250, mar: 1300, apr: 1150, may: 1220, jun: 1280,
                    jul: 1320, aug: 1350, sep: 1380, oct: 1400, nov: 1420, dec: 1450,
                    children: []
                },
                 {
                    name: "Alberta", // Province with no direct sales, only customer sales
                    type: "Province",
                    jan: 0, feb: 0, mar: 0, apr: 0, may: 0, jun: 0,
                    jul: 0, aug: 0, sep: 0, oct: 0, nov: 0, dec: 0,
                    children: [
                         { name: "Customer Zeta (AB)", type: "Customer", jan: 700, feb: 710, mar: 720, apr: 730, may: 740, jun: 750, jul: 760, aug: 770, sep: 780, oct: 790, nov: 800, dec: 810 }
                    ]
                }
            ];

            // Initialize footer totals object
            let footerTotals = {
                jan: 0, feb: 0, mar: 0, apr: 0, may: 0, jun: 0,
                jul: 0, aug: 0, sep: 0, oct: 0, nov: 0, dec: 0,
                grandTotal: 0 // This will be the sum of the 'Total' column for all provinces
            };

            /**
             * Processes a node (Province or Customer) recursively to calculate its total
             * and update the overall footer totals.
             * For a Customer: node.total = sum of its own monthly values.
             * For a Province: node.total = sum of its own monthly values + sum of all its children's totals.
             * Footer monthly totals: sum of direct monthly contributions from all nodes.
             * @param {object} node The current node in the sales data hierarchy.
             * @returns {number} The calculated total for the current node (own sum + children's sum for provinces).
             */
            function processNodeAndCalculateTotals(node) {
                let ownMonthlySum = 0;

                // Calculate sum of own monthly values and update footer's monthly totals
                monthKeys.forEach(month => {
                    const monthValue = typeof node[month] === 'number' ? node[month] : 0;
                    node[month] = monthValue; // Ensure property exists and is a number
                    ownMonthlySum += monthValue;
                    footerTotals[month] += monthValue; // Add this node's direct contribution to footer
                });

                let childrenAggregatedTotal = 0;
                if (node.children && node.children.length > 0) {
                    node.children.forEach(child => {
                        // Recursively process child. The return value is child's total (own + its children, if any)
                        childrenAggregatedTotal += processNodeAndCalculateTotals(child);
                    });
                }

                // Set the 'total' property for the current node
                // For Provinces, this includes their own sales + aggregated sales of their children
                // For Customers, this is just their own sales (as childrenAggregatedTotal will be 0)
                node.total = ownMonthlySum + childrenAggregatedTotal;
                
                return node.total; // Return this node's calculated total
            }

            // Process each top-level province
            rawSalesData.forEach(province => {
                processNodeAndCalculateTotals(province);
            });
            
            // Calculate the grandTotal for the footer by summing the 'total' of all top-level provinces
            // (since their 'total' now includes their children's contributions)
            rawSalesData.forEach(province => {
                footerTotals.grandTotal += province.total;
            });

            // Create a JSON model with processed sales data and footer totals
            var oSalesModel = new JSONModel({
                salesData: rawSalesData,
                footerTotals: footerTotals
            });

            // Set the model to the view, making it available for binding
            this.getView().setModel(oSalesModel, "salesModel");

            // Optional: Expand the first level of the tree table automatically after data is loaded
            // this.byId("salesTreeTable").expandToLevel(1);
            // Or, if you want to ensure it happens after rows are updated:
            // var oTreeTable = this.byId("salesTreeTable");
            // oTreeTable.attachEventOnce("rowsUpdated", function() {
            //     oTreeTable.expandToLevel(1); // Expands first level (provinces)
            // });
        }
    });
});