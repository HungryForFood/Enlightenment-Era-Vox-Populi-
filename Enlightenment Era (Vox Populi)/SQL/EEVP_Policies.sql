----------------------------------------------------
-- Enlightenment Era (Vox Populi)
-- POLICIES
-- 2018-02-01 Reworked by Infixo from EE & VP-EE mods
----------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------

UPDATE PolicyBranchTypes
SET EraPrereq = 'ERA_ENLIGHTENMENT'
WHERE Type IN ('POLICY_BRANCH_RATIONALISM', 'POLICY_BRANCH_EXPLORATION', 'POLICY_BRANCH_COMMERCE');

--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------

INSERT INTO Policy_BuildingClassYieldChanges (PolicyType, BuildingClassType, YieldType, YieldChange) VALUES
('POLICY_CREATIVE_EXPRESSION','BUILDINGCLASS_EE_GALLERY',  'YIELD_GOLDEN_AGE_POINTS', 2),
('POLICY_MOBILIZATION', 	  'BUILDINGCLASS_EE_BASTION',  'YIELD_SCIENCE', 3),
('POLICY_NAVAL_TRADITION',    'BUILDINGCLASS_EE_GUNSMITH', 'YIELD_SCIENCE', 2);

INSERT INTO Policy_BuildingClassCultureChanges (PolicyType, BuildingClassType, CultureChange) VALUES
('POLICY_CREATIVE_EXPRESSION', 'BUILDINGCLASS_EE_GALLERY',  2),
('POLICY_NAVAL_TRADITION',     'BUILDINGCLASS_EE_GUNSMITH', 1);

INSERT INTO Policy_BuildingClassYieldModifiers (PolicyType, BuildingClassType, YieldType, YieldMod) VALUES
('POLICY_MERCANTILISM',	'BUILDINGCLASS_EE_WEIGH_HOUSE',	'YIELD_SCIENCE', 3),
('POLICY_MERCANTILISM',	'BUILDINGCLASS_EE_WEIGH_HOUSE',	'YIELD_CULTURE', 3),
('POLICY_TRADE_UNIONS',	'BUILDINGCLASS_EE_CLOTH_MILL',	'YIELD_PRODUCTION', 3),
('POLICY_TRADE_UNIONS',	'BUILDINGCLASS_EE_CLOTH_MILL',	'YIELD_GOLD', 3);

-- Ceremony +1 Hap from National Wonders	
INSERT INTO Policy_BuildingClassHappiness (PolicyType, BuildingClassType, Happiness)
VALUES ('POLICY_LEGALISM', 'BUILDINGCLASS_EE_SUMMER_PALACE', 1);

-- Creative Expression (Freedom)
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Creative Expression[ENDCOLOR]: +2 [ICON_TOURISM] Tourism from Great Works. Museums, Galleries, Broadcast Towers, Opera Houses, and Amphitheaters gain +2 [ICON_GOLDEN_AGE] Golden Age Points and [ICON_CULTURE] Culture.'
WHERE Tag = 'TXT_KEY_POLICY_CREATIVE_EXPRESSION_HELP';

-- Military-Industrial Complex
-- TXT_KEY_POLICY_MOBILIZATION_HELP - no need to change, uses "Defense Buildings" phrase

-- Division of Labor
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Division of Labor[ENDCOLOR][NEWLINE]Forges, Windmills, Workshops, Cloth Mills, Factories, Train Stations, and Seaports generate +3% [ICON_PRODUCTION] Production and [ICON_GOLD] Gold each. [ICON_GOLD] Gold investments in Buildings reduce their [ICON_PRODUCTION] Production cost by an additional 10%.'
WHERE Tag = 'TXT_KEY_POLICY_TRADE_UNIONS_HELP';

-- Mercantilism (Industry)
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Mercantilism[ENDCOLOR][NEWLINE]Cities earn +10 [ICON_RESEARCH] Science when they construct Buildings, scaling with Era. Markets, Caravansaries, Customs Houses, Banks, Weigh Houses and Stock Exchanges generate +3% [ICON_RESEARCH] Science and [ICON_CULTURE] Culture each.'
WHERE Tag = 'TXT_KEY_POLICY_MERCANTILISM_HELP';

-- Colonialism (Naval Tradition)
UPDATE Language_en_US
SET Text = '[COLOR_POSITIVE_TEXT]Colonialism[ENDCOLOR][NEWLINE]+10% to sum of Yield and [ICON_GOLDEN_AGE] Golden Age duration modifiers from Global Monopolies; +3 to sum of Yields and [ICON_HAPPINESS_1] Happiness from Global Monopolies. Barracks, Armories, Gunsmiths, Military Academies, Forts, and Citadels provide +2 [ICON_RESEARCH] Science and +1 [ICON_CULTURE] Culture.'
WHERE Tag = 'TXT_KEY_POLICY_NAVAL_TRADITION_HELP';
