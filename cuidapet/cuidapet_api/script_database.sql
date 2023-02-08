set FOREIGN_KEY_CHECKS = 0 ;

create database cuidapet_db;
use cuidapet_db;

CREATE TABLE IF NOT EXISTS `categorias_fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(45) NULL,
  `tipo_categoria` char(1) default 'P',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `fornecedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NULL,
  `logo` TEXT NULL,
  `endereco` VARCHAR(100) NULL,
  `telefone` VARCHAR(45) NULL,
  `latlng` POINT NULL,
  `categorias_fornecedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fornecedor_categorias_fornecedor1_idx` (`categorias_fornecedor_id` ASC),
  CONSTRAINT `fk_fornecedor_categorias_fornecedor1`
    FOREIGN KEY (`categorias_fornecedor_id`)
    REFERENCES `categorias_fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `senha` TEXT NULL DEFAULT NULL,
  `tipo_cadastro` ENUM('FACEBOOK', 'GOOGLE', 'APPLE', 'APP') NOT NULL,
  `ios_token` TEXT NULL DEFAULT NULL,
  `android_token` TEXT NULL DEFAULT NULL,
  `refresh_token` TEXT NULL DEFAULT NULL,
  `img_avatar` TEXT NULL DEFAULT NULL,
  `social_id` TEXT NULL DEFAULT NULL,
  `fornecedor_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_usuario_fornecedor_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_usuario_fornecedor`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `fornecedor_servicos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fornecedor_id` INT NOT NULL,
  `nome_servico` VARCHAR(200) NULL,
  `valor_servico` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fornecedor_servicos_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_fornecedor_servicos_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `agendamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_agendamento` DATETIME NULL,
  `usuario_id` INT NOT NULL,
  `fornecedor_id` INT NOT NULL,
  `status` CHAR(2) NOT NULL DEFAULT 'P' COMMENT 'P=Pendente\nCN=Confirmada\nF=Finalizado\nC=Cancelado',
  nome varchar(200) null,
	nome_pet varchar(200) null,
  PRIMARY KEY (`id`),
  INDEX `fk_solicitacao_usuario1_idx` (`usuario_id` ASC),
  INDEX `fk_solicitacao_fornecedor1_idx` (`fornecedor_id` ASC),
  CONSTRAINT `fk_solicitacao_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitacao_fornecedor1`
    FOREIGN KEY (`fornecedor_id`)
    REFERENCES `fornecedor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `agendamento_servicos` (
  `agendamento_id` INT NOT NULL,
  `fornecedor_servicos_id` INT NOT NULL,
  INDEX `fk_agenda_servicos_agendamento1_idx` (`agendamento_id` ASC),
  INDEX `fk_agenda_servicos_fornecedor_servicos1_idx` (`fornecedor_servicos_id` ASC),
  CONSTRAINT `fk_agenda_servicos_agendamento1`
    FOREIGN KEY (`agendamento_id`)
    REFERENCES `agendamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_agenda_servicos_fornecedor_servicos1`
    FOREIGN KEY (`fornecedor_servicos_id`)
    REFERENCES `fornecedor_servicos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `chats` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `agendamento_id` INT NOT NULL,
  `status` CHAR(1) NULL DEFAULT 'A',
  `data_criacao` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_chats_agendamento1_idx` (`agendamento_id` ASC),
  CONSTRAINT `fk_chats_agendamento1`
    FOREIGN KEY (`agendamento_id`)
    REFERENCES `agendamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO categorias_fornecedor (id, nome_categoria, tipo_categoria) VALUES (1, 'Petshop', 'P');
INSERT INTO categorias_fornecedor (id, nome_categoria, tipo_categoria) VALUES (2, 'Veterinária', 'V');
INSERT INTO categorias_fornecedor (id, nome_categoria, tipo_categoria) VALUES (3, 'Pet Center', 'C');

ALTER TABLE `usuario`
ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC);


INSERT INTO `fornecedor` VALUES
(null,'CLINICA  JARDIM','https://picsum.photos/seed/0.8414244473366295/300','Rua Dunquerque','11222222222',0x000000000101000000871D215E32A137C0EAF4728EF03F47C0,1),
(null,'CLINICA VETERINARIA ATILIO','https://picsum.photos/seed/0.24412205558654113/300','Rua Professor Atilio Innocenti','11222222222',0x000000000101000000D9DAB1C7FA9637C02FD2D567185747C0,1),
(null,'VETERINARIA FRADIQUE','https://picsum.photos/seed/0.06549930671742121/300','Rua Fradique Coutinho','11222222222',0x000000000101000000DAA3DC22D58E37C09C5C42F45A5847C0,1),
(null,'VETERINARIA CENTRAL','https://picsum.photos/seed/0.04738860395493787/300','Praça dos Omaguás','11222222222',0x000000000101000000D65AF33EE98F37C0EE6CD96B8B5847C0,2),
(null,'CLINICA VETERINARIA FARIA LIMA','https://picsum.photos/seed/0.3108899912898336/300','Av Faria Lima','11222222222',0x000000000101000000EB1D6E87869537C0C1C018366F5747C0,1),
(null,'VET BERRINI','https://picsum.photos/seed/0.48041267551520156/300','Rua Kansas','11222222222',0x00000000010100000065D93807749937C0707DB328475847C0,2),
(null,'CLINICA CENTRAL ABC','https://picsum.photos/seed/0.3298311897831328/300','Rua Antônio Cubas','11222222222',0x000000000101000000607DF266C3A837C008A23891AA4547C0,1),
(null,'CLINICA MATRIZ','https://picsum.photos/seed/0.9430788028455142/300','Av Juscelino Kubitscheck','11222222222',0x000000000101000000D6E3BED53A9737C084A867E66E5747C0,1),
(null,'CLINICA PADRE ANTONIO','https://picsum.photos/seed/0.9500168226193794/300','Avenida Padre Antônio José dos Santos','11222222222',0x0000000001010000009B81DB24509C37C08FEA2A93D05747C0,3),

(null,'PET CENTER CENTRAL','https://picsum.photos/seed/0.5626106807613844/300','RUA JOAQUIM TAVORA','11222222222',0x00000000010100000020578FA09D9637C092448A5CCB5247C0,3),
(null,'PET CENTER PRAÇA','https://picsum.photos/seed/0.13945180749469605/300','Rua Ministro Jesuíno Cardoso','11222222222',0x0000000001010000004F0BB9AD889737C010BBA58B035747C0,1),
(null,'HOTEL E VET SALVA LUZ','https://picsum.photos/seed/0.5860884921495696/300','AV ENG EUSEBIO STEVAUX','11222222222',0x0000000001010000004148163081AB37C020949CB8C15947C0,1),
(null,'PETCATE AUAU-MIAU','https://picsum.photos/seed/0.880615359992362/300','AV HORACIO LAFER','11222222222',0x000000000101000000AC1919E42E9637C057050F78055747C0,1),
(null,'PETCENTER ANIMAIS LUZ','https://picsum.photos/seed/0.45689568711155626/300','Rua Ribeiro do Vale','11222222222',0x000000000101000000EFFC474B8A9C37C0A2670EA4E65747C0,1),
(null,'CLINICA TUCUNARE - PRAÇA 2','https://picsum.photos/seed/0.7554800917911157/300','Avenida Tucunar&eacute;','11222222222',0x000000000101000000C3ABF6FAA47E37C0A9F4B814FC6A47C0,1),
(null,'VET BALDERI','https://picsum.photos/seed/0.1813100512896758/300','Rua Doutor Renato Paes de Barros','11222222222',0x000000000101000000B53E9B0B129537C044820420495647C0,1),
(null,'Hospital 24h Dr. Bacci','https://picsum.photos/seed/0.572463037979289/300','Avenida Governador Julio Jose de Campos','11222222222',0x000000000101000000C75DCEB6E47830C0ECF1E780C94B4BC0,1),
(null,'VETERINARIA PETMANIA 2','https://picsum.photos/seed/0.24500753660221355/300','Rua Caldas Novas','11222222222',0x0000000001010000000B94B99E8D8137C0555458045A6F47C0,2),
(null,'HOSPITAL VETERINARIO LUZ','https://picsum.photos/seed/0.5029761302312614/300','Rua Gomes de Carvalho','11222222222',0x0000000001010000003D258C0BAC9837C09DA85B2CFB5747C0,1),
(null,'VETERINARIA SALVAÇÃO','https://picsum.photos/seed/0.3514789215768491/300','Avenida Europa','11222222222',0x0000000001010000003703B749A09237C05FF4705D8C5647C0,1),
(null,'PETSHOP CALFAT','https://picsum.photos/seed/0.15131461448158567/300','Rua Comendador Miguel Calfat','11222222222',0x000000000101000000AC76A801DE9737C04489963C9E5647C0,3),
(null,'VET RELIQUIA CENTRO','https://picsum.photos/seed/0.7116676575612907/300','Rua Relíquia','11222222222',0x000000000101000000A94E07B29E8237C0821C4AA3B85447C0,1),
(null,'PETSHOP ANIMAMUNDI','https://picsum.photos/seed/0.15985423993305697/300','Avenida Paulo Faccini','11222222222',0x0000000001010000002DF5E27ACA7437C08E0B62FB244447C0,3),
(null,'HOTEL E VET AU AU','https://picsum.photos/seed/0.6322219172792714/300','Rua Tolentino Filgueiras','11222222222',0x000000000101000000CA4862EEFFF637C0C113C48A642A47C0,1);


INSERT INTO usuario(id,email,senha,tipo_cadastro,ios_token,android_token,refresh_token,img_avatar, fornecedor_id) VALUES
(null,'clinicajardim@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.8414244473366295/300',1),
(null,'clinicaveterinariaatilio@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.24412205558654113/300',2),
(null,'veterinariafradique@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.06549930671742121/300',3),
(null,'veterinariacentral@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.04738860395493787/300',4),
(null,'clinicaveterinariafarialima@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.3108899912898336/300',5),
(null,'vetberrini@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.48041267551520156/300',6),
(null,'clinicacentralabc@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.3298311897831328/300',7),
(null,'clinicamatriz@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.9430788028455142/300',8),
(null,'clinicapadreantonio@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.9500168226193794/300',9),
(null,'petcentercentral@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.5626106807613844/300',10),
(null,'petcenterpraça@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.13945180749469605/300',11),
(null,'hotelevetsalvaluz@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.5860884921495696/300',12),
(null,'petcateauau-miau@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.880615359992362/300',13),
(null,'petcenteranimaisluz@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.45689568711155626/300',14),
(null,'clinicatucunare-praça2@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.7554800917911157/300',15),
(null,'vetbalderi@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.1813100512896758/300',16),
(null,'hospital24hdr.bacci@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.572463037979289/300',17),
(null,'veterinariapetmania2@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.24500753660221355/300',18),
(null,'hospitalveterinarioluz@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.5029761302312614/300',19),
(null,'veterinariasalvação@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.3514789215768491/300',20),
(null,'petshopcalfat@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.15131461448158567/300',21),
(null,'vetreliquiacentro@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.7116676575612907/300',22),
(null,'petshopanimamundi@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.15985423993305697/300',23),
(null,'hotelevetauau@gmail.com','96cae35ce8a9b0244178bf28e4966c2ce1b8385723a96a6b838858cdd6ca0a1e','APP',null,null,null,'https://picsum.photos/seed/0.6322219172792714/300',24);

 Insert into fornecedor_servicos VALUES
 (null,1,'HOTEL','45.00'),
 (null,1,'PETCARE','22.00'),
 (null,1,'VETERINARIO','59.00'),
 (null,2,'BANHO','23.00'),
 (null,2,'TOSA','30.00'),
 (null,2,'VETERINARIO','44.00'),
 (null,3,'TOSA','16.00'),
 (null,3,'PETCARE','35.00'),
 (null,3,'VETERINARIO','58.00'),
 (null,4,'HOTEL','53.00'),
 (null,4,'PETCARE','15.00'),
 (null,4,'VETERINARIO','24.00'),
 (null,5,'TOSA','21.00'),
 (null,5,'HOTEL','49.00'),
 (null,5,'PETCARE','57.00'),
 (null,6,'BANHO','59.00'),
 (null,6,'TOSA','13.00'),
 (null,6,'VETERINARIO','20.00'),
 (null,7,'BANHO','10.00'),
 (null,7,'HOTEL','55.00'),
 (null,7,'VETERINARIO','22.00'),
 (null,8,'BANHO','30.00'),
 (null,8,'HOTEL','20.00'),
 (null,8,'PETCARE','48.00'),
 (null,11,'TOSA','45.00'),
 (null,11,'PETCARE','40.00'),
 (null,11,'VETERINARIO','54.00'),
 (null,12,'BANHO','15.00'),
 (null,12,'HOTEL','55.00'),
 (null,12,'VETERINARIO','60.00'),
 (null,13,'BANHO','26.00'),
 (null,13,'TOSA','28.00'),
 (null,13,'PETCARE','35.00'),
 (null,14,'BANHO','23.00'),
 (null,14,'HOTEL','15.00'),
 (null,14,'VETERINARIO','29.00'),
 (null,15,'BANHO','46.00'),
 (null,15,'TOSA','22.00'),
 (null,15,'VETERINARIO','26.00'),
 (null,16,'HOTEL','58.00'),
 (null,16,'PETCARE','17.00'),
 (null,16,'VETERINARIO','49.00'),
 (null,17,'TOSA','22.00'),
 (null,17,'PETCARE','33.00'),
 (null,17,'VETERINARIO','48.00'),
 (null,18,'BANHO','31.00'),
 (null,18,'HOTEL','55.00'),
 (null,18,'VETERINARIO','48.00'),
 (null,19,'TOSA','58.00'),
 (null,19,'HOTEL','14.00'),
 (null,19,'PETCARE','17.00'),
 (null,20,'BANHO','55.00'),
 (null,20,'TOSA','15.00'),
 (null,20,'HOTEL','16.00'),
 (null,22,'TOSA','20.00'),
 (null,22,'HOTEL','40.00'),
 (null,22,'VETERINARIO','15.00'),
 (null,24,'BANHO','11.00'),
 (null,24,'TOSA','38.00'),
 (null,24,'HOTEL','51.00'),
 (null,9,'TOSA','51.00'),
 (null,9,'HOTEL','35.00'),
 (null,9,'PETCARE','10.00'),
 (null,10,'BANHO','45.00'),
 (null,10,'HOTEL','37.00'),
 (null,10,'PETCARE','32.00'),
 (null,21,'TOSA','29.00'),
 (null,21,'PETCARE','30.00'),
 (null,21,'VETERINARIO','47.00'),
 (null,23,'BANHO','28.00'),
 (null,23,'TOSA','32.00'),
 (null,23,'HOTEL','42.00');