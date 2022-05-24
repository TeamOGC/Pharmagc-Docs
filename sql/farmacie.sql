set foreign_key_checks  = 0;
create or replace table Farmacia
(
    id_farmacia int          not null
        primary key,
    nome        varchar(255) not null,
    indirizzo   varchar(255) not null
);

create or replace table Farmacista
(
    id_farmacista int auto_increment   not null
        primary key,
    id_farmacia   int          not null,
    nome          varchar(255) not null,
    cognome       varchar(255) not null,
    email         varchar(255) not null,
    password      varchar(255) not null,
    constraint Farmacista_ibfk_1
        foreign key (id_farmacia) references Farmacia (id_farmacia)
);

create or replace index id_farmacia
    on Farmacista (id_farmacia);

create or replace table Farmaco
(
    id_farmaco       int          not null
        primary key,
    nome             varchar(255) not null,
    principio_attivo varchar(255) not null,
    da_banco         tinyint(1)   not null
);

create or replace table Lotto
(
    id_lotto    int not null,
    id_farmacia int not null,
    id_farmaco  int not null,
    quantita    int not null,
    primary key (id_lotto, id_farmacia),
    constraint Lotto_ibfk_1
        foreign key (id_farmaco) references Farmaco (id_farmaco),
    constraint Lotto_ibfk_2
        foreign key (id_farmacia) references Farmacia (id_farmacia)
);

create or replace index id_farmacia
    on Lotto (id_farmacia);

create or replace index id_farmaco
    on Lotto (id_farmaco);

set foreign_key_checks  = 1;