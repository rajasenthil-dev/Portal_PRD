sap.ui.define([
    "sap/ui/core/format/DateFormat"
], (DateFormat) => {
    "use strict";

    // Shared EST Time Formatter
    const oTimeFormatter = DateFormat.getTimeInstance({
        pattern: "HH:mm",
        UTC: false,
        timeZone: "America/New_York" // Force EST always
    });

    return {
        yesNoIconColorN: function (value) {
            const cleanValue = (value || "").trim().toUpperCase();
            if (cleanValue.includes("Y")) return "Success";
            if (cleanValue.includes("N")) return "Error";
            return "None";
        },

        yesNoIconN: function (value) {
            const cleanValue = (value || "").trim().toUpperCase();
            if (cleanValue.includes("Y")) return "sap-icon://sys-enter-2";
            if (cleanValue.includes("N")) return "sap-icon://sys-cancel-2";
            return "";
        },

        yesNoIconColor: function (value) {
            const cleanValue = (value || "").trim().toUpperCase();
            if (cleanValue.includes("Y")) return "Success";
            if (cleanValue.includes("N")) return "Information";
            return "None";
        },

        yesNoIcon: function (value) {
            const cleanValue = (value || "").trim().toUpperCase();
            if (cleanValue.includes("Y")) return "sap-icon://circle-task-2";
            if (cleanValue.includes("N")) return "sap-icon://circle-task-2";
            return "";
        },

        _formatCurrency: function (value) {
            if (value == null) return "";

            const sLocale = sap.ui.getCore().getConfiguration().getLocale().getLanguage();
            let sCurrencyCode;

            switch (sLocale) {
                case "en-US":
                    sCurrencyCode = "USD";
                    break;
                case "en-CA":
                case "fr-CA":
                    sCurrencyCode = "CAD";
                    break;
                default:
                    sCurrencyCode = "USD";
                    break;
            }

            const oNumberFormat = sap.ui.core.format.NumberFormat.getCurrencyInstance({
                currencyCode: false,
                customCurrencies: {
                    "MyDollar": {
                        isoCode: sCurrencyCode,
                        decimals: 2
                    }
                },
                groupingEnabled: true,
                showMeasure: true
            });

            return oNumberFormat.format(value, "MyDollar");
        },

        /** Convert UTC HH:mm field into EST display */
        toESTFromUTC: function (sUtcTime) {
            if (!sUtcTime) return "";

            // Make sure it's a string (sometimes binding passes an object)
            const timeStr = String(sUtcTime).trim();

            // Example: "12:30:17 AM" or "14:40:10"
            // Try parsing with the browser first
            let oDate = new Date(`1970-01-01T${timeStr}Z`);

            // If parse failed → manually fix AM/PM case
            if (isNaN(oDate.getTime())) {
                const match = timeStr.match(/(\d{1,2}):(\d{2})(?::(\d{2}))?\s*(AM|PM)?/i);
                if (!match) return "";

                let [ , hh, mm, ss = "00", period] = match;

                hh = parseInt(hh, 10);

                // Convert to 24-hour if AM/PM present
                if (period) {
                    period = period.toUpperCase();
                    if (period === "PM" && hh !== 12) hh += 12;
                    if (period === "AM" && hh === 12) hh = 0;
                }

                oDate = new Date(Date.UTC(1970, 0, 1, hh, mm, ss));
            }

            return oTimeFormatter.format(oDate);
        },

        /** Convert CONFIRMED_TIME timestamp into EST display */
        toESTFromTimestamp: function (vTimestamp) {
            if (!vTimestamp) return "";
            const oDate = new Date(vTimestamp);
            return oTimeFormatter.format(oDate);
        }
    };
});