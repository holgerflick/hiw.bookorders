create table books
(
    id       INTEGER not null
        constraint books_pk
            primary key autoincrement,
    title    NCHAR(500),
    subtitle NCHAR(500),
    cover    BLOB
);

create table editions
(
    id      INTEGER not null
        constraint editions_pk
            primary key autoincrement,
    name    NCHAR(100),
    booksId integer
        constraint editions_books_id_fk
            references books,
    asin    VARCHAR(20)
);

create table stores
(
    id          integer not null
        constraint stores_pk
            primary key autoincrement,
    name        NCHAR(50),
    countryCode CHAR(2),
    domain      VARCHAR(10)
);

create table unavailable
(
    storeId   integer not null
        constraint availablebooks_stores_id_fk
            references stores,
    editionId integer not null
        constraint availablebooks_editions_id_fk
            references editions,
    constraint availablebooks_pk
        primary key (storeId, editionId)
);

