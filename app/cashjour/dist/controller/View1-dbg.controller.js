sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/Dialog",
    "sap/m/Button",
    "sap/m/Image",
    "sap/m/MessageBox",
    "sap/ui/core/Fragment",
	"sap/ui/core/syncStyleClass",
    "sap/m/MessageToast"
], (Controller, Dialog, Button, Image, MessageBox,Fragment, syncStyleClass, MessageToast) => {
    "use strict";

    return Controller.extend("cashjour.controller.View1", {
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
              // Access the underlying table
            
            this._debouncedCalculateTotals = this._debounce(this._calculateTotals.bind(this), 300);
            oTable.attachEvent("rowsUpdated", this._debouncedCalculateTotals);
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile");
            // Fetch data
             oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("cashjour").split("/resources")[0];
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
        onOpenDialog: function () {
			// load BusyDialog fragment asynchronously
			if (!this._pBusyDialog) {
				this._pBusyDialog = Fragment.load({
					name: "cashjour.view.BusyDialog",
					controller: this
				}).then(function (oBusyDialog) {
					this.getView().addDependent(oBusyDialog);
					syncStyleClass("sapUiSizeCompact", this.getView(), oBusyDialog);
					return oBusyDialog;
				}.bind(this));
			}

			this._pBusyDialog.then(function(oBusyDialog) {
				oBusyDialog.open();
			}.bind(this));
		},
        onCloseDialog: function () {
            var oBusyDialog = this.getView().byId("busyDialog");
            oBusyDialog.close();
        },
        _calculateTotals: function (oEvent) {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows"); // For GridTable
            var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts binding
            
            // Ensure that the binding exists and is set up
            if (oBinding) {
                var fTotalNetWr = 0;   // Total for NETWR (Invoice Amount)
                var fTotalCashReceived = 0;  // Total for CAL_CASH_RECEIVED (Cash Received)
                var fTotalDiscount = 0;  // Total for CAL_CASH_RECEIVED (Cash Received)
        
                // Iterate through the rows to sum the values
                aContexts.forEach(function (oContext) {
                    fTotalNetWr += parseFloat(oContext.getProperty("NETWR")) || 0;
                    fTotalCashReceived += parseFloat(oContext.getProperty("CAL_CASH_RECEIVED")) || 0;
                    fTotalDiscount += parseFloat(oContext.getProperty("CAL_DISCOUNT")) || 0;
                });
                var formattedNetWr = this._formatCurrency(fTotalNetWr);
                var formattedCashReceived = this._formatCurrency(fTotalCashReceived);
                var formattedDiscount = this._formatCurrency(fTotalDiscount);
                // Update footer with the calculated totals
                
                this.byId("TotUnitsPriceText").setText(formattedNetWr);
                this.byId("TotUnitsInStockText").setText(formattedCashReceived);
                this.byId("TotUnitsOnOrderText").setText(formattedDiscount);
            }
            
        },
        _debounce: function(func, wait) {
            let timeout;
            return function (...args) {
                const context = this;
                clearTimeout(timeout);
                timeout = setTimeout(() => func.apply(context, args), wait);
            };
            
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