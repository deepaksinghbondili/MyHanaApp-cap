using {db as database} from '../db/capbase';

service CatalogService {

    entity Interactions_Header as projection on database.Interactions_Header;
    entity Interactions_Items  as projection on database.Interactions_Items;
    entity CP_ASSEMBLY_REQ_SET as projection on database.V_ASSEMBLY_REQ;
    entity OrgSet              as projection on database.Organization;

    // @cds.http.method: 'POST'
    function validate(Obj : String) returns {
        message : String
    };

}
