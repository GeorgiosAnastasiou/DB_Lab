-- 3.7
select st.onoma_stelexous, er.poso, o.onoma from etairia e inner join
organismos o on e.syntomografia = o.syntomografia inner join
ergo er on o.syntomografia = er.syntomografia inner join
stelexos st on st.stelexos_id = er.stelexos_id order by er.poso desc limit 5;

select count(*) from 
ereunitis er inner join
aksiologisi a on a.ssn = er.ssn inner join ergo e on e.aksiologisi_id = a.aksiologisi_id 
inner join organismos o on o.syntomografia = e.syntomografia
where er.syntomografia = o.syntomografia;

select ergo_id, onoma_epist_pediou from epist_pediou_ergou order by ergo_id;
