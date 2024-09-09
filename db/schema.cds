// Namespaces are automatically applied to all relevant names in a file, e.g. "sapcap.bookshop.Authors", or "sapcap.bookshop.Books"
namespace sapcap.bookshop;

using {
    cuid,
    managed,
    Currency,
    Country,
    sap.common.CodeList
} from '@sap/cds/common';

// Simple Types can be defined either using sintax "define type" or "type"
// Types can be defined before entity definition which uses this type
type NoOfBooks : Integer;

// Entities can be defined either using "define entity" or "entity"
entity Authors : cuid, managed {
    name        : String(100) @mandatory; // Length can be defined between ()
    dateOfBirth : Date;
    dateOfDeath : Date;
    epoch       : Association to Epochs @assert.target;
    books       : Association to many Books
                      on books.author = $self;
}

define entity Books : cuid, managed {
    title       : localized String(255) @mandatory;
    author      : Association to Authors @mandatory @assert.target;
    genre       : Genre @assert.range: true;
    publCountry : Country;
    stock       : NoOfBooks default 0;
    price       : Price;
    isHardcover : Boolean;

}

// Structured Types
// Structured types combine one or more related elements under a single type
// Types can be defined after entity definition which uses this type
type Price {
    amount   : Decimal;
    currency : Currency;
}

// Enumarations
// Enumerations can be used to make code more readable and self-explanatory, as they allow to replace cryptic values with symbols in the application logic
type Genre     : Integer enum {
    fiction     = 1;
    non_fiction = 2;
}

// CodeList
entity Epochs: CodeList {
    key ID : Integer;
}

annotate Books with {
    modifiedAt @odata.etag
}

annotate Authors with {
    modifiedAt @odata.etag
}
// Hint
// Naming conventions: It is recommended to capitalize type names in the same way as entity names.
// In contrast to entity names, however, use the singular form for type names (e.g. Price).