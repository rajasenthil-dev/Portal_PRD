sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'shipstatus/test/integration/FirstJourney',
		'shipstatus/test/integration/pages/SHIPPINGSTATUSList',
		'shipstatus/test/integration/pages/SHIPPINGSTATUSObjectPage'
    ],
    function(JourneyRunner, opaJourney, SHIPPINGSTATUSList, SHIPPINGSTATUSObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('shipstatus') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSHIPPINGSTATUSList: SHIPPINGSTATUSList,
					onTheSHIPPINGSTATUSObjectPage: SHIPPINGSTATUSObjectPage
                }
            },
            opaJourney.run
        );
    }
);