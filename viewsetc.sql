create index indx_poso on ergo (poso);
create index indx_enarksi on ergo(enarksi);
create index indx_liksi on ergo(liksi);



CREATE VIEW ereunitis_vw (ssn, onoma, epitheto, ergo_id, titlos) AS
SELECT e.ssn, e.onoma, e.epitheto, erg.ergo_id, erg.titlos from
ereunitis e inner join ergazetai_se_ergo erga on e.ssn = erga.ssn inner join
ergo erg on erga.ergo_id = erg.ergo_id order by e.ssn asc;

CREATE VIEW stelexos_vw (stelexos_id, onoma_stelexous, programma_id, onoma_programmatos) AS
SELECT s.stelexos_id, s.onoma_stelexous, p.programma_id, p.onoma_programmatos from
stelexos s inner join ergo e on e.stelexos_id = s.stelexos_id inner join
 programma p on e.programma_id = p.programma_id order by s.stelexos_id asc;

-- select * from ereunitis_vw;
-- select * from stelexos_vw;