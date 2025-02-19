sap.ui.define([], () => {
    "use strict";

    return {
        
        formatUrl: function (sUrl) {
            if (!sUrl) return "";

            var sAppPath = sap.ui.require.toUrl("admindash").split("/resources")[0];
            if(sAppPath === ".") {
                sAppPath = "";
            }
            console.log("✅ Dynamic Base Path:", sAppPath);

            var fullUrl = sAppPath + sUrl;

            return fullUrl;
        }

        
    };
});