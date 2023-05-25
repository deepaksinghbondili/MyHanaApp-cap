sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'fiori.assemblyapp',
            componentId: 'CP_ASSEMBLY_REQ_SETObjectPage',
            entitySet: 'CP_ASSEMBLY_REQ_SET'
        },
        CustomPageDefinitions
    );
});