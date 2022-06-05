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

CREATE TABLE panepistimio
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

CREATE TABLE ereunitiko_kentro
(
  proypologimos_yp FLOAT NOT NULL,
  proypologismos_id FLOAT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (syntomografia),
  FOREIGN KEY (syntomografia) REFERENCES organismos(syntomografia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE organismos_tilefwna
(
  tilefwna BIGINT NOT NULL,
  syntomografia VARCHAR(50) NOT NULL,
  PRIMARY KEY (tilefwna, syntomografia),
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
  CHECK(TIMESTAMPDIFF(DAY,enarksi,liksi) >= 366 AND TIMESTAMPDIFF(DAY,enarksi,liksi) <= 1464),
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
  FOREIGN KEY (aksiologisi_id) REFERENCES aksiologisi(aksiologisi_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CHECK (poso >= 100000 AND poso <= 1000000)
  
   
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

CREATE TABLE epist_pedio_ergou
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

DELIMITER //
CREATE TRIGGER ergo_trig BEFORE INSERT ON ergo 
FOR EACH ROW
BEGIN
    IF (new.syntomografia = (select e.syntomografia from ereunitis e inner join aksiologisi a on a.ssn=e.ssn where a.aksiologisi_id = new.aksiologisi_id)) then 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: O ereunitis pou aksiologei to ergo den prepei na anhkei ston organismo pou to ylopoiei';
    END IF;
    
    IF ((select syntomografia from ereunitis where ssn=new.ssn) <> new.syntomografia) then 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: O ypeuthinos prepei na anhkei ston organismo pou ylopoiei to ergo';
    END IF;
END//  




DELIMITER //
CREATE TRIGGER ergazetai_se_ergo_trig BEFORE INSERT ON ergazetai_se_ergo 
FOR EACH ROW
BEGIN
    if ((select syntomografia from ereunitis where ssn=new.ssn) <>(select syntomografia from ergo where ergo_id=new.ergo_id)) then 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: O ereunitis prepei na anhkei ston organismo pou ylopoiei to ergo';
   end if;
END//
DELIMITER ;



DELIMITER //
CREATE TRIGGER paradoteo_trig BEFORE INSERT ON paradoteo 
FOR EACH ROW
BEGIN
    if (new.ergo_id not in (select ergo_id from ergo e where new.hm_paradoshs between e.enarksi and e.liksi)) then
    SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'check constraint on Work_To_Be_Submitted failed - Submission date must be between start and end date of project.';
    END IF;
END//   
DELIMITER ; 


DELIMITER //
CREATE TRIGGER up_paradoteo_trig BEFORE UPDATE ON paradoteo 
FOR EACH ROW
BEGIN
    if (new.ergo_id not in (select ergo_id from ergo e where new.hm_paradoshs between e.enarksi and e.liksi)) then
    SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'check constraint on Work_To_Be_Submitted failed - Submission date must be between start and end date of project.';
    END IF;
END//   
DELIMITER ; 

DELIMITER //
CREATE TRIGGER ergo_update_trig BEFORE UPDATE ON ergo
FOR EACH ROW
BEGIN
    if (new.syntomografia <> old.syntomografia) then 
		if ((select count(*) FROM ergazetai_se_ergo where ergo_id = old.ergo_id ) > 0) then
			SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'Error: Ergazontai akoma ereunites panw se auto to ergo.';
	   end if;
    end if;
END//
DELIMITER ;   

DELIMITER //

CREATE TRIGGER ereun_update_trig BEFORE UPDATE ON ereunitis
FOR EACH ROW
BEGIN
    if (new.syntomografia <> old.syntomografia) then 
		if ((select count(*) FROM ergazetai_se_ergo where ssn = old.snn) > 0) then
			SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'Ergazetai akoma se ena h perissotera erga';
	   end if;
    end if;
END//  

DELIMITER ;



