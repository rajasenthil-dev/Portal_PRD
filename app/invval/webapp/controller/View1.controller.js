sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/m/MessageBox"
], (Controller, JSONModel, MessageBox) => {
    "use strict";

    return Controller.extend("invval.controller.View1", {
        
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
                    "OPEN_STOCK": 0,
                    "QUARANTINE": 0,
                    "DAMAGE_DESTRUCTION": 0,
                    "RETAINS": 0,
                    "QUALITY_HOLD": 0,
                    "RETURNS_CAL": 0,
                    "RECALLS": 0
                }
            });
            var oFooterCountsModel = new JSONModel({
                counts: {
                    "TOTAL_COST": 0,
                    "OPEN_STOCK": 0,
                    "QUARANTINE": 0,
                    "DAMAGE_DESTRUCTION": 0,
                    "RETAINS": 0,
                    "QUALITY_HOLD": 0,
                    "RETURNS_CAL": 0,
                    "RECALLS": 0
                }
            });

            this.getView().setModel(oTileCountsModel, "summaryCounts"); // GridTable
            this.getView().setModel(oFooterCountsModel, "footerCounts");
            
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invval").split("/resources")[0];
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
            
            this.getView().byId("table").attachEvent("rowsUpdated", this.onTableScroll.bind(this));
            
            

            // // Set up OData model
            // const oModel = new sap.ui.model.odata.v2.ODataModel("/odata/v2/inventory");
            // this.getView().setModel(oModel);

            // // Get the SmartTable and bind the data change event
            // var oSmartTable = this.getView().byId("table0");
            // var oTable = oSmartTable.getTable();
            // oTable.bindRows({
            //     path: "/INVENTORYVALUATION",
            //     parameters: { $top: 100, $skip: 0 }
            // });

            // // Attach scroll event for lazy loading
            // oTable.attachEventOnce("rowsUpdated", () => {
            //     const domRef = oTable.getDomRef("vsb");
            //     if (domRef) {
            //         domRef.addEventListener("scroll", this.onScrollLoad.bind(this));
            //     }
            // });

            // // Call _calculateTotals whenever rows are updated
            // oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        onGetManufacturerMedia: function (sManufacturerNumber) {
            var oModelLogo = this.getOwnerComponent().getModel("logo");
            
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile", undefined, undefined);
        
            // Fetch data
            oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("invval").split("/resources")[0];
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
        onTableScroll: function () {
            const table = this.getView().byId("table");
            const data = table.getBinding("rows").getContexts().map(context => context.getObject());
            this.updateCalculations(data);
        },
        
        updateCalculations: function (data) {
            const decimalProperties = [
                "TOTAL_COST",
                "OPEN_STOCK",
                "QUARANTINE",
                "DAMAGE_DESTRUCTION",
                "RETAINS",
                "RETURNS_CAL",
            ];
            const integerProperties = [
                "OPEN_STOCK",
                "QUARANTINE",
                "DAMAGE_DESTRUCTION",
                "RETAINS",
                "RETURNS_CAL"
            ];
            const allProperties = [...decimalProperties, ...integerProperties];
        
            const oFooterCountsModel = this.getView().getModel('footerCounts');
            const oTileCountsModel = this.getView().getModel('summaryCounts');
            const existingFooterCounts = oFooterCountsModel.getData();
            const existingSummaryCounts = oTileCountsModel.getData();
        
            data.forEach(row => {
                allProperties.forEach(property => {
                    const rowValue = typeof row[property] === "number" ? row[property] : parseFloat(row[property]) || 0;
                    const existingValue = typeof existingFooterCounts[property] === "number" 
                        ? existingFooterCounts[property] 
                        : parseFloat(existingFooterCounts[property]) || 0;
                    const existingSummaryValue = typeof existingSummaryCounts[property] === "number" 
                        ? existingSummaryCounts[property] 
                        : parseFloat(existingSummaryCounts[property]) || 0;
        
                    if (decimalProperties.includes(property)) {
                        existingFooterCounts[property] = parseFloat((existingValue + rowValue).toFixed(2));
                        existingSummaryCounts[property] = parseFloat((existingSummaryValue + rowValue).toFixed(2));
                    } else if (integerProperties.includes(property)) {
                        existingFooterCounts[property] = existingValue + rowValue;
                        existingSummaryCounts[property] = existingSummaryValue + rowValue;
                    }
                });
            });
        
            this.getView().getModel("footerCounts").setData(existingFooterCounts);
            this.getView().getModel("summaryCounts").setData(existingSummaryCounts);
        
            console.log("Final footerCounts:", existingFooterCounts);
            console.log("Final summaryCounts:", existingSummaryCounts);
        },
        onFilterChange: function () {
            debugger
            const table = this.getView().byId("table");
            const data = table.getBinding("rows").getContexts().map(context => context.getObject());

            // Reset totals to 0
            const oFooterCountsModel = this.getView().getModel('footerCounts');
            const oTileCountsModel = this.getView().getModel('summaryCounts');
            const resetTotals = {
                TOTAL_COST: 0,
                OPEN_STOCK: 0,
                QUARANTINE: 0,
                DAMAGE_DESTRUCTION: 0,
                RETAINS: 0,
                RETURN_CAL: 0,
                RECALLS: 0
            };
            oFooterCountsModel.setData(resetTotals);
            oTileCountsModel.setData(resetTotals)
            // Recalculate totals
            this.updateCalculations(data);
        },

        // _formatNumber: function (value) {
        //     return value.toLocaleString();
        // },
        
        formatLargeNumber: function (value) {
            if (value >= 1_000_000) return (value / 1_000_000).toFixed(1) + "M";
            if (value >= 1_000) return (value / 1_000).toFixed(1) + "K";
            return value.toString();
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
        // onScrollLoad: function (event) {
        //     const oTable = this.byId("table0");
        //     const scrollPosition = event.target.scrollTop;
        //     const maxScroll = event.target.scrollHeight - event.target.clientHeight;

        //     if (scrollPosition === maxScroll) {
        //         this.loadMoreData(oTable);
        //     }
        // },

        // loadMoreData: function (oTable) {
        //     const oBinding = oTable.getBinding("rows");
        //     const currentLength = oBinding.getLength();

        //     oBinding.suspend();
        //     oBinding.updateParameters({
        //         $top: 100,
        //         $skip: currentLength
        //     });
        //     oBinding.resume();
        // },

        // _calculateTotals: function () {
        //     var oSmartTable = this.getView().byId("table0");
        //     var oTable = oSmartTable.getTable();
        //     var oBinding = oTable.getBinding("rows"); // For GridTable
        //     var aContexts = oBinding.getContexts(0, oBinding.getLength()); // Get all contexts

        //     var oTileCounts = {
        //         OpenStock: 0,
        //         Quarantine: 0,
        //         Damage: 0,
        //         Retains: 0,
        //         QualityHold: 0,
        //         Returns: 0,
        //         Recalls: 0
        //     };

        //     var oFooterCounts = {
        //         TotalCost: 0,
        //         OpenStock: 0,
        //         Quarantine: 0,
        //         Damage: 0,
        //         Retains: 0,
        //         QualityHold: 0,
        //         Returns: 0,
        //         Recalls: 0
        //     };

        //     aContexts.forEach(function (oContext) {
        //         oTileCounts.OpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
        //         oTileCounts.Quarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
        //         oTileCounts.Damage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
        //         oTileCounts.Retains += parseFloat(oContext.getProperty("RETAINS")) || 0;
        //         oTileCounts.QualityHold += parseFloat(oContext.getProperty("QUALITY_HOLD")) || 0;
        //         oTileCounts.Returns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
        //         oTileCounts.Recalls += parseFloat(oContext.getProperty("RECALLS")) || 0;

        //         oFooterCounts.TotalCost += parseFloat(oContext.getProperty("TOTAL_COST")) || 0;
        //         oFooterCounts.OpenStock += parseFloat(oContext.getProperty("OPEN_STOCK")) || 0;
        //         oFooterCounts.Quarantine += parseFloat(oContext.getProperty("QUARANTINE")) || 0;
        //         oFooterCounts.Damage += parseFloat(oContext.getProperty("DAMAGE_DESTRUCTION")) || 0;
        //         oFooterCounts.Retains += parseFloat(oContext.getProperty("RETAINS")) || 0;
        //         oFooterCounts.QualityHold += parseFloat(oContext.getProperty("QUALITY_HOLD")) || 0;
        //         oFooterCounts.Returns += parseFloat(oContext.getProperty("RETURNS_CAL")) || 0;
        //         oFooterCounts.Recalls += parseFloat(oContext.getProperty("RECALLS")) || 0;
        //     });

        //     // Update the models with calculated totals
        //     this.getView().getModel("summaryCounts").setProperty("/counts", oTileCounts);
        //     this.getView().getModel("footerCounts").setProperty("/counts", oFooterCounts);
        // },

        _formatNumber: function (value) {
            return new Intl.NumberFormat('en-US', {
                maximumFractionDigits: 0
            }).format(value);
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

        _removeLeadingZeros: function (sku) {
            return sku ? String(parseInt(sku, 10)) : sku;
        }
    });
});
