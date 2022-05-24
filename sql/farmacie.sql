SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Farmaco`;
DROP TABLE IF EXISTS `Lotto`;
DROP TABLE IF EXISTS `Farmacia`;
DROP TABLE IF EXISTS `Farmacista`;
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
    `id_farmacia` INTEGER NOT NULL,
    `id_farmaco` INTEGER NOT NULL,
    `quantità` INTEGER NOT NULL,
    PRIMARY KEY (`id_lotto`, `id_farmacia`)
);

CREATE TABLE `Farmacia` (
    `id_farmacia` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `indirizzo` VARCHAR NOT NULL,
    PRIMARY KEY (`id_farmacia`)
);

CREATE TABLE `Farmacista` (
    `id_farmacista` INTEGER NOT NULL,
    `id_farmacia` INTEGER NOT NULL,
    `nome` VARCHAR NOT NULL,
    `cognome` VARCHAR NOT NULL,
    `email` VARCHAR NOT NULL,
    `password` VARCHAR NOT NULL,
    PRIMARY KEY (`id_farmacista`)
);

ALTER TABLE `Lotto` ADD FOREIGN KEY (`id_farmaco`) REFERENCES `Farmaco`(`id_farmaco`);
ALTER TABLE `Lotto` ADD FOREIGN KEY (`id_farmacia`) REFERENCES `Farmacia`(`id_farmacia`);
ALTER TABLE `Farmacista` ADD FOREIGN KEY (`id_farmacia`) REFERENCES `Farmacia`(`id_farmacia`);