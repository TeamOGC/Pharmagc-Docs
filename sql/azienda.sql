set foreign_key_checks =0;
create or replace table Corriere
(
    id_corriere int auto_increment          not null
        primary key,
    nome        varchar(255) not null,
    cognome     varchar(255) not null,
    email       varchar(255) not null,
    password    varchar(255) not null
);

create or replace table Farmacia
(
    id_farmacia int auto_increment         not null
        primary key,
    nome        varchar(255) not null,
    indirizzo   varchar(255) not null
);

create or replace table Collo
(
    id_farmacia   int  not null,
    data_consegna date not null,
    primary key (id_farmacia, data_consegna),
    constraint Collo_ibfk_1
        foreign key (id_farmacia) references Farmacia (id_farmacia)
);

create or replace table Farmaco
(
    id_farmaco       int  auto_increment        not null
        primary key,
    nome             varchar(255) not null,
    principio_attivo varchar(255) not null,
    da_banco         tinyint(1)   not null
);

create or replace table Impiegato
(
    id_impiegato int  auto_increment         not null
        primary key,
    nome         varchar(255) not null,
    cognome      varchar(255) not null,
    email        varchar(255) not null,
    password     varchar(255) not null
);

create or replace table Lotto
(
    id_lotto           int auto_increment  not null
        primary key,
    id_farmaco         int  not null,
    data_scadenza      date not null,
    data_disponibilita date not null,
    quantita           int  not null,
    constraint Lotto_ibfk_1
        foreign key (id_farmaco) references Farmaco (id_farmaco)
);

create or replace index id_farmaco
    on Lotto (id_farmaco);

create or replace table Ordine
(
    id_ordine     int  auto_increment        not null
        primary key,
    id_farmaco    int          not null,
    id_farmacia   int          not null,
    data_consegna date         not null,
    quantita      int          not null,
    stato         varchar(255) not null,
    constraint Ordine_ibfk_1
        foreign key (id_farmaco) references Farmaco (id_farmaco),
    constraint Ordine_ibfk_2
        foreign key (id_farmacia) references Farmacia (id_farmacia)
);

create or replace table ComposizioneOrdine
(
    id_ordine int not null,
    id_lotto  int not null,
    quantita  int not null,
    primary key (id_ordine, id_lotto),
    constraint ComposizioneOrdine_ibfk_1
        foreign key (id_lotto) references Lotto (id_lotto),
    constraint ComposizioneOrdine_ibfk_2
        foreign key (id_ordine) references Ordine (id_ordine)
);

create or replace index id_lotto
    on ComposizioneOrdine (id_lotto);

create or replace index id_farmacia
    on Ordine (id_farmacia);

create or replace index id_farmaco
    on Ordine (id_farmaco);

create or replace table OrdinePeriodico
(
    id_farmacia int not null,
    id_farmaco  int not null,
    quantita    int not null,
    primary key (id_farmacia, id_farmaco),
    constraint OrdinePeriodico_ibfk_1
        foreign key (id_farmaco) references Farmaco (id_farmaco),
    constraint OrdinePeriodico_ibfk_2
        foreign key (id_farmacia) references Farmacia (id_farmacia)
);

create or replace index id_farmaco
    on OrdinePeriodico (id_farmaco);

create or replace table ProduzionePeriodica
(
    id_farmaco           int not null
        primary key,
    quantita             int not null,
    giorni_scadenza      int not null,
    giorni_disponibilita int not null,
    giorni_produzione    int not null,
    constraint ProduzionePeriodica_ibfk_1
        foreign key (id_farmaco) references Farmaco (id_farmaco)
);
set foreign_key_checks =1;