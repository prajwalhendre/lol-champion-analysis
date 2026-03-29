SELECT
	melee.era,
	(melee.avg_base_hp-  ranged.avg_base_hp) as hp_diff,
	(melee.avg_hp_per_level-ranged.avg_hp_per_level) as hp_per_level_diff,
	(melee.avg_base_armor-ranged.avg_base_armor) as base_armor_diff,
	(melee.avg_armor_per_level - ranged.avg_armor_per_level) as armor_per_level_diff, 
	(melee.avg_attack_dmg - ranged.avg_attack_dmg) as attack_dmg_diff,
	(melee.avg_attack_dmg_per_level - ranged.avg_attack_dmg_per_level) as attack_dmg_per_level_diff,
	(melee.avg_base_magic_resist-ranged.avg_base_magic_resist) as base_magic_resist_diff,
	(melee.avg_magic_resist_per_level-ranged.avg_magic_resist_per_level) as magic_resist_per_level_diff,
	(melee.avg_move_speed-ranged.avg_move_speed) as move_speed_diff,
	(melee.avg_attack_range-ranged.avg_attack_range) as attack_range_diff
from 
	(
		SELECT
			attack_type,
			case 
				when release_year between 2009 and 2011 then 'Launch'
				when release_year between 2012 and 2018 then 'Mid'
				else 'Modern' end as era,
			avg(hp) as avg_base_hp,
			avg(hp_per_level) as avg_hp_per_level,
			avg(armor) as avg_base_armor,
			avg(armor_per_level) as avg_armor_per_level, 
			avg(attack_damage) as avg_attack_dmg,
			avg(attack_damage_per_level) as avg_attack_dmg_per_level,
			avg(magic_resist) as avg_base_magic_resist,
			avg(magic_resist_per_level) as avg_magic_resist_per_level,
			avg(move_speed) as avg_move_speed,
			avg(attack_range) as avg_attack_range
		FROM
			champions
		where attack_type = 'MELEE'
		group by era
	) as melee
join 
		(
		SELECT
			attack_type,
			case 
				when release_year between 2009 and 2011 then 'Launch'
				when release_year between 2012 and 2018 then 'Mid'
				else 'Modern' end as era,
			avg(hp) as avg_base_hp,
			avg(hp_per_level) as avg_hp_per_level,
			avg(armor) as avg_base_armor,
			avg(armor_per_level) as avg_armor_per_level, 
			avg(attack_damage) as avg_attack_dmg,
			avg(attack_damage_per_level) as avg_attack_dmg_per_level,
			avg(magic_resist) as avg_base_magic_resist,
			avg(magic_resist_per_level) as avg_magic_resist_per_level,
			avg(move_speed) as avg_move_speed,
			avg(attack_range) as avg_attack_range
		FROM
			champions
		where attack_type = 'RANGED'
		group by era
		) as ranged on melee.era = ranged.era
group by
	melee.era;