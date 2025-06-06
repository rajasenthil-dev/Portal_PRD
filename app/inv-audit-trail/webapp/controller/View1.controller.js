sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/model/json/JSONModel",
    "sap/ui/core/BusyIndicator",
    "sap/m/MessageBox",
    "sap/ui/model/resource/ResourceModel"
], (Controller, JSONModel, BusyIndicator, MessageBox, ResourceModel) => {
    "use strict";

    return Controller.extend("invaudittrail.controller.View1", {
        onInit: async function () {
            var oModel = this.getOwnerComponent().getModel();
            const oView = this.getView();
            const oSmartFilterBar = oView.byId("bar0");
        
            oView.setBusy(true);
        
            oSmartFilterBar.attachInitialized(function () {
                oView.setBusy(false); // Once filter bar + value helps are ready
            });
            var oBundle = this.getOwnerComponent().getModel("i18n").getResourceBundle();
            const oSmartTable = this.getView().byId("table0");
            var oToolbar = oSmartTable.getToolbar();
            var oCurrentStatus = new sap.m.ObjectStatus({
                text: oBundle.getText("INVENTORYAUDITTRAIL.CURRENTTEXT"),
                icon: "sap-icon://circle-task-2",
                state: "Success",
                inverted:true,
                tooltip: oBundle.getText("INVENTORYAUDITTRAIL.CURRENTTOOLTIP")
            })
            oCurrentStatus.addStyleClass("sapUiTinyMarginEnd");
            var oCurrentStatusText =  new sap.m.Text({
                text: " | "
            })
            oCurrentStatusText.addStyleClass("text-bold sapUiTinyMarginEnd");
            var oLegacyStatus = new sap.m.ObjectStatus({
                text: oBundle.getText("INVENTORYAUDITTRAIL.LEGACYTEXT"),
                icon: "sap-icon://circle-task-2",
                state: "Information",
                inverted:true,
                tooltip: oBundle.getText("INVENTORYAUDITTRAIL.LEGACYTOOLTIP")
            })
            oLegacyStatus.addStyleClass("sapUiTinyMarginEnd")
            var oLegacyStatusText =  new sap.m.Text({
                text: "Legacy Data"
            })
            oLegacyStatusText.addStyleClass("text-bold sapUiTinyMarginEnd")
            var oLegendTitle = new sap.m.Text({
                text: "Legend:"
            })
            oLegendTitle.addStyleClass("text-bold sapUiTinyMarginEnd");
            var oLegendBox = new sap.m.HBox({
                items: [
                    oCurrentStatus,
                    oCurrentStatusText,
                    oLegacyStatus
                    
                ],
                alignItems: "Center",
                justifyContent: "End"
            });

            oToolbar.addContent(new sap.m.ToolbarSpacer());
            oToolbar.addContent(oLegendBox);
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
            // Initialize a model for tile counts
            var oTileCountsModel = new JSONModel({
                counts: {
                    Order: 0,
                    Receipt: 0,
                    Adjustments: 0,
                    Returns: 0,
                    PhysicalCount: 0
                }
            });
            this.getView().setModel(oTileCountsModel, "transactionCounts");

            // Get the SmartTable and bind the data change event
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));

            // Fetch User Data and Logo
            const oUserModel = this.getOwnerComponent().getModel("userModel");
            const userData = oUserModel ? oUserModel.getData() : {};
            const mfgNumber = userData.ManufacturerNumber;

            const oLogoModel = this.getOwnerComponent().getModel("logo");

            const sAppPath = sap.ui.require.toUrl("invoicehis").split("/resources")[0] === "." 
                ? "" 
                : sap.ui.require.toUrl("invoicehis").split("/resources")[0];
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
         },
         onSearch: function () {
            const oSmartFilterBar = this.getView().byId("smartFilterBar");
            const oSmartTable = this.getView().byId("table0");
            const oBinding = oSmartTable.getTable().getBinding("rows");
        
            if (!oBinding) {
                console.warn("Table binding is missing.");
                return;
            }
        
            // Get selected value from the filter
            let sCurrentStatus = this.getView().byId("currentFilterBox").getSelectedKey();
        
            // Build the filter condition
            let aFilters = [];
            if (sCurrentStatus) {
                aFilters.push(new sap.ui.model.Filter("CURRENT", sap.ui.model.FilterOperator.Contains, sCurrentStatus));
            }
        
            // Apply the filter
            oBinding.filter(aFilters);
        },
         
        _calculateTotals: function () {
            
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows");

            var aContexts = oBinding.getContexts(0, oBinding.getLength());
            var oTileCounts = {
                Order: 0,
                Receipt: 0,
                Adjustments: 0,
                Returns: 0,
                PhysicalCount: 0
            };
            var fTotalQuantity = 0;
            
            aContexts.forEach(function (oContext) {
            fTotalQuantity += parseFloat(oContext.getProperty("MENGE")) || 0;
                var oData = oContext.getObject();
                if (oData.TRAN_TYPE && oData.MENGE) {
                    var iQuantity = parseFloat(oData.MENGE);
                    if (!isNaN(iQuantity)){
                        switch (oData.TRAN_TYPE) {
                            case "Order":
                                oTileCounts.Order += iQuantity;
                                break;
                            case "Receipt":
                                oTileCounts.Receipt += iQuantity;
                                break;
                            case "Adjustments":
                                oTileCounts.Adjustments += iQuantity;
                                break;
                            case "Returns":
                                oTileCounts.Returns += iQuantity;
                                break;
                            case "PhysicalCount":
                                oTileCounts.PhysicalCount += iQuantity;
                                break;
                        }
                    }
                }
            });
            var formattedQuantity = this._formatNumber(fTotalQuantity);

            // Update the model with calculated totals
            this.getView().getModel("transactionCounts").setProperty("/counts", oTileCounts);
            this.byId("footerText1").setText(formattedQuantity);
            
        },
        
        _formatNumber : function (value) {
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
        removeLeadingZeros: function(value) {
            if (typeof value === "string" && /^\d+$/.test(value)) {
                return String(Number(value));
            }
            return value; 
        }
        
        
    });
});