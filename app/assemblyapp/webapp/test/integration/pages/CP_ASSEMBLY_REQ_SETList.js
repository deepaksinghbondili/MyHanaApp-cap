sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'fiori.assemblyapp',
            componentId: 'CP_ASSEMBLY_REQ_SETList',
            entitySet: 'CP_ASSEMBLY_REQ_SET'
        },
        CustomPageDefinitions
    );
});