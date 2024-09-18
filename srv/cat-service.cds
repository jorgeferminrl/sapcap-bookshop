using sapcap.bookshop as db from '../db/schema';

service Catalog.Service @(path: '/cat') {

    entity Authors as
        projection on db.Authors {
            *,
            epoch.name as period
        }
        excluding {
            createdAt,
            createdBy,
            modifiedAt,
            modifiedBy
        };

    entity Books   as
        projection on db.Books {
            ID,
            title,
            author.name      as writer,
            publCountry.name as publCountry,
            isHardcover,
            price.amount,
            price.currency,
            stock,
            author
        };
}
