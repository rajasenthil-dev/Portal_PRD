sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/Image"
], (Controller, Dialog, Button, Image) => {
    "use strict";
    return Controller.extend("salesbycus.controller.View1", {
        onInit: function () {
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile");
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("salesbycus").split("/resources")[0];
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