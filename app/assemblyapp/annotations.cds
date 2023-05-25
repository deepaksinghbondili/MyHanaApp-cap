using CatalogService as service from '../../srv/capbase_srv';

annotate service.CP_ASSEMBLY_REQ_SET with {
    LOCATION_ID    @Analytics.Dimension: true  @Common.Label       : 'Demand Location';
    PRODUCT_ID     @Analytics.Dimension: true  @Common.Label       : 'Product ID';
    ITEM_NUM       @Analytics.Dimension: true  @Common.Label       : 'Item Number';
    COMPONENT      @Analytics.Dimension: true  @Common.Label       : 'Component';
    SCENARIO       @Analytics.Dimension: true  @Common.Label       : 'Scenario';
    VERSION        @Analytics.Dimension: true  @Common.Label       : 'Version';
    MODEL_VERSION  @Analytics.Dimension: true  @Common.Label       : 'Model Version';
    WEEK_DATE      @Analytics.Dimension: true  @Common.Label       : 'Week Date';
    REF_PRODID     @Analytics.Dimension: true  @Common.Label       : 'Config. Products';
    COMPCIR_QTY    @Analytics.Measure  : true  @Aggregation.default: #SUM  @Common.Label: 'Quantity';
};

annotate service.CP_ASSEMBLY_REQ_SET with @Aggregation.ApplySupported: {
    GroupableProperties   : [
        LOCATION_ID,
        PRODUCT_ID,
        WEEK_DATE,
        VERSION,
        SCENARIO,
        COMPONENT,
        ITEM_NUM,
        REF_PRODID,
        MODEL_VERSION
    ],
    AggregatableProperties: [{Property: COMPCIR_QTY}],
    PropertyRestrictions  : true,
    Transformations       : [
        'aggregate',
        'topcount',
        'bottomcount',
        'identity',
        'concat',
        'groupby',
        'filter',
        'expand',
        'search'
    ],
};

annotate service.CP_ASSEMBLY_REQ_SET with @(Analytics.AggregatedProperties: [
    {
        Name                : 'MinQuantity',
        AggregationMethod   : 'min',
        AggregatableProperty: 'COMPCIR_QTY',
        ![@Common.Label]    : 'Minimal Quantity'
    },
    {
        Name                : 'MaxQuantity',
        AggregationMethod   : 'max',
        AggregatableProperty: 'COMPCIR_QTY',
        ![@Common.Label]    : 'Maximal Quantity'
    },
    {
        Name                : 'AvgQuantity',
        AggregationMethod   : 'average',
        AggregatableProperty: 'COMPCIR_QTY',
        ![@Common.Label]    : 'Average Quantity'
    },
    {
        Name                : 'TotalQuantity',
        AggregationMethod   : 'sum',
        AggregatableProperty: 'COMPCIR_QTY',
        ![@Common.Label]    : 'Total Quantity'
    }
]);

annotate service.CP_ASSEMBLY_REQ_SET with @(Analytics.AggregatedProperty #totQty: {
    Name                : 'TotalQuantity',
    AggregationMethod   : 'sum',
    AggregatableProperty: COMPCIR_QTY,
    @Common.Label       : 'TotalQuantity'
});

// Filters

annotate service.CP_ASSEMBLY_REQ_SET with @(UI.SelectionFields: [
    COMPONENT,
    PRODUCT_ID,
    WEEK_DATE,
    LOCATION_ID,
]);

// Main Table annotation
annotate service.CP_ASSEMBLY_REQ_SET with @(UI.LineItem: [
    {
        $Type             : 'UI.DataField',
        Value             : LOCATION_ID,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : PRODUCT_ID,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : COMPONENT,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : SCENARIO,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : WEEK_DATE,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : VERSION,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    },
    {
        $Type             : 'UI.DataField',
        Value             : COMPCIR_QTY,
        @UI.Importance    : #High,
        @HTML5.CssDefaults: {width: 'auto'},
    }
]);

annotate service.CP_ASSEMBLY_REQ_SET with @(Capabilities.DeleteRestrictions: {Deletable: false});

// Main Chart
annotate service.CP_ASSEMBLY_REQ_SET with @UI.Chart: {
    Title              : '{i18n>MainChartTitle}',
    ChartType          : #Column,
    $Type              : 'UI.ChartDefinitionType',
    Dimensions         : [
        WEEK_DATE,
        VERSION,
        COMPONENT
    ],
    DynamicMeasures    : ['@Analytics.AggregatedProperty#totQty'],
    DimensionAttributes: [
        {
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: VERSION,
            Role     : #Series,
        },
        {
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: WEEK_DATE,
            Role     : #Category,
        },
        {
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: COMPONENT,
            Role     : #Category,
        }
    ],
    MeasureAttributes  : [{
        $Type         : 'UI.ChartMeasureAttributeType',
        DynamicMeasure: '@Analytics.AggregatedProperty#totQty',
        Role          : #Axis1,
    }]
};


// annotate service.CP_ASSEMBLY_REQ_SET with {
//     VERSION @UI.ValueCriticality : [
//         {
//             $Type       : 'UI.ValueCriticalityType',
//             Value       : '__BASELINE',
//             Criticality : #Positive,
//         },
//         {
//             $Type       : 'UI.ValueCriticalityType',
//             Value       : '_BASELINE1',
//             Criticality : #Negative,
//         }
//     ]
// };

//Main Page Variant

annotate service.CP_ASSEMBLY_REQ_SET with @UI.PresentationVariant: {
    GroupBy       : [ // default grouping in table
    WEEK_DATE],
    Total         : [COMPCIR_QTY // default aggregation in table
    ],
    Visualizations: [
        '@UI.Chart',
        '@UI.LineItem',
    ]
};

// Visual Filters
annotate service.CP_ASSEMBLY_REQ_SET with @(
    UI.Chart #cDate               : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Line,
        Dimensions     : [WEEK_DATE, ],
        DynamicMeasures: ['@Analytics.AggregatedProperty#totQty', ],
    },
    UI.PresentationVariant #pvDate: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#cDate', ],
    }
);

annotate service.CP_ASSEMBLY_REQ_SET with {
    WEEK_DATE @Common.ValueList #vlDate: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'CP_ASSEMBLY_REQ_SET',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: WEEK_DATE,
            ValueListProperty: 'WEEK_DATE',
        }, ],
        PresentationVariantQualifier: 'pvDate',
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with @(
    UI.Chart #cLocation               : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [LOCATION_ID, ],
        DynamicMeasures: ['@Analytics.AggregatedProperty#totQty', ],
    },
    UI.PresentationVariant #pvLocation: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#cLocation', ],
    }
);

annotate service.CP_ASSEMBLY_REQ_SET with {
    LOCATION_ID @Common.ValueList #vlLocation: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'CP_ASSEMBLY_REQ_SET',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: LOCATION_ID,
            ValueListProperty: 'LOCATION_ID',
        }, ],
        PresentationVariantQualifier: 'pvLocation',
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with @(
    UI.Chart #visualFilter              : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [COMPONENT, ],
        DynamicMeasures: ['@Analytics.AggregatedProperty#totQty', ],
    },
    UI.PresentationVariant #visualFilter: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#visualFilter', ],
    }
);

annotate service.CP_ASSEMBLY_REQ_SET with {
    COMPONENT @Common.ValueList #visualFilter: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'CP_ASSEMBLY_REQ_SET',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: COMPONENT,
            ValueListProperty: 'COMPONENT',
        }, ],
        PresentationVariantQualifier: 'visualFilter',
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with @(
    UI.Chart #visualFilter1              : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [PRODUCT_ID, ],
        DynamicMeasures: ['@Analytics.AggregatedProperty#totQty', ],
    },
    UI.PresentationVariant #visualFilter1: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#visualFilter1', ],
    }
);

annotate service.CP_ASSEMBLY_REQ_SET with {
    PRODUCT_ID @Common.ValueList #visualFilter: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'CP_ASSEMBLY_REQ_SET',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            LocalDataProperty: PRODUCT_ID,
            ValueListProperty: 'PRODUCT_ID',
        }, ],
        PresentationVariantQualifier: 'visualFilter1',
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with {
    LOCATION_ID @Common.ValueList: {
        CollectionPath: 'CP_ASSEMBLY_REQ_SET',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'LOCATION_ID',
            LocalDataProperty: LOCATION_ID
        }]
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with {
    COMPONENT @Common.ValueList: {
        CollectionPath: 'CP_ASSEMBLY_REQ_SET',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'COMPONENT',
            LocalDataProperty: COMPONENT
        }]
    }
};

annotate service.CP_ASSEMBLY_REQ_SET with {
    PRODUCT_ID @Common.ValueList: {
        CollectionPath: 'CP_ASSEMBLY_REQ_SET',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'PRODUCT_ID',
            LocalDataProperty: PRODUCT_ID
        }]
    }
};
