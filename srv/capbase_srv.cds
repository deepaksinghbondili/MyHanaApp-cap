using {db as database} from '../db/capbase';

service CatalogService {

    entity Interactions_Header as projection on database.Interactions_Header;
    entity Interactions_Items  as projection on database.Interactions_Items;

}
