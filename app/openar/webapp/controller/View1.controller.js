sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/Image"
], (Controller, Dialog, Button, Image) => {
    "use strict";

    return Controller.extend("openar.controller.View1", {
        onInit: function () {
            var oTable = this.byId("table");
            var oModel = this.getOwnerComponent().getModel();

            oTable.setModel(oModel);

            // Attach the rowsUpdated event instead of updateFinished
            oTable.attachEvent("rowsUpdated", this._calculateFooterAndSummary.bind(this));
        },

        // Table update handler for rowsUpdated event
        _onTableUpdate: function () {
            this._calculateFooterAndSummary();
        },

        // Calculate Footer and Summary Panel
        _calculateFooterAndSummary: function () {
            var oTable = this.byId("table");
            var oBinding = oTable.getBinding("rows");

            var aContexts = oBinding.getContexts(0, oBinding.getLength());

            if (!oBinding) return;

            // Get all data contexts from the binding
            var totals = {
                fTotCurrent: 0,
                fTot1to30: 0,
                fTot31to60: 0,
                fTot61to90: 0,
                fTotOver90: 0,
                fTotInvoice: 0,
                fTotAmountPaid: 0
            };

            // Iterate over each context to aggregate data
            aContexts.forEach(function (oContext) {
                totals.fTotCurrent += this._getValueOrZero(oContext, "CAL_CURRENT");
                totals.fTot1to30 += this._getValueOrZero(oContext, "CAL_1_30");
                totals.fTot31to60 += this._getValueOrZero(oContext, "CAL_31_60");
                totals.fTot61to90 += this._getValueOrZero(oContext, "CAL_61_90");
                totals.fTotOver90 += this._getValueOrZero(oContext, "CAL_OVER_90");
                totals.fTotInvoice += this._getValueOrZero(oContext, "NETWR");
                totals.fTotAmountPaid += this._getValueOrZero(oContext, "TSL");
            }, this);

            // Format currency and update footer
            Object.keys(totals).forEach(function (key) {
                var formattedValue = this._formatCurrency(totals[key]);
                this.byId("footerText" + this._getFooterIndex(key)).setText(formattedValue);
            }, this);

            // Donut chart percent calculations
            var donutValues = [
                totals.fTotCurrent,
                totals.fTot1to30,
                totals.fTot31to60,
                totals.fTot61to90,
                totals.fTotOver90
            ];

            var totalDonut = donutValues.reduce((sum, value) => sum + value, 0);
            var percentages = totalDonut === 0 ? [0, 0, 0, 0, 0] : donutValues.map(value => (value / totalDonut) * 100);
            this._updateDonutChart(percentages);

            // Other metrics: Past Due, Balance Owed, Open Invoices, Average Age
            this._updatePastDue(aContexts);
            this._updateBalanceOwed(totals.fTotInvoice, totals.fTotAmountPaid);
            this._updateOpenInvoices(aContexts);
            this._updateAvgAge(oTable);
        },

        // Helper function to get value or return zero if undefined
        _getValueOrZero: function (oContext, sProperty) {
            var value = oContext.getProperty(sProperty);
            return value ? parseFloat(value) : 0;
        },

        // Helper function to format currency
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

        // Helper function to update footer text index
        _getFooterIndex: function (key) {
            var mapping = {
                fTotCurrent: 1,
                fTot1to30: 2,
                fTot31to60: 3,
                fTot61to90: 4,
                fTotOver90: 5,
                fTotInvoice: 6,
                fTotAmountPaid: 7
            };
            return mapping[key] || 0;
        },

        // Helper function to update donut chart
        _updateDonutChart: function (percentages) {
            var donutIds = [
                "_IDGenInteractiveDonutChartSegment",
                "_IDGenInteractiveDonutChartSegment1",
                "_IDGenInteractiveDonutChartSegment2",
                "_IDGenInteractiveDonutChartSegment3",
                "_IDGenInteractiveDonutChartSegment4"
            ];

            donutIds.forEach(function (id, index) {
                this.byId(id).setValue(percentages[index]);
                this.byId(id).setDisplayedValue(percentages[index].toFixed(2) + "%");
            }, this);
        },

        // Calculate the Past Due Amount
        _updatePastDue: function (aContexts) {
            var totalPastDue = 0;
            aContexts.forEach(function (oContext) {
                var oData = oContext.getObject();
                var dueDate = oData.NETDT ? this._formatDate(oData.NETDT) : null;

                if (!dueDate) {
                    return; // Skip if the date is invalid
                }

                var currentDate = new Date();
                var balance = oData.NETWR - oData.TSL;

                if (currentDate > dueDate && balance > 0) {
                    totalPastDue += balance;
                }
            }, this);

            var totPastDueText = this._formatAmount(totalPastDue);
            this.byId("_IDGenNumericContent2").setText(totPastDueText);
        },

        // Calculate Balance Owed
        _updateBalanceOwed: function (invoice, paid) {
            var balanceOwed = invoice - paid;
            var formattedBalance = this._formatAmount(balanceOwed);
            this.byId("_IDGenNumericContent1").setText(formattedBalance);
        },

        // Calculate Open Invoices
        _updateOpenInvoices: function (aContexts) {
            var openInvoiceCount = aContexts.filter(function (oContext) {
                var oData = oContext.getObject();
                var balance = oData.NETWR - oData.TSL;
                return balance > 0;
            }).length;

            this.byId("_IDGenNumericContent5").setText(openInvoiceCount);
        },

        // Calculate Average Age of Open Invoices
        _updateAvgAge: function (oTable) {
            var oBinding = oTable.getBinding("rows");
            if (!oBinding) return 0;

            var aData = oBinding.getContexts().map(function (context) {
                return context.getObject();
            });

            var avgAge = aData.reduce(function (sum, item) {
                return sum + (item.CAL_AGE || 0);
            }, 0) / aData.length;

            this.byId("_IDGenNumericContent4").setText(avgAge.toFixed(1));
        },

        // Format Amount in K/M format
        _formatAmount: function (amount) {
            if (amount >= 1e6) return "$" + (amount / 1e6).toFixed(2) + 'M';
            if (amount >= 1e3) return "$" + (amount / 1e3).toFixed(2) + 'K';
            return "$" + amount.toFixed(2);
        },

        // Format Date
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

