sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("bckorders.controller.View1", {
        onInit() {
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            oTable.attachEvent("rowsUpdated", this._calculateTotals.bind(this));
        },
        _calculateTotals: function () {
          debugger
            var oSmartTable = this.getView().byId("table0");
            var oTable = oSmartTable.getTable();
            var oBinding = oTable.getBinding("rows");

            var aContexts = oBinding.getContexts(0, oBinding.getLength());
      
            if (!aContexts) {
              console.warn("Data is not available for calculation.");
              return;
            }
      
            let totalBackOrders = 0;
            let impactedCustomers = new Set();
            let totalItemsOnBackOrder = new Set();
            let totalUnitsBackOrdered = 0;
            let totalUnitsToBeReceived = 0;
            let totalExtension = 0;
      
            // Process each item in the data array
            aContexts.forEach(function (oContext) {
                var oData = oContext.getObject();
                    totalBackOrders++;
                    impactedCustomers.add(oData.KUNRE_ANA); // Add unique impacted customers
                    totalItemsOnBackOrder.add(oData.MATNR); // Count the number of items on each back order
                    totalUnitsBackOrdered += parseFloat(oData.BACK_ORD_QTY); // Sum the quantity of units back ordered
                    totalExtension += parseFloat(oData.EXTENSION);
                    // Include calculation logic for 'Units to be received' as needed.
                    // Assuming units to be received is calculated based on some logic with your data.
                    // You can add further conditions or calculations here as necessary.
                
            });
      
            // Calculate the count of impacted customers
            const impactedCustomersCount = impactedCustomers.size;
            const totalItemsOnBackOrderCount = totalItemsOnBackOrder.size;
            const totalExtensionFormatted = this._formatCurrency(totalExtension)
            const totalQtyFormatted = this._formatNumber(totalUnitsBackOrdered)
      
            // Update UI elements (tiles) with calculated values
            this.byId("TileContent1").setText(totalBackOrders);
            this.byId("TileContent2").setText(impactedCustomersCount);
            this.byId("TileContent3").setText(totalItemsOnBackOrderCount);
            this.byId("TileContent4").setText(totalUnitsBackOrdered);
            this.byId("TileContent5").setText(totalUnitsToBeReceived);

            this.byId("footerText1").setText(totalQtyFormatted);
            this.byId("footerText2").setText(totalExtensionFormatted);
        },
        _formatNumber: function (value) {
          return new Intl.NumberFormat('en-US', {
              maximumFractionDigits: 0
          }).format(value);
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
          }
        // Event handler triggered by the Smart Filter Bar
    // onFilterBarFilterChange: function (oEvent) {
    //     debugger
    //     // Get filtered data from the Smart Table model
    //     const oSmartTable = this.byId("table0"); // Replace with your Smart Table ID
    //     const aTableData = oSmartTable.getTable().getBinding("rows"); // Assuming the model structure has `results`

    //     const oSmartFilterBar = oEvent.getSource();
    //     const aFilters = oSmartFilterBar.getFilters();

    //     // Log the filters to see if they are initialized
    //     console.log("Filters Applied:", aFilters);

    //     // Check for undefined filters and handle gracefully
    //     if (!aFilters || !aFilters.length) {
    //         console.warn("No filters applied or filters are undefined.");
    //         return;
    //     }

    //     // Process the filters if they exist
    //     aFilters.forEach(filter => {
    //         console.log("Filter Path:", filter.sPath);
    //         console.log("Filter Operator:", filter.sOperator);
    //         console.log("Filter Value:", filter.oValue1);
    //     });
  
    //     // Calculate metrics
    //     const metrics = {
    //       backOrders: this.calculateBackOrders(aTableData),
    //       impactedCustomers: this.calculateImpactedCustomers(aTableData),
    //       itemsOnBackOrder: this.calculateItemsOnBackOrder(aTableData),
    //       unitsBackOrdered: this.calculateUnitsBackOrdered(aTableData),
    //       unitsToBeReceived: this.calculateUnitsToBeReceived(aTableData)
    //     };
  
    //     // Update tile contents
    //     this.updateTileContent(metrics);
    //   },
  
    //   // Calculate the number of back orders
    //   calculateBackOrders: function (aData) {
    //     return aData.filter(row => !row.UDATE).length; // Filter where Cancel Date (UDATE) is null
    //   },
  
    //   // Calculate the number of impacted customers
    //   calculateImpactedCustomers: function (aData) {
    //     const uniqueCustomers = new Set(
    //       aData.filter(row => !row.UDATE) // Filter for back orders
    //         .map(row => row.KUNRE_ANA)   // Map to `Bill To` field
    //     );
    //     return uniqueCustomers.size;
    //   },
  
    //   // Calculate the number of items on back order
    //   calculateItemsOnBackOrder: function (aData) {
    //     return aData.filter(row => !row.UDATE).length; // Count rows where Cancel Date (UDATE) is null
    //   },
  
    //   // Calculate the total quantity of units back ordered
    //   calculateUnitsBackOrdered: function (aData) {
    //     return aData
    //       .filter(row => !row.UDATE) // Filter for back orders
    //       .reduce((total, row) => total + parseFloat(row.CAL_CONFIRMED_QTY || 0), 0); // Sum quantities
    //   },
  
    //   // Calculate the total units to be received
    //   calculateUnitsToBeReceived: function (aData) {
    //     return aData
    //       .filter(row => row.DATE_DIFF > 0 && !row.UDATE) // Age > 0 and Cancel Date (UDATE) is null
    //       .reduce((total, row) => total + parseFloat(row.CAL_CONFIRMED_QTY || 0), 0); // Sum quantities
    //   },
  
    //   // Update the tiles with calculated metrics
    //   updateTileContent: function (metrics) {
    //     this.byId("TileContent1").setNumber(metrics.backOrders);        // Update Back Orders
    //     this.byId("TileContent2").setNumber(metrics.impactedCustomers); // Update Impacted Customers
    //     this.byId("TileContent3").setNumber(metrics.itemsOnBackOrder);  // Update Items on Back Order
    //     this.byId("TileContent4").setNumber(metrics.unitsBackOrdered);  // Update Units Back Ordered
    //     this.byId("TileContent5").setNumber(metrics.unitsToBeReceived); // Update Units to Be Received
    //   }
    });
});