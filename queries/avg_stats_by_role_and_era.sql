SELECT
	(case 
		when c.release_year between 2009 and 2011 then 'Launch'
		when c.release_year between 2012 and 2018 then 'Mid'
		else 'Modern' END) as era,
	r.role,
	count(c.id) as champions_released,
	avg(c.hp) as avg_base_hp,
	avg(c.hp_per_level) as avg_hp_per_level,
	avg(c.attack_damage) as avg_base_attack_dmg,
	avg(c.attack_damage_per_level) as avg_attack_dmg_per_level,
	avg(c.magic_resist) as avg_base_magic_resist,
	avg(c.magic_resist_per_level) as avg_magic_resist_per_level,
	avg(c.move_speed) as avg_move_speed,
	avg(c.attack_range) as avg_attack_range
from 
	champions c
JOIN
	champion_roles r on c.id = r.champion_id
group by 
	r.role, era