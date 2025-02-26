sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/format/NumberFormat",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/Image",
    "sap/m/MessageBox"
], (Controller, JSONModel, NumberFormat, Dialog, Button, Image, MessageBox) => {
    "use strict";

    return Controller.extend("invoicehis.controller.View1", {
        onInit: function () {
            var oModel = this.getOwnerComponent().getModel();
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
            var oTileCountsModel = new JSONModel({
                counts: {
                    "UniqueInvoices": 0,
                    "TotalSales": 0,
                    "TotalSalesFormatted": 0
                }
            });
            var oFooterCountsModel = new JSONModel({
                counts: {
                    "TSL_AMOUNT": 0,
                    "CAL_PST": 0,
                    "CAL_GST": 0
                    
                }
            });

            this.getView().setModel(oTileCountsModel, "summaryCounts"); // GridTable
            this.getView().setModel(oFooterCountsModel, "footerCounts");

            
            this.getView().byId("table").attachEvent("rowsUpdated", this.onTableScroll.bind(this));

            var oModelLogo = this.getOwnerComponent().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invoicehis").split("/resources")[0];
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
        // handleHistoricalChange: function (oEvent) {
        //     // Get the selected key from the ComboBox
        //     var sSelectedKey = oEvent.getSource().getSelectedKey();
        
        //     // Perform actions based on the selected key
        //     switch (sSelectedKey) {
        //         case "Y":
        //             // Handle the "Current" selection
        //             this._filterData("Y");
        //             break;
        //         case "N":
        //             // Handle the "Historical" selection
        //             this._filterData("N");
        //             break;
        //         default:
        //             // Handle the "All" selection
        //             this._filterData("");
        //             break;
        //     }
        // },
        
        // _filterData: function (sFilterType) {
        //     // Implement your logic to filter data based on the filter type
        //     // For example, you can make an OData call to fetch the filtered data
        //     var oModel = this.getView().getModel();
        //     var sPath = "/INVOICEHISTORY";
        //     var aFilters = [];
        
        //     if (sFilterType !== null) {
        //         aFilters.push(new sap.ui.model.Filter("CURRENT", sap.ui.model.FilterOperator.EQ, sFilterType));
        //     }
        
        //     oModel.read(sPath, {
        //         filters: aFilters,
        //         success: function (oData) {
        //             // Handle the success scenario
        //             console.log("Data fetched successfully:", oData);
        //         },
        //         error: function (oError) {
        //             // Handle the error scenario
        //             console.error("Error fetching data:", oError);
        //         }
        //     });
        // },
        // _fetchVisibleData: function () {
        //     debugger
        //     const oModel = this.getView().getModel(); // OData v2 model
        //     const sPath = "/SalesSummary"; // Aggregation endpoint

        //     oModel.read(sPath, {
        //         success: (oData) => {
        //             const { TotalSales, UniqueInvoices, TotalPST, TotalGST } = oData;

        //             // Update summary panel
        //             this.getView().setModel(new JSONModel({
        //                 totalSales: this._formatLargeNumber(TotalSales),
        //                 totalInvoices: this._formatLargeNumber(UniqueInvoices)
        //             }), "summary");

        //             // Update footer
        //             this._updateFooter(TotalSales, TotalPST, TotalGST);
        //         },
        //         error: (oError) => {
        //             console.error("Failed to fetch aggregated data", oError);
        //         }
        //     });
        // },
        onTableScroll: function () {
            const table = this.getView().byId("table");
            const data = table.getBinding("rows").getContexts().map(context => context.getObject());
            this.updateCalculations(data);
            
        },
        updateCalculations: function (data) {
            
            // Define properties for calculations
            const decimalProperties = ["TSL_AMOUNT", "CAL_PST", "CAL_GST"]; // Footer sums
            const summarySalesProperty = "TSL_AMOUNT"; // Total sales for summary
            const uniqueInvoiceProperty = "BELNR"; // Unique invoice count
        
            const oFooterCountsModel = this.getView().getModel('footerCounts');
            const oSummaryCountsModel = this.getView().getModel('summaryCounts');
            const existingFooterCounts = oFooterCountsModel.getData();
            const existingSummaryCounts = oSummaryCountsModel.getData();
        
            // Temporary storage for unique invoices
            const uniqueInvoices = existingSummaryCounts._uniqueInvoices || new Set();
        
            // Process each row
            data.forEach(row => {
                // Sum footer values
                decimalProperties.forEach(property => {
                    const rowValue = typeof row[property] === "number" ? row[property] : parseFloat(row[property]) || 0;
                    const existingValue = typeof existingFooterCounts[property] === "number" 
                        ? existingFooterCounts[property] 
                        : parseFloat(existingFooterCounts[property]) || 0;
        
                    existingFooterCounts[property] = parseFloat((existingValue + rowValue).toFixed(2));
                });
        
                // Add invoice numbers to the unique set
                if (row[uniqueInvoiceProperty]) {
                    uniqueInvoices.add(row[uniqueInvoiceProperty]);
                }
        
                // Sum for summary total sales
                const rowSalesValue = typeof row[summarySalesProperty] === "number" 
                    ? row[summarySalesProperty] 
                    : parseFloat(row[summarySalesProperty]) || 0;
                const existingSalesValue = typeof existingSummaryCounts["TotalSales"] === "number" 
                    ? existingSummaryCounts["TotalSales"] 
                    : parseFloat(existingSummaryCounts["TotalSales"]) || 0;
        
                existingSummaryCounts["TotalSales"] = parseFloat((existingSalesValue + rowSalesValue).toFixed(2));
            });
           // Set unique invoice count
            existingSummaryCounts["UniqueInvoices"] = uniqueInvoices.size;

            // Store the Set in the model for persistence
            existingSummaryCounts._uniqueInvoices = uniqueInvoices;
        
            // Format summary sales value for display
            existingSummaryCounts["TotalSalesFormatted"] = this.formatLargeNumber(existingSummaryCounts["TotalSales"]);
        
            // Update models
            this.getView().getModel("footerCounts").setData(existingFooterCounts);
            this.getView().getModel("summaryCounts").setData(existingSummaryCounts);
        
            console.log("Final footerCounts:", existingFooterCounts);
            console.log("Final summaryCounts:", existingSummaryCounts);
        },
        
        /**
         * Format large numbers for summary panel.
         * Converts 233594532.19 to $233M, 2321980.45 to $2.32M, etc.
         */
        formatLargeNumber: function (value) {
            if (value >= 1e6) {
                return `$${(value / 1e6).toFixed(2)}M`;
            } else if (value >= 1e3) {
                return `$${(value / 1e3).toFixed(2)}K`;
            }
            return `$${value.toFixed(2)}`;
        },
        
        onFilterChange: function () {
            const table = this.getView().byId("table");
            const data = table.getBinding("rows").getContexts().map(context => context.getObject());

            // Reset totals to 0
            const oFooterCountsModel = this.getView().getModel('footerCounts');
            const oTileCountsModel = this.getView().getModel('summaryCounts');
            const resetFTotals = {
                "UniqueInvoices": 0,
                "TotalSales": 0,
                "TotalSalesFormatted": 0
            };
            const resetSTotals = {
                "TSL_AMOUNT": 0,
                "CAL_PST": 0,
                "CAL_GST": 0
            };
            oFooterCountsModel.setData(resetFTotals);
            oTileCountsModel.setData(resetSTotals)
            // Recalculate totals
            this.updateCalculations(data);
        },
        // _updateFooter: function (totalSales, totalPST, totalGST) {
        //     const oTable = this.byId("table");
        //     const oFooterData = {
        //         sales: this._formatCurrency(totalSales),
        //         pst: this._formatCurrency(totalPST),
        //         gst: this._formatCurrency(totalGST)
        //     };

        //     // Assuming footer is rendered with custom rows or JSON binding
        //     const oFooterModel = new JSONModel(oFooterData);
        //     oTable.setModel(oFooterModel, "footer");
        // },

        formatLargeNumber: function (value) {
            const oNumberFormat = NumberFormat.getFloatInstance({
                style: "short",
                minFractionDigits: 0,
                maxFractionDigits: 1
            });
            return oNumberFormat.format(value);
        },

        _formatCurrency: function (value) {
            if (value == null || value === undefined) {
            return "";
            }
        
            // Get the locale
            var sLocale = sap.ui.getCore().getConfiguration().getLocale().getLanguage();
            var sCurrencyCode;
        
            switch (sLocale) {
                case "en-US":
                    sCurrencyCode = "USD";
                    break;
                case "en-CA":
                    sCurrencyCode = "CAD";
                    break;
                case "fr-CA":
                    sCurrencyCode = "CAD";
                    break;
            // Add more cases as needed for other languages/regions
                default:
                    sCurrencyCode = "USD"; // Default currency code
                    break;
            }
        
            // Create a NumberFormat instance with currency type
            var oNumberFormat = sap.ui.core.format.NumberFormat.getCurrencyInstance({
            "currencyCode": false,
            "customCurrencies": {
                "MyDollar": {
                    "isoCode": sCurrencyCode,
                    "decimals": 2
                }
            },
            groupingEnabled: true,
            showMeasure: true
            });
            return oNumberFormat.format(value, "MyDollar");
        },
        _formatDate: function (date) {
            if (!date) return ""; // Return empty string if no date is provided
        
            let oDate;
        
            // Handle string date (e.g., 'yyyyMMdd')
            if (typeof date === "string") {
                if (date.length === 8) { // Ensure the format is correct
                    const formattedDateString = date.slice(0, 4) + '-' + date.slice(4, 6) + '-' + date.slice(6, 8);
                    oDate = new Date(formattedDateString + "T00:00:00Z"); // Force UTC for consistency
                } else {
                    return ""; // Invalid string format
                }
            }
            // Handle Date object
            else if (date instanceof Date) {
                oDate = new Date(date.getTime()); // Clone to avoid mutation
            } else {
                return ""; // Unsupported type
            }
        
            // Check if the date is valid
            if (isNaN(oDate.getTime())) {
                return ""; // Return empty string for invalid date
            }
        
            // Adjust for local timezone only if necessary
            // Remove the offset adjustment if using UTC consistently across your app
            oDate.setMinutes(oDate.getMinutes() + oDate.getTimezoneOffset());
        
            // Format the date into a more readable string
            const oDateFormat = sap.ui.core.format.DateFormat.getDateInstance({
                style: "medium" // Use 'medium' style or customize as needed
            });
        
            // Return the formatted date
            return oDateFormat.format(oDate);
        },
        _removeLeadingZeros: function(sku) {
            return sku ? String(parseInt(sku, 10)) : sku;   
        },
        _formatNumberSuffix : function (value, isDollarAmount = true) {
            if (typeof value !== "number") {
                return value;
            }

            var absValue = Math.abs(value);
            let formattedValue;

            if (absValue >= 1_000_000) {
                if (isDollarAmount){
                    formattedValue = (value / 1_000_000).toFixed(2) + "M";
                }
                formattedValue = (value / 1_000_000) + "M";
            } else if (absValue >= 1_000) {
                if (isDollarAmount) {
                    formattedValue = (value / 1_000).toFixed(2) + "K"
                }
                formattedValue = (value / 1_000) + "K"
            } else {
                if (isDollarAmount) {
                    formattedValue = formattedValue.toFixed(2);
                }
                formattedValue = value
            }

            return formattedValue;
        },
        onInvoiceClick: function (oEvent) {
            const sInvoiceNumber = oEvent.getSource().getText();

            // Mock API Call
            const sMockAPI = `/mock-api/invoices/${sInvoiceNumber}`;
            this._fetchInvoiceImage(sMockAPI)
                .then((sImageUrl) => this._showInvoiceDialog(sImageUrl))
                .catch((err) => sap.m.MessageToast.show("Failed to load invoice"));
        },
        _fetchInvoiceImage: function (sUrl) {
            // Simulate API response
            return new Promise((resolve, reject) => {
                setTimeout(() => {
                    resolve("https://via.placeholder.com/600x800.png?text=Invoice");
                }, 1000);
            });
        },
        _showInvoiceDialog: function (sImageUrl) {
            const oDialog = new Dialog({
                title: "Invoice",
                content: new Image({ src: sImageUrl, width: "100%" }),
                buttons: [
                    new Button({
                        text: "Download",
                        press: () => this._downloadImage(sImageUrl)
                    }),
                    new Button({
                        text: "Print",
                        press: () => this._printImage(sImageUrl)
                    }),
                    new Button({
                        text: "Close",
                        press: function () {
                            oDialog.close();
                        }
                    })
                ]
            });
            oDialog.open();
        },

        _downloadImage: function (sImageUrl) {
            const oLink = document.createElement("a");
            oLink.href = sImageUrl;
            oLink.download = "invoice.png";
            oLink.click();
        },

        _printImage: function (sImageUrl) {
            const printWindow = window.open("");
            printWindow.document.write(`<img src='${sImageUrl}' style='width:100%;'/>`);
            printWindow.print();
            printWindow.close();
        }
    });
});