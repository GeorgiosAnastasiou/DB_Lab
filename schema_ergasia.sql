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
  programma_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  dieuthinsi_programmatos VARCHAR(255) NOT NULL,
  onoma_programmatos VARCHAR(255) NOT NULL,
  PRIMARY KEY (programma_id)
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
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE etairia
(
  idia_kefalaia FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE er_kentro
(
  proypologimos_yp FLOAT NOT NULL,
  proypologismos_id FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE organismos_thlefwna
(
  thlefwna BIGINT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (thlefwna, syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ereunitis
(
  onoma VARCHAR(45) NOT NULL,
  epitheto VARCHAR(45) NOT NULL,
  fylo VARCHAR(1) NOT NULL,
  hmeromhnia_gennhshs DATE NOT NULL,
  hmeromhnia_ergasias DATE NOT NULL,
  ssn INT UNSIGNED NOT NULL AUTO_INCREMENT,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (ssn),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE aksiologisi
(
  bathmos FLOAT NOT NULL,
  hmeromhnia DATE NOT NULL,
  aksiologisi_id INT UNSIGNED NOT NULL UNIQUE AUTO_INCREMENT,
  ssn INT UNSIGNED NOT NULL,
  PRIMARY KEY (aksiologisi_id),
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn)  ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ergo
(
  ergo_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  titlos VARCHAR(255) NOT NULL,
  poso FLOAT NOT NULL,
  perilipsi VARCHAR(2550) NOT NULL,
  liksi DATE NOT NULL,
  enarksi DATE NOT NULL,
  stelexos_id INT UNSIGNED NOT NULL ,
  programma_id INT UNSIGNED NOT NULL,
  ssn INT UNSIGNED NOT NULL,
  -- aksiologeissn INT UNSIGNED NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  aksiologisi_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (ergo_id),
  FOREIGN KEY (stelexos_id) REFERENCES stelexos(stelexos_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (programma_id) REFERENCES programma(programma_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn) ON DELETE RESTRICT ON UPDATE CASCADE,
  -- FOREIGN KEY (aksiologeissn) REFERENCES ereunitis(ssn) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (aksiologisi_id) REFERENCES aksiologisi(aksiologisi_id) ON DELETE RESTRICT ON UPDATE CASCADE
   
);

CREATE TABLE paradoteo
(
  titlos_paradoteou VARCHAR(255) NOT NULL,
  perilipsi_paradoteou VARCHAR(2550) NOT NULL,
  hm_paradoshs DATE NOT NULL,
  ergo_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (titlos_paradoteou, ergo_id),
  FOREIGN KEY (ergo_id) REFERENCES ergo(ergo_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE epist_pediou_ergou
(
  onoma_epist_pediou VARCHAR(255) NOT NULL,
  ergo_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (onoma_epist_pediou, ergo_id),
  FOREIGN KEY (onoma_epist_pediou) REFERENCES epist_pedio(onoma_epist_pediou) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (ergo_id) REFERENCES ergo(ergo_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE ergazetai_se_ergo
(
  ergo_id INT UNSIGNED NOT NULL,
  ssn INT UNSIGNED NOT NULL,
  PRIMARY KEY (ergo_id, ssn),
  FOREIGN KEY (ergo_id) REFERENCES ergo(ergo_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (ssn) REFERENCES ereunitis(ssn) ON DELETE RESTRICT ON UPDATE CASCADE
);

