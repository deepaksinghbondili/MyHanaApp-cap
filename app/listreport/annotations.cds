using CatalogService as service from '../../srv/capbase_srv';

annotate service.Interactions_Header with {
    ID
    @(Common: {ValueList: {
        CollectionPath: 'Interactions_Header',
        Parameters    : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'ID',
            LocalDataProperty: ID
        }]
    }});

    BPCOUNTRY
    @(
        Common                         : {ValueList: {
            CollectionPath: 'Interactions_Header',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                ValueListProperty: 'BPCOUNTRY_code',
                LocalDataProperty: BPCOUNTRY_code
            }]
        }},
        Common.ValueListWithFixedValues: true,
        Common                         : {Label: 'Country', }
    );
};


annotate service.Interactions_Header with @(
    UI.SelectionFields: [
        ID,
        BPCOUNTRY_code
    ],
    UI.LineItem       : [
        {
            $Type                : 'UI.DataField',
            Label                : 'ID',
            Value                : ID,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: 'auto',
            }
        },
        {
            $Type                : 'UI.DataFieldForAnnotation',
            Label                : 'PARTNER / Country',
            Target               : '@UI.FieldGroup#GeneratedGroup3',
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: 'auto',
            },
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'LOG_DATE',
            Value                : LOG_DATE,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: 'auto',
            }
        }
    ],

    UI.HeaderInfo     : {
        TypeName      : 'ID',
        TypeNamePlural: 'ID',
        Title         : {
            $Type: 'UI.DataField',
            Value: ID
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: PARTNER
        }
    },

    UI.HeaderFacets   : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#GeneratedGroup1'
    }]
);

annotate service.Interactions_Header with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ID',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'PARTNER',
                Value: PARTNER,
            },
            {
                $Type: 'UI.DataField',
                Label: 'LOG_DATE',
                Value: LOG_DATE,
            },
            {
                $Type: 'UI.DataField',
                Value: BPCOUNTRY_code,
            },
        ],
    },
    UI.FieldGroup #GeneratedGroup2: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'ID',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Value: ITEMS.INTHeader_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Items Lang',
                Value: ITEMS.LANGU,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Description',
                Value: ITEMS.LOGTEXT
            }
        ],
    },
    UI.FieldGroup #GeneratedGroup3: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: PARTNER,
            },
            {
                $Type: 'UI.DataField',
                Value: BPCOUNTRY_code,
            }
        ]
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Order Information',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Order Item details',
            ID    : 'GeneratedFacet2',
            Target: '@UI.FieldGroup#GeneratedGroup2'
        }
    ]
);
