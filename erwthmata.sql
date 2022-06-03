-- 3.7
select st.onoma_stelexous, er.poso, o.onoma from etairia e inner join
organismos o on e.syntomografia = o.syntomografia inner join
ergo er on o.syntomografia = er.syntomografia inner join
stelexos st on st.stelexos_id = er.stelexos_id order by er.poso desc limit 5;

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

select count(*) from ergazetai_se_ergo; 