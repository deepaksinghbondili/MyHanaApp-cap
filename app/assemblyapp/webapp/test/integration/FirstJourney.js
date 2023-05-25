sap.ui.define([
    "sap/ui/test/opaQunit"
], function (opaTest) {
    "use strict";

    var Journey = {
        run: function() {
            QUnit.module("First journey");

            opaTest("Start application", function (Given, When, Then) {
                Given.iStartMyApp();

                Then.onTheCP_ASSEMBLY_REQ_SETList.iSeeThisPage();

            });


            opaTest("Navigate to ObjectPage", function (Given, When, Then) {
                // Note: this test will fail if the ListReport page doesn't show any data
                When.onTheCP_ASSEMBLY_REQ_SETList.onFilterBar().iExecuteSearch();
                Then.onTheCP_ASSEMBLY_REQ_SETList.onTable().iCheckRows();

                When.onTheCP_ASSEMBLY_REQ_SETList.onTable().iPressRow(0);
                Then.onTheCP_ASSEMBLY_REQ_SETObjectPage.iSeeThisPage();

            });

            opaTest("Teardown", function (Given, When, Then) { 
                // Cleanup
                Given.iTearDownMyApp();
            });
        }
    }

    return Journey;
});