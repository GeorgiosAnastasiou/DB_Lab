-- 3.5
select a.onoma_epist_pediou, b.onoma_epist_pediou from 
epist_pediou_ergou a inner join epist_pediou_ergou b where a.ergo_id = b.ergo_id and a.onoma_epist_pediou < b.onoma_epist_pediou 
group by a.onoma_epist_pediou, b.onoma_epist_pediou order by count(*) desc limit 3;


-- 3.6
select e.ssn, e.onoma, e.epitheto , count(*) from
ereunitis e inner join ergazetai_se_ergo erga on e.ssn = erga.ssn where TIMESTAMPDIFF(YEAR, e.hmeromhnia_gennhshs, CURDATE())<40
group by e.ssn order by count(*) desc limit 3;

-- 3.7
select st.onoma_stelexous, er.poso, o.onoma from etairia e inner join
organismos o on e.syntomografia = o.syntomografia inner join
ergo er on o.syntomografia = er.syntomografia inner join
stelexos st on st.stelexos_id = er.stelexos_id group by st.onoma_stelexous order by er.poso desc limit 5;

-- 3.8
select ssn, onoma, epitheto, count(*)  from ereunitis_vw where ergo_id not in 
(select ergo_id from paradoteo) group by ssn having count(*)>4 ;


-- check an o ypeythynos anhkei sto dynamiko tou organismou
select  a.aksiologisi_id from 
ereunitis er inner join
aksiologisi a on a.ssn = er.ssn inner join ergo e on e.aksiologisi_id = a.aksiologisi_id 
inner join organismos o on o.syntomografia = e.syntomografia
where er.syntomografia = o.syntomografia;

select count(*) from 
ereunitis er inner join ergo e on er.ssn = e.ssn 
inner join organismos o on o.syntomografia = e.syntomografia
where er.syntomografia = o.syntomografia;

select  count(e.ssn) from ereunitis e
inner join ergo erg on e.syntomografia = erg.syntomografia  where e.ssn>60 order by e.ssn;

select ergo_id, count(*) from epist_pediou_ergou group by ergo_id having count(*)>1;

select count(*) from 
ereunitis er inner join ergazetai_se_ergo erg on er.ssn = erg.ssn 
inner join ergo e on e.ergo_id = erg.ergo_id
where er.syntomografia = e.syntomografia;

select * from ergazetai_se_ergo order by ssn; 