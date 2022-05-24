SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Farmaco`;
DROP TABLE IF EXISTS `Lotto`;
DROP TABLE IF EXISTS `Collo`;
DROP TABLE IF EXISTS `Ordine`;
DROP TABLE IF EXISTS `Farmacia`;
DROP TABLE IF EXISTS `ComposizioneOrdine`;
DROP TABLE IF EXISTS `ProduzionePeriodica`;
DROP TABLE IF EXISTS `OrdinePeriodico`;
DROP TABLE IF EXISTS `Impiegato`;
DROP TABLE IF EXISTS `Corriere`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Farmaco` (
    `id_farmaco` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `principio_attivo` VARCHAR NOT NULL,
    `da_banco` BOOLEAN NOT NULL,
    PRIMARY KEY (`id_farmaco`)
);

CREATE TABLE `Lotto` (
    `id_lotto` INTEGER NOT NULL,
    `id_farmaco` INTEGER NOT NULL,
    `data_scadenza` DATE NOT NULL,
    `data_disponibilità` DATE NOT NULL,
    `quantità` INTEGER NOT NULL,
    PRIMARY KEY (`id_lotto`)
);

CREATE TABLE `Collo` (
    `id_farmacia` INTEGER NOT NULL,
    `data_consegna` DATE NOT NULL,
    PRIMARY KEY (`id_farmacia`, `data_consegna`)
);

CREATE TABLE `Ordine` (
    `id_ordine` INTEGER NOT NULL,
    `id_farmaco` INTEGER NOT NULL,
    `id_farmacia` INTEGER NOT NULL,
    `data_consegna` DATE NOT NULL,
    `quantità` INTEGER NOT NULL,
    `stato` VARCHAR NOT NULL,
    PRIMARY KEY (`id_ordine`)
);

CREATE TABLE `Farmacia` (
    `id_farmacia` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `indirizzo` VARCHAR NOT NULL,
    PRIMARY KEY (`id_farmacia`)
);

CREATE TABLE `ComposizioneOrdine` (
    `id_ordine` INTEGER NOT NULL,
    `id_lotto` INTEGER NOT NULL,
    `quantità` INTEGER NOT NULL,
    PRIMARY KEY (`id_ordine`, `id_lotto`)
);

CREATE TABLE `ProduzionePeriodica` (
    `id_farmaco` INTEGER NOT NULL,
    `quantità` INTEGER NOT NULL,
    `giorni_scadenza` INTEGER NOT NULL,
    `giorni_disponibilità` INTEGER NOT NULL,
    `giorni_produzione` INTEGER NOT NULL,
    PRIMARY KEY (`id_farmaco`)
);

CREATE TABLE `OrdinePeriodico` (
    `id_farmacia` INTEGER NOT NULL,
    `id_farmaco` INTEGER NOT NULL,
    `quantità` INTEGER NOT NULL,
    PRIMARY KEY (`id_farmacia`, `id_farmaco`)
);

CREATE TABLE `Impiegato` (
    `id_impiegato` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `cognome` VARCHAR NOT NULL,
    `email` VARCHAR NOT NULL,
    `password` VARCHAR NOT NULL,
    PRIMARY KEY (`id_impiegato`)
);

CREATE TABLE `Corriere` (
    `id_corriere` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `cognome` VARCHAR NOT NULL,
    `email` VARCHAR NOT NULL,
    `password` VARCHAR NOT NULL,
    PRIMARY KEY (`id_corriere`)
);

ALTER TABLE `Lotto` ADD FOREIGN KEY (`id_farmaco`) REFERENCES `Farmaco`(`id_farmaco`);
ALTER TABLE `Collo` ADD FOREIGN KEY (`id_farmacia`) REFERENCES `Farmacia`(`id_farmacia`);
ALTER TABLE `Ordine` ADD FOREIGN KEY (`id_farmaco`) REFERENCES `Farmaco`(`id_farmaco`);
ALTER TABLE `Ordine` ADD FOREIGN KEY (`id_farmacia`) REFERENCES `Farmacia`(`id_farmacia`);
ALTER TABLE `ComposizioneOrdine` ADD FOREIGN KEY (`id_lotto`) REFERENCES `Lotto`(`id_lotto`);
ALTER TABLE `ComposizioneOrdine` ADD FOREIGN KEY (`id_ordine`) REFERENCES `Ordine`(`id_ordine`);
ALTER TABLE `ProduzionePeriodica` ADD FOREIGN KEY (`id_farmaco`) REFERENCES `Farmaco`(`id_farmaco`);
ALTER TABLE `OrdinePeriodico` ADD FOREIGN KEY (`id_farmaco`) REFERENCES `Farmaco`(`id_farmaco`);
ALTER TABLE `OrdinePeriodico` ADD FOREIGN KEY (`id_farmacia`) REFERENCES `Farmacia`(`id_farmacia`);