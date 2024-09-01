// Namespaces are automatically applied to all relevant names in a file, e.g. "sapcap.bookshop.Authors", or "sapcap.bookshop.Books"
namespace sapcap.bookshop;

// Simple Types can be defined either using sintax "define type" or "type"
// Types can be defined before entity definition which uses this type
type NoOfBooks : Integer;

// Entities can be defined either using "define entity" or "entity"
entity Authors {
    key ID          : UUID;
        name        : String(100); // Length can be defined between ()
        dateOfBirth : Date;
        dateOfDeath : Date;
        books       : Association to many Books
                          on books.author = $self;
}

define entity Books {
    key ID          : UUID;
        title       : String(255);
        author      : Association to Authors;
        genre       : Genre;
        publCountry : String(3);
        stock       : NoOfBooks;
        price       : Price;
        isHardcover : Boolean;

}

// Structured Types
// Structured types combine one or more related elements under a single type
// Types can be defined after entity definition which uses this type
type Price {
    amount   : Decimal;
    currency : String(3);
}

// Enumarations
// Enumerations can be used to make code more readable and self-explanatory, as they allow to replace cryptic values with symbols in the application logic
type Genre     : Integer enum {
    fiction     = 1;
    non_fiction = 2;
}


// Hint
// Naming conventions: It is recommended to capitalize type names in the same way as entity names.
// In contrast to entity names, however, use the singular form for type names (e.g. Price).
