select 
	CASE	
		when release_year between 2009 and 2011 then 'Launch'
		when release_year between 2012 and 2018 then 'Mid'
		else 'Modern' end as era,
	r.role,
	count(c.id) as class_count
from 
	champions c
join 
	champion_roles r on c.id = r.champion_id
where r.role in ('FIGHTER', 'MAGE', 'ASSASSIN', 'SUPPORT', 'TANK', 'MARKSMAN')
group by
	role, era;