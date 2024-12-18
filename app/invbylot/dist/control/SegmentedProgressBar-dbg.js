sap.ui.define([
    "sap/ui/core/Control",
    "sap/m/ProgressIndicator",
    "sap/m/Text"
], function(Control, ProgressIndicator, Text){
    "use strict";
    return Control.extend("invbylot.control.SegmentedProgressBar", {
        metadata: {
            properties: {
                value: {
                    type: "int",
                    defaultValue: 0
                }
            }
        },
        init: function() {
            
            this._oProgressBar = new ProgressIndicator({
                percentValue: 0,
                showValue: false
            });
            this._oLabel = new Text();
        },
        onBeforeRendering: function() {
            var oResourceBundle = sap.ui.getCore().getModel("i18n");
            var iDaysLeft = this.getValue();
            var sColor = "Success";

            if (iDaysLeft >= 120) {
                sColor = "Success";
            } else if (iDaysLeft > 0) {
                sColor = "Warning";
            } else if (iDaysLeft = 0) {
                sColor = "Error"
            } else {
                sColor = "Error"
            }

            var iPercent = Math.max((iDaysLeft / 120) * 100, 0);
            // Calculate percent based on max days (120)

            this._oProgressBar.setPercentValue(iPercent);

            this._oProgressBar.setState(sColor);

            var sLabel = iDaysLeft > 0? iDaysLeft + " " + this.getModel("i18n").getResourceBundle().getText("daysLeft") : this.getModel("i18n").getResourceBundle().getText("expired");
            var sLabel1 = "No Expiration Date";
            if (iDaysLeft === null) {
                this._oLabel.setText(sLabel1);
            } else {
                this._oLabel.setText(sLabel)
            }
        },
        renderer: function (oRM, oControl) {
            
            oRM.write("<div");
            oRM.writeControlData(oControl);
            oRM.write(">");
            oRM.renderControl(oControl._oLabel);
            oRM.renderControl(oControl._oProgressBar);
            oRM.write("</div>");
        }
    });
});