sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'fiori/assemblyapp/test/integration/FirstJourney',
		'fiori/assemblyapp/test/integration/pages/CP_ASSEMBLY_REQ_SETList',
		'fiori/assemblyapp/test/integration/pages/CP_ASSEMBLY_REQ_SETObjectPage'
    ],
    function(JourneyRunner, opaJourney, CP_ASSEMBLY_REQ_SETList, CP_ASSEMBLY_REQ_SETObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('fiori/assemblyapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCP_ASSEMBLY_REQ_SETList: CP_ASSEMBLY_REQ_SETList,
					onTheCP_ASSEMBLY_REQ_SETObjectPage: CP_ASSEMBLY_REQ_SETObjectPage
                }
            },
            opaJourney.run
        );
    }
);