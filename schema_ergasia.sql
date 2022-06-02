CREATE TABLE epist_pedio
(
  onoma_epist_pediou VARCHAR(255) NOT NULL,
  PRIMARY KEY (onoma_epist_pediou)
);

CREATE TABLE stelexos
(
  onoma_stelexous VARCHAR(255) NOT NULL,
  stelexos_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (stelexos_id)
);

CREATE TABLE programma
(
  dieuthinsi_programmatos VARCHAR(255) NOT NULL,
  onoma_programmatos VARCHAR(255) NOT NULL,
  PRIMARY KEY (onoma_programmatos)
);

CREATE TABLE organismos
(
  syntomografia VARCHAR(50) NOT NULL,
  onoma VARCHAR(255) NOT NULL,
  odos VARCHAR(255) NOT NULL,
  tk INT NOT NULL,
  polh VARCHAR(255) NOT NULL,
  PRIMARY KEY (syntomografia)
);

CREATE TABLE panephstimio
(
  proypologismos_yp FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia)
);

CREATE TABLE etairia
(
  idia_kefalaia FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia)
);

CREATE TABLE er_kentro
(
  proypologimos_yp FLOAT NOT NULL,
  proypologismos_id FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia)
);

CREATE TABLE organismos_thlefwna
(
  thlefwna INT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (thlefwna, syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia)
);

CREATE TABLE ereunitis
(
  onoma VARCHAR(45) NOT NULL,
  epitheto VARCHAR(45) NOT NULL,
  fylo INT NOT NULL,
  hmeromhnia_gennhshs DATE NOT NULL,
  ssn INT UNSIGNED NOT NULL AUTO_INCREMENT,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (ssn),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia)
);

CREATE TABLE aksiologisi
(
  bathmos FLOAT NOT NULL,
  hmeromhnia DATE NOT NULL,
  aksiologisi_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  ssn INT UNSIGNED NOT NULL,
  PRIMARY KEY (aksiologisi_id),
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn)
);

CREATE TABLE ergo
(
  titlos VARCHAR(255) NOT NULL,
  poso FLOAT NOT NULL,
  perilipsi VARCHAR(2550) NOT NULL,
  liksi DATE NOT NULL,
  enarksi DATE NOT NULL,
  stelexos_id INT UNSIGNED NOT NULL ,
  onoma_programmatos VARCHAR(255) NOT NULL,
  ssn INT UNSIGNED NOT NULL,
  aksiologeissn INT UNSIGNED NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  aksiologisi_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (titlos),
  FOREIGN KEY (stelexos_id) REFERENCES stelexos(stelexos_id),
  FOREIGN KEY (onoma_programmatos) REFERENCES programma(onoma_programmatos),
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn),
  FOREIGN KEY (aksiologeissn) REFERENCES ereunitis(ssn),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia),
  FOREIGN KEY (aksiologisi_id) REFERENCES aksiologisi(aksiologisi_id)
   
);

CREATE TABLE paradoteo
(
  titlos_paradoteou VARCHAR(255) NOT NULL,
  perilipsi_paradoteou VARCHAR(2550) NOT NULL,
  titlos VARCHAR(255) NOT NULL,
  PRIMARY KEY (titlos_paradoteou, titlos),
  FOREIGN KEY (titlos) REFERENCES ergo(titlos)
);

CREATE TABLE epist_pediou_ergou
(
  onoma_epist_pediou VARCHAR(255) NOT NULL,
  titlos VARCHAR(255) NOT NULL,
  PRIMARY KEY (onoma_epist_pediou, titlos),
  FOREIGN KEY (onoma_epist_pediou) REFERENCES epist_pedio(onoma_epist_pediou),
  FOREIGN KEY (titlos) REFERENCES ergo(titlos)
);

CREATE TABLE ergazetai_se_ergo
(
  titlos VARCHAR(255) NOT NULL,
  ssn INT UNSIGNED NOT NULL,
  PRIMARY KEY (titlos, ssn),
  FOREIGN KEY (titlos) REFERENCES ergo(titlos),
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn)
);