sap.ui.define([
    "sap/ui/core/mvc/Controller"
], (Controller) => {
    "use strict";

    return Controller.extend("logo.controller.View1", {
        onInit() {
            var oModelLogo = this.getOwnerComponent().getModel();
            console.log(oModelLogo)
            // Bind to the MediaFile entity with a filter
            var oBinding = oModelLogo.bindList("/MediaFile");
            console.log(oBinding)
            var oContext = oBinding.requestContexts();
            console.log(oContext)
            // // Fetch data
             oBinding.requestContexts().then(function (aContexts) {
                if (aContexts.length > 0) {
                    var oData = aContexts[0].getObject();
                    console.log("Manufacturer:", oData.MFGName);
                    console.log("File URL:", oData.url);
                    var sAppPath = sap.ui.require.toUrl("logo").split("/resources")[0];
                    if(sAppPath === ".") {
                        sAppPath = " ";
                    }
                    console.log("✅ Dynamic Base Path:", sAppPath);
    
                    var sSrcUrl = sAppPath + oData.url;
                    // Example: Set the image source
                    this.getView().byId("logoImage").setSrc(sSrcUrl);
                } else {
                    console.log("No media found for this manufacturer.");
                }
            }.bind(this));
        }
    });
});