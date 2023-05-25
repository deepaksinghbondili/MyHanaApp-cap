namespace db;

using { Country } from '@sap/cds/common';
type BusinessKey : String(10);
type SDate : DateTime;
type LText : String(1024);


entity Interactions_Header {
  key ID : Integer;
  ITEMS  : Composition of many Interactions_Items on ITEMS.INTHeader = $self;
  PARTNER  : BusinessKey;
  LOG_DATE  : SDate;
  BPCOUNTRY : Country;

};
entity Interactions_Items {

    key INTHeader : association to Interactions_Header;
    key TEXT_ID : BusinessKey;
        LANGU   : String(2);
        LOGTEXT : LText;
};

entity V_ASSEMBLY_REQ {
    LOCATION_ID   : String(4);
    PRODUCT_ID    : String(40);
    ITEM_NUM      : String(6);
    COMPONENT     : String(40);
    WEEK_DATE     : Date;
    MODEL_VERSION : String(20);
    VERSION       : String(10);
    SCENARIO      : String(32);
    TYPE          : String(2);
    REF_PRODID    : String(40);
    COMPCIR_QTY   : Decimal(13, 3);
}
