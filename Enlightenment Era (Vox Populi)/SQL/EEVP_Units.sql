----------------------------------------------------
-- Enlightenment Era (Vox Populi)
-- UNITS
-- 2018-02-01 Reworked by Infixo from EE & VP-EE mods
----------------------------------------------------

----------------------------------------------------
-- Generic info
-- UNIT_EE_SKIRMISHER is Light Infantry
----------------------------------------------------

INSERT INTO Units (Type, PrereqTech, Combat, Moves, RequiresFaithPurchaseEnabled, ObsoleteTech, CombatClass, Domain, DefaultUnitAI, AdvancedStartCost, UnitFlagIconOffset, PortraitIndex, GoodyHutUpgradeUnitClass) VALUES
('UNIT_EE_ADVENTURER',    'TECH_EE_EXPLORATION',  23, 3, 1,'TECH_STEAM_POWER',    'UNITCOMBAT_RECON',       'DOMAIN_LAND','UNITAI_EXPLORE',     10, 6, 6,'UNITCLASS_ZEPPELIN'), -- UNIT_EE_EXPLORER in original EE
('UNIT_EE_FIELD_GUN',     'TECH_EE_FLINTLOCK',    21, 2, 1,'TECH_RIFLING',        'UNITCOMBAT_SIEGE',       'DOMAIN_LAND','UNITAI_CITY_BOMBARD',30, 4, 4,'UNITCLASS_FIELD_GUN'),
('UNIT_EE_LINE_INFANTRY', 'TECH_EE_FLINTLOCK',    30, 2, 1,'TECH_RIFLING',        'UNITCOMBAT_GUN',         'DOMAIN_LAND','UNITAI_DEFENSE',     30, 1, 1,'UNITCLASS_RIFLEMAN'),
('UNIT_EE_SKIRMISHER',    'TECH_EE_FORTIFICATION',25, 2, 1,'TECH_DYNAMITE',       'UNITCOMBAT_ARCHER',      'DOMAIN_LAND','UNITAI_RANGED',      30, 2, 2,'UNITCLASS_GATLINGGUN'),
('UNIT_EE_UHLAN',         'TECH_RIFLING',         45, 4, 1,'TECH_COMBUSTION',     'UNITCOMBAT_MOUNTED',     'DOMAIN_LAND','UNITAI_FAST_ATTACK', 30, 3, 3,'UNITCLASS_WWI_TANK'),
('UNIT_EE_CARRACK',       'TECH_ASTRONOMY',       32, 5, 0,'TECH_NAVIGATION',     'UNITCOMBAT_NAVALMELEE',  'DOMAIN_SEA', 'UNITAI_ATTACK_SEA',  50, 9,19,'UNITCLASS_PRIVATEER'),
('UNIT_EE_GALLEON',       'TECH_EE_EXPLORATION',  20, 4, 0,'TECH_EE_WARSHIPS',    'UNITCOMBAT_NAVALRANGED', 'DOMAIN_SEA', 'UNITAI_ASSAULT_SEA', 50, 5, 5,'UNITCLASS_FRIGATE'),
('UNIT_EE_SHIP_OF_THE_LINE','TECH_EE_WARSHIPS',   45, 5, 0,'TECH_INDUSTRIALIZATION','UNITCOMBAT_NAVALMELEE','DOMAIN_SEA', 'UNITAI_ASSAULT_SEA', 50, 8, 9,'UNITCLASS_IRONCLAD');

UPDATE Units
SET Class = 'UNITCLASS_'||SUBSTR(Type,6), Description = 'TXT_KEY_'||Type,
	Civilopedia = 'TXT_KEY_'||Type||'_PEDIA', Strategy = 'TXT_KEY_'||Type||'_STRATEGY', Help = 'TXT_KEY_'||Type||'_HELP',
	MilitarySupport = 1, Pillage = 1, MilitaryProduction = 1, XPValueAttack = 3, XPValueDefense = 3, PurchaseCooldown = 1,
	UnitArtInfo = 'ART_DEF_'||Type, UnitFlagAtlas = 'ENLIGHTENMENT_UNIT_FLAG_ATLAS', IconAtlas = 'ENLIGHTENMENT_UNIT_ATLAS'
WHERE Type IN (
'UNIT_EE_ADVENTURER',
'UNIT_EE_FIELD_GUN',
'UNIT_EE_LINE_INFANTRY',
'UNIT_EE_SKIRMISHER',
'UNIT_EE_UHLAN',
'UNIT_EE_CARRACK',
'UNIT_EE_GALLEON',
'UNIT_EE_SHIP_OF_THE_LINE');

-- Exceptions
UPDATE Units SET Civilopedia = 'TXT_KEY_CIVILOPEDIA_UNITS_RENAISSANCE_SHIPOFTHELINE_TEXT' WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE';
UPDATE Units SET UnitArtInfo = 'ART_DEF_UNIT_U_SPANISH_GALLEON' WHERE Type = 'UNIT_EE_GALLEON';
UPDATE Units SET UnitArtInfo = 'ART_DEF_UNIT_EE_EXPLORER' WHERE Type = 'UNIT_EE_ADVENTURER'; -- model has still an old name
UPDATE Units SET IconAtlas   = 'UNIT_ATLAS_2' WHERE Type = 'UNIT_EE_CARRACK' OR Type = 'UNIT_EE_SHIP_OF_THE_LINE';

-- Ships
UPDATE Units
SET MoveRate = 'WOODEN_BOAT', HurryCostModifier = 20, Mechanized = 1, MinAreaSize = 10
WHERE Type IN (
'UNIT_EE_CARRACK',
'UNIT_EE_GALLEON',
'UNIT_EE_SHIP_OF_THE_LINE');

INSERT INTO UnitClasses (Type, DefaultUnit, Description)
SELECT 'UNITCLASS_'||SUBSTR(Type,6), Type, 'TXT_KEY_'||Type
FROM Units
WHERE Type IN (
'UNIT_EE_ADVENTURER',
'UNIT_EE_FIELD_GUN',
'UNIT_EE_LINE_INFANTRY',
'UNIT_EE_SKIRMISHER',
'UNIT_EE_UHLAN',
'UNIT_EE_CARRACK',
'UNIT_EE_GALLEON',
'UNIT_EE_SHIP_OF_THE_LINE');

----------------------------------------------------
-- Unit Lines - auto based on GoodyHutUpgradeUnitClass
----------------------------------------------------

INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
SELECT Type, GoodyHutUpgradeUnitClass
FROM Units
WHERE Type IN (
'UNIT_EE_ADVENTURER',
'UNIT_EE_FIELD_GUN',
'UNIT_EE_LINE_INFANTRY',
'UNIT_EE_SKIRMISHER',
'UNIT_EE_UHLAN',
'UNIT_EE_CARRACK',
'UNIT_EE_GALLEON',
'UNIT_EE_SHIP_OF_THE_LINE');

-- Version 1.2 updates for existing units related to additonal era (courtesy of adan_eslavo)
UPDATE Units Set ObsoleteTech = 'TECH_BALLISTICS' WHERE Type = 'UNIT_AUSTRIAN_HUSSAR';
UPDATE Units Set ObsoleteTech = 'TECH_BALLISTICS' WHERE Type = 'UNIT_INDIAN_WARELEPHANT';
UPDATE Units Set GoodyHutUpgradeUnitClass = 'UNITCLASS_2HANDER' WHERE Type = 'UNIT_DANISH_BERSERKER';
UPDATE Units Set ObsoleteTech = 'TECH_EE_FLINTLOCK' WHERE Type = 'UNIT_DANISH_BERSERKER';
UPDATE Units Set GoodyHutUpgradeUnitClass = 'UNITCLASS_2HANDER' WHERE Type = 'UNIT_JAPANESE_SAMURAI';
UPDATE Units Set ObsoleteTech = 'TECH_EE_FLINTLOCK' WHERE Type = 'UNIT_JAPANESE_SAMURAI';
UPDATE Units Set GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_SKIRMISHER' WHERE Type = 'UNIT_OTTOMAN_JANISSARY';
UPDATE Units Set ObsoleteTech = 'TECH_DYNAMITE' WHERE Type = 'UNIT_OTTOMAN_JANISSARY';

----------------------------------------------------
-- Unit AI
----------------------------------------------------

INSERT INTO Unit_AITypes (UnitType, UnitAIType) VALUES
('UNIT_EE_ADVENTURER','UNITAI_EXPLORE'),
('UNIT_EE_FIELD_GUN', 'UNITAI_CITY_BOMBARD'),
('UNIT_EE_FIELD_GUN', 'UNITAI_RANGED'),
('UNIT_EE_LINE_INFANTRY', 'UNITAI_ATTACK'),
('UNIT_EE_LINE_INFANTRY', 'UNITAI_DEFENSE'),
('UNIT_EE_LINE_INFANTRY', 'UNITAI_EXPLORE'),
('UNIT_EE_SKIRMISHER', 'UNITAI_RANGED'),
('UNIT_EE_UHLAN',    'UNITAI_DEFENSE'),
('UNIT_EE_UHLAN',    'UNITAI_FAST_ATTACK'),
('UNIT_EE_CARRACK',  'UNITAI_ATTACK_SEA'),
('UNIT_EE_CARRACK',  'UNITAI_RESERVE_SEA'),
('UNIT_EE_CARRACK',  'UNITAI_ESCORT_SEA'),
('UNIT_EE_CARRACK',  'UNITAI_EXPLORE_SEA'),
('UNIT_EE_GALLEON',  'UNITAI_ASSAULT_SEA'),
('UNIT_EE_GALLEON',  'UNITAI_RESERVE_SEA'),
('UNIT_EE_GALLEON',  'UNITAI_ESCORT_SEA'),
('UNIT_EE_SHIP_OF_THE_LINE', 'UNITAI_ASSAULT_SEA'),
('UNIT_EE_SHIP_OF_THE_LINE', 'UNITAI_RESERVE_SEA'),
('UNIT_EE_SHIP_OF_THE_LINE', 'UNITAI_ESCORT_SEA');

-------------------------------------------------------
-- Spanish Galleon Model Tweaks
-------------------------------------------------------

UPDATE ArtDefine_UnitInfoMemberInfos SET NumMembers = 1 WHERE UnitInfoType = 'ART_DEF_UNIT_U_SPANISH_GALLEON';
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.16 WHERE Type = 'ART_DEF_UNIT_MEMBER_U_SPANISH_GALLEON';

INSERT INTO ArtDefine_StrategicView (StrategicViewType, TileType, Asset)
VALUES ('ART_DEF_UNIT_U_SPANISH_GALLEON', 'Unit', 'sv_Galleon.dds');

-------------------------------------------------------
-- Change VP Corvette model due to same model with Carrack
-------------------------------------------------------
UPDATE ArtDefine_UnitMemberInfos SET Scale = 0.11, Model = 'WarGalleon.fxsxml' WHERE Type = 'ART_DEF_UNIT_MEMBER_CORVETTE';
-------------------------------------------------------
-- Adventurer (upgrade from Explorer)
-------------------------------------------------------

UPDATE Units
SET BaseSightRange = 3, NoBadGoodies = 1, ObsoleteTech = 'TECH_STEAM_POWER'
WHERE Type = 'UNIT_EE_ADVENTURER';

UPDATE Units
SET ObsoleteTech = 'TECH_COMPASS'
WHERE Type = 'UNIT_SCOUT';

UPDATE Units
SET ObsoleteTech = 'TECH_EE_EXPLORATION', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_ADVENTURER' 
WHERE Type = 'UNIT_EXPLORER';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_ADVENTURER', 'PROMOTION_BARBARIAN_BONUS'),
('UNIT_EE_ADVENTURER', 'PROMOTION_DEFENSIVE_EMBARKATION'),
('UNIT_EE_ADVENTURER', 'PROMOTION_EE_ADVENTURER'),
('UNIT_EE_ADVENTURER', 'PROMOTION_EMBARKED_SIGHT'),
('UNIT_EE_ADVENTURER', 'PROMOTION_IGNORE_TERRAIN_COST'),
('UNIT_EE_ADVENTURER', 'PROMOTION_OCEAN_CROSSING'),
('UNIT_EE_ADVENTURER', 'PROMOTION_RECON_EXPERIENCE'),
('UNIT_EE_ADVENTURER', 'PROMOTION_SCOUT_GOODY_BONUS'),
('UNIT_EE_ADVENTURER', 'PROMOTION_SCOUTING_1');

-- Explorer -> Adventurer
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_ADVENTURER' -- Adventurer
WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_EXPLORER');

INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 		UnitClassType, 						UnitType)
SELECT	Type, 					'UNITCLASS_EE_ADVENTURER', 			null
FROM Civilizations WHERE Type IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_MINOR');		  
-------------------------------------------------------
-- Tercio upgrade
-- Zulu Impi, French Musketeer
-------------------------------------------------------

UPDATE Units
SET ObsoleteTech = 'TECH_EE_FLINTLOCK', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_LINE_INFANTRY' 
WHERE Type = 'UNIT_SPANISH_TERCIO';

UPDATE Units
SET ObsoleteTech = 'TECH_RIFLING', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_LINE_INFANTRY' 
WHERE Type IN ('UNIT_FRENCH_MUSKETEER', 'UNIT_ZULU_IMPI');

UPDATE Units
SET Cost = 275, Combat = 28
WHERE Type = 'UNIT_FRENCH_MUSKETEER';

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY'
WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_TERCIO' AND Type != 'UNIT_SWEDISH_CAROLEAN');

-------------------------------------------------------
-- Swedish Carolean, used in period 1680-1720
-- Most of the infantry were equipped with modern flintlock muskets, although older versions still were in use. They were also equipped with rapiers and a bag for ammunition.
-- Switch to Line Infantry, available early EE
-------------------------------------------------------

UPDATE Civilization_UnitClassOverrides SET UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY' WHERE  UnitType = 'UNIT_SWEDISH_CAROLEAN';

UPDATE Units
SET Combat = 34, Class = 'UNITCLASS_EE_LINE_INFANTRY', PrereqTech = 'TECH_EE_FLINTLOCK', ObsoleteTech = 'TECH_REPLACEABLE_PARTS', GoodyHutUpgradeUnitClass = 'UNITCLASS_RIFLEMAN'
WHERE Type = 'UNIT_SWEDISH_CAROLEAN';

UPDATE Unit_ClassUpgrades SET UnitClassType = 'UNITCLASS_RIFLEMAN' WHERE UnitType = 'UNIT_SWEDISH_CAROLEAN';

-------------------------------------------------------
-- Camel Archer - no changes, obsoletes with Cavalry
-------------------------------------------------------

-------------------------------------------------------
-- Russian Cossack
-- The most popular weapons used by Cossack cavalrymen were usually sabres and long spears.
-- move Cossack into Enlightenment and make it melee
-------------------------------------------------------

UPDATE Civilization_UnitClassOverrides Set UnitClassType = 'UNITCLASS_EE_UHLAN' WHERE UnitType = 'UNIT_RUSSIAN_COSSACK';

UPDATE Units
SET Class = 'UNITCLASS_EE_UHLAN', CombatClass = 'UNITCOMBAT_MOUNTED', GoodyHutUpgradeUnitClass = 'UNITCLASS_WWI_TANK',
	Range = 0, RangedCombat = 0, Combat = 50, DefaultUnitAI = 'UNITAI_FAST_ATTACK',
	PrereqTech = 'TECH_RIFLING', ObsoleteTech = 'TECH_COMBINED_ARMS'
WHERE Type = 'UNIT_RUSSIAN_COSSACK';

UPDATE Unit_ClassUpgrades SET UnitClassType = 'UNITCLASS_WWI_TANK' WHERE UnitType = 'UNIT_RUSSIAN_COSSACK';

DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_RUSSIAN_COSSACK' AND PromotionType = 'PROMOTION_ESPRIT_DE_CORPS';
DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_RUSSIAN_COSSACK' AND PromotionType = 'PROMOTION_NAVAL_MISFIRE';
DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_RUSSIAN_COSSACK' AND PromotionType = 'PROMOTION_ONLY_DEFENSIVE';

-- Infixo: resambles original CBO Cossack
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT 'UNIT_RUSSIAN_COSSACK' , 'PROMOTION_ANTI_MOUNTED_I';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT 'UNIT_RUSSIAN_COSSACK' , 'PROMOTION_HEAVY_CHARGE';

-- Infixo: AI same as Knight and Lancer
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_RUSSIAN_COSSACK';
INSERT INTO Unit_AITypes (UnitType, UnitAIType) VALUES
('UNIT_RUSSIAN_COSSACK', 'UNITAI_FAST_ATTACK'),
('UNIT_RUSSIAN_COSSACK', 'UNITAI_DEFENSE');

-------------------------------------------------------
-- Uhlan (upgrade from Lancer)
-------------------------------------------------------

UPDATE Units
SET IgnoreBuildingDefense = 1, MoveRate = 'QUADRUPED', BaseLandAirDefense = 2
WHERE Type = 'UNIT_EE_UHLAN';

-- Lancer -> Uhlan
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_UHLAN'
WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_LANCER');

INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType)
VALUES ('UNIT_EE_UHLAN', 'RESOURCE_HORSE');

UPDATE Units SET ObsoleteTech = 'TECH_RIFLING', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_UHLAN' 
WHERE Type = 'UNIT_LANCER';

UPDATE Units SET ObsoleteTech = 'TECH_RIFLING'
WHERE Type = 'UNIT_SIAMESE_WARELEPHANT' OR Type = 'UNIT_BYZANTINE_CATAPHRACT';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_UHLAN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_EE_UHLAN', 'PROMOTION_CAN_MOVE_AFTER_ATTACKING'),
('UNIT_EE_UHLAN', 'PROMOTION_CITY_PENALTY'),
('UNIT_EE_UHLAN', 'PROMOTION_ANTI_MOUNTED_I');

-------------------------------------------------------
-- Polish Winged Hussar (replaces Lancer, upgrades to Uhlan)
-- The Polish Hussars or Winged Hussars, were one of the main types of the cavalry in the Polish-Lithuanian Commonwealth between the 16th and 18th centuries
-- (Ottoman) Sipahi (gifted by minors, "replaces" Lancer)
-- Sipahi were two types of Ottoman cavalry corps
-------------------------------------------------------

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_UHLAN'
WHERE UnitType IN ('UNIT_OTTOMAN_SIPAHI', 'UNIT_POLISH_WINGED_HUSSAR');

UPDATE Units
SET ObsoleteTech = 'TECH_COMBUSTION', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_UHLAN'
WHERE Type IN ('UNIT_OTTOMAN_SIPAHI', 'UNIT_POLISH_WINGED_HUSSAR');

UPDATE Units SET Combat = '38' WHERE Type = 'UNIT_POLISH_WINGED_HUSSAR';
-------------------------------------------------------
-- Spanish Conquistador (XVI-XVII cent.)
-- The armament consisted of a spear, a steel shield, a helmet called a "Morion", a hilted sword, and sometimes a horse saddle with leather shell.
-------------------------------------------------------

--UPDATE Civilization_UnitClassOverrides SET UnitClassType = 'UNITCLASS_LANCER' WHERE UnitType = 'UNIT_SPANISH_CONQUISTADOR';

--UPDATE Units
--SET Combat = 35, Range = 0, Class = 'UNITCLASS_LANCER', PrereqTech = 'TECH_EE_EXPLORATION', ObsoleteTech = 'TECH_COMBUSTION', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_UHLAN'
--WHERE Type = 'UNIT_SPANISH_CONQUISTADOR';

--UPDATE Unit_ClassUpgrades
--SET UnitClassType = 'UNITCLASS_EE_UHLAN'
--WHERE UnitType = 'UNIT_SPANISH_CONQUISTADOR';

--DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_SPANISH_CONQUISTADOR' AND UnitAIType = 'UNITAI_ATTACK';

-------------------------------------------------------
-- Light Infantry (upgrade from Musketman)
-------------------------------------------------------

UPDATE Units
SET RangedCombat = 37, Range = 2
WHERE Type = 'UNIT_EE_SKIRMISHER';

-- Infixo: proper upgrade for Musketman and Civs' uniques
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_SKIRMISHER'
WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_MUSKETMAN');

UPDATE Units SET ObsoleteTech = 'TECH_EE_FORTIFICATION', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_SKIRMISHER' WHERE Type = 'UNIT_MUSKETMAN';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_SKIRMISHER', 'PROMOTION_CBOEE_SKIRMISH'),
('UNIT_EE_SKIRMISHER', 'PROMOTION_NAVAL_MISFIRE'),
('UNIT_EE_SKIRMISHER', 'PROMOTION_ONLY_DEFENSIVE');

-- move Gatling Gun a bit further; each Archery will be in 2nd column of an era
UPDATE Units SET PrereqTech = 'TECH_DYNAMITE' WHERE Type = 'UNIT_GATLINGGUN';

-------------------------------------------------------
-- Line Infantry
-------------------------------------------------------

UPDATE Units
SET IgnoreBuildingDefense = 1, Conscription = 5
WHERE Type = 'UNIT_EE_LINE_INFANTRY';

INSERT INTO Unit_FreePromotions	(UnitType, PromotionType)
VALUES ('UNIT_EE_LINE_INFANTRY', 'PROMOTION_FORMATION_1');

--UPDATE Units
--SET Class = 'UNITCLASS_EE_LINE_INFANTRY', PrereqTech = 'TECH_EE_FLINTLOCK', GoodyHutUpgradeUnitClass = 'UNITCLASS_RIFLEMAN', ObsoleteTech = 'TECH_RIFLING' -- Combat, Cost, FaithCost
--WHERE Type = 'UNIT_DANISH_SKI_INFANTRY';

-------------------------------------------------------
-- American Minuteman
-------------------------------------------------------

UPDATE Civilization_UnitClassOverrides Set UnitClassType = 'UNITCLASS_EE_LINE_INFANTRY' WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN';

UPDATE Units 
SET Class = 'UNITCLASS_EE_LINE_INFANTRY', CombatClass = 'UNITCOMBAT_GUN', GoodyHutUpgradeUnitClass = 'UNITCLASS_RIFLEMAN',
	Combat = 30, Range = 0, RangedCombat = 0, 
	PrereqTech = 'TECH_EE_FLINTLOCK', ObsoleteTech = 'TECH_REPLACEABLE_PARTS', DefaultUnitAI = 'UNITAI_DEFENSE'
WHERE Type = 'UNIT_AMERICAN_MINUTEMAN';

UPDATE Unit_ClassUpgrades SET UnitClassType = 'UNITCLASS_RIFLEMAN' WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN';

DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN';
INSERT INTO Unit_AITypes (UnitType, UnitAIType) VALUES
('UNIT_AMERICAN_MINUTEMAN', 'UNITAI_EXPLORE'),
('UNIT_AMERICAN_MINUTEMAN', 'UNITAI_ATTACK'),
('UNIT_AMERICAN_MINUTEMAN', 'UNITAI_DEFENSE');

DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN' AND PromotionType = 'PROMOTION_NAVAL_MISFIRE';
DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN' AND PromotionType = 'PROMOTION_ONLY_DEFENSIVE';
DELETE From Unit_FreePromotions WHERE UnitType = 'UNIT_AMERICAN_MINUTEMAN' AND PromotionType = 'PROMOTION_BARRAGE_1';
INSERT INTO Unit_FreePromotions (UnitType, PromotionType) SELECT 'UNIT_AMERICAN_MINUTEMAN', 'PROMOTION_DRILL_1';

-------------------------------------------------------
-- Field Gun and Howitzer
-------------------------------------------------------

UPDATE Units
SET RangedCombat = 35, Range = 2, IgnoreBuildingDefense = 1, MoveRate = 'ARTILLERY'
WHERE Type = 'UNIT_EE_FIELD_GUN';

INSERT INTO Unit_ResourceQuantityRequirements (UnitType, ResourceType, Cost)
VALUES ('UNIT_EE_FIELD_GUN', 'RESOURCE_IRON', 1);

UPDATE UnitClasses
SET Description = 'TXT_KEY_UNIT_FIELD_GUN'
WHERE Type = 'UNITCLASS_FIELD_GUN';

UPDATE Units
SET Description = 'TXT_KEY_UNIT_FIELD_GUN', Civilopedia = 'TXT_KEY_UNIT_FIELD_GUN_PEDIA', Strategy = 'TXT_KEY_UNIT_FIELD_GUN_STRATEGY', Help = 'TXT_KEY_UNIT_FIELD_GUN_HELP'
WHERE Type = 'UNIT_FIELD_GUN';

-- Cannon -> Field Gun
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_FIELD_GUN'
WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_CANNON');

UPDATE Units
SET ObsoleteTech = 'TECH_EE_FLINTLOCK', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_FIELD_GUN'
WHERE Type = 'UNIT_CANNON';

-- Field Gun -> Howitzer
--UPDATE Unit_ClassUpgrades
--SET UnitClassType = 'UNITCLASS_FIELD_GUN'
--WHERE UnitType IN (SELECT Type FROM Units WHERE Class = 'UNITCLASS_EE_FIELD_GUN');
--INSERT INTO Unit_ClassUpgrades (UnitType, UnitClassType)
--VALUES ('UNIT_EE_FIELD_GUN', 'UNITCLASS_FIELD_GUN');

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_FIELD_GUN', 'PROMOTION_CITY_SIEGE'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_COVER_1'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_INDIRECT_FIRE'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_MUST_SET_UP'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_NAVAL_MISFIRE'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_NO_DEFENSIVE_BONUSES'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_ONLY_DEFENSIVE'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_SIEGE_INACCURACY'),
('UNIT_EE_FIELD_GUN', 'PROMOTION_SIGHT_PENALTY');

-------------------------------------------------------
-- Carrack
-------------------------------------------------------

-- Caravel changes (->Carrack)
UPDATE Units
SET ObsoleteTech = 'TECH_ASTRONOMY', GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_CARRACK'
WHERE Type = 'UNIT_CARAVEL';							

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_CARRACK'
WHERE UnitType = 'UNIT_CARAVEL';

UPDATE Units SET GoodyHutUpgradeUnitClass = 'UNITCLASS_IRONCLAD' WHERE Type = 'UNIT_PRIVATEER'; -- Corvette

-------------------------------------------------------
-- Portuguese Nau
-------------------------------------------------------

UPDATE Civilization_UnitClassOverrides SET UnitClassType = 'UNITCLASS_EE_CARRACK' WHERE UnitType = 'UNIT_PORTUGUESE_NAU';

UPDATE Units 
SET Combat = 36, Moves = 5, Class = 'UNITCLASS_EE_CARRACK', PrereqTech = 'TECH_ASTRONOMY', ObsoleteTech = 'TECH_INDUSTRIALIZATION', GoodyHutUpgradeUnitClass = 'UNITCLASS_PRIVATEER'
WHERE Type = 'UNIT_PORTUGUESE_NAU';

UPDATE Unit_ClassUpgrades SET UnitClassType = 'UNITCLASS_PRIVATEER' WHERE UnitType = 'UNIT_PORTUGUESE_NAU';

-------------------------------------------------------
-- Dutch Sea Beggar - replacement for Carrack (change from Privateer)
-- Related to William of Orange, so XVI-XII cent., late Renaissance
-------------------------------------------------------

--UPDATE Civilization_UnitClassOverrides SET UnitClassType = 'UNITCLASS_EE_CARRACK' WHERE UnitType = 'UNIT_DUTCH_SEA_BEGGAR';

UPDATE Units
SET PrereqTech = 'TECH_EE_EXPLORATION', ObsoleteTech = 'TECH_COMBUSTION'
WHERE Type = 'UNIT_DUTCH_SEA_BEGGAR';

--UPDATE Unit_ClassUpgrades SET UnitClassType = 'UNITCLASS_PRIVATEER' WHERE UnitType = 'UNIT_DUTCH_SEA_BEGGAR';

-------------------------------------------------------
-- Polynesian UA
-------------------------------------------------------

INSERT INTO Trait_BuildsUnitClasses	(TraitType, UnitClassType, BuildType) VALUES
('TRAIT_WAYFINDING', 'UNITCLASS_EE_CARRACK', 'BUILD_FISHING_BOATS'),
('TRAIT_WAYFINDING', 'UNITCLASS_EE_SHIP_OF_THE_LINE', 'BUILD_FISHING_BOATS');

-------------------------------------------------------
-- English UU - classic CBP SotL
-------------------------------------------------------

UPDATE Units
SET PrereqTech = 'TECH_NAVIGATION', ObsoleteTech = 'TECH_NUCLEAR_FISSION', GoodyHutUpgradeUnitClass = 'UNITCLASS_CRUISER', Civilopedia = 'TXT_KEY_UNIT_EE_ENGLISH_FIRST_RATE_PEDIA',
	Combat = 28, ShowInPedia = 1,
	IconAtlas = 'ENLIGHTENMENT_UNIT_ATLAS', PortraitIndex = 8
WHERE Type = 'UNIT_ENGLISH_SHIPOFTHELINE';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
VALUES ('UNIT_ENGLISH_SHIPOFTHELINE', 'PROMOTION_EE_FIRST_RATE');
	
-------------------------------------------------------
-- Galleon, Frigate and ranged ships
-------------------------------------------------------

UPDATE Units
SET RangedCombat = 29, Range = 2
WHERE Type = 'UNIT_EE_GALLEON';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_GALLEON', 'PROMOTION_ONLY_DEFENSIVE');

-- Galleass changes
UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_EE_GALLEON', ObsoleteTech = 'TECH_EE_EXPLORATION'
WHERE Type = 'UNIT_GALLEASS';

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_GALLEON'
WHERE UnitType = 'UNIT_GALLEASS';

-- Great Galleass changes
--UPDATE Units
--SET Combat = 13
--WHERE Type = 'UNIT_VENETIAN_GALLEASS';

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_GALLEON'
WHERE UnitType = 'UNIT_VENETIAN_GALLEASS';

-- Frigate changes
UPDATE Units
SET GoodyHutUpgradeUnitClass = 'UNITCLASS_CRUISER', PrereqTech = 'TECH_EE_WARSHIPS', ObsoleteTech = 'TECH_DYNAMITE'
WHERE Type = 'UNIT_FRIGATE';

UPDATE Units
SET IconAtlas = 'ENLIGHTENMENT_UNIT_ATLAS', PortraitIndex = 7
WHERE Type = 'UNIT_CRUISER';

-------------------------------------------------------
-- Ship of the Line - new strong naval melee unit
-------------------------------------------------------

INSERT INTO Unit_FreePromotions (UnitType, PromotionType) VALUES
('UNIT_EE_SHIP_OF_THE_LINE', 'PROMOTION_EE_FIRST_RATE'),
('UNIT_EE_SHIP_OF_THE_LINE', 'PROMOTION_EXTRA_SIGHT_I');

-------------------------------------------------------
-- Align flavors
-------------------------------------------------------


INSERT INTO Unit_Flavors (UnitType, FlavorType, Flavor) VALUES
('UNIT_EE_ADVENTURER','FLAVOR_RECON',  12),
('UNIT_EE_FIELD_GUN', 'FLAVOR_OFFENSE', 5),
('UNIT_EE_FIELD_GUN', 'FLAVOR_DEFENSE', 3),
('UNIT_EE_FIELD_GUN', 'FLAVOR_RANGED', 11),
('UNIT_EE_LINE_INFANTRY','FLAVOR_OFFENSE', 13),
('UNIT_EE_LINE_INFANTRY','FLAVOR_DEFENSE', 10),
('UNIT_EE_SKIRMISHER','FLAVOR_OFFENSE', 2),
('UNIT_EE_SKIRMISHER','FLAVOR_DEFENSE', 2),
('UNIT_EE_SKIRMISHER','FLAVOR_RANGED',  6),
('UNIT_EE_UHLAN',     'FLAVOR_OFFENSE', 9),
('UNIT_EE_UHLAN',     'FLAVOR_DEFENSE', 3),
('UNIT_EE_UHLAN',     'FLAVOR_MOBILE',  7),
('UNIT_EE_CARRACK',   'FLAVOR_NAVAL',  18),
('UNIT_EE_CARRACK',   'FLAVOR_NAVAL_RECON', 23),
('UNIT_EE_GALLEON',   'FLAVOR_NAVAL',  20),
('UNIT_EE_GALLEON',   'FLAVOR_NAVAL_RECON', 10),
('UNIT_EE_SHIP_OF_THE_LINE','FLAVOR_NAVAL', 25),
('UNIT_EE_SHIP_OF_THE_LINE','FLAVOR_NAVAL_RECON', 25);

-------------------------------------------------------
-- Align unit costs and make gold purchases available
-- Guidelines: Cost is 300-450, FaithCost is 250
-- VP 2/27 guidelines
-- MED:(135)160-200, 300 faith
-- REN:     300-375, 400 faith
-- ENL: 400-550, 500 faith
-- IND: 600-900, 600 faith
-- MOD: 800-1300, 700 faith
-------------------------------------------------------

-- Allow for Faith purchases
INSERT INTO Belief_EraFaithUnitPurchase (BeliefType, EraType)
VALUES ('BELIEF_HEATHEN_CONVERSION', 'ERA_ENLIGHTENMENT');

-- Renaissance
UPDATE Units SET Cost = 300, FaithCost = 400 WHERE Type = 'UNIT_EE_ADVENTURER';
UPDATE Units SET Cost = 300, FaithCost = 400 WHERE Type = 'UNIT_2HANDER';
UPDATE Units SET Cost = 350, FaithCost = 450 WHERE Type = 'UNIT_EE_CARRACK'; -- Renaissance, takes place of PRIVATEER
UPDATE Units SET Cost = 350, FaithCost = 450 WHERE Type = 'UNIT_PORTUGUESE_NAU'; -- replaces EE_CARRACK (originally PRIVATEER)
UPDATE Units SET Cost = 450, FaithCost = 450 WHERE Type = 'UNIT_DUTCH_SEA_BEGGAR'; -- replaces EE_CARRACK (originally PRIVATEER)
UPDATE Units SET Cost = 375, FaithCost = 450 WHERE Type = 'UNIT_EE_GALLEON'; -- Renaissance, takes place of FRIGATE
-- UPDATE Units SET Cost = 350, FaithCost = 400 WHERE Type = 'UNIT_SPANISH_CONQUISTADOR'; -- replaces LANCER (originally KNIGHT)
-- Enlightenment
UPDATE Units SET Cost = 400, FaithCost = 500 WHERE Type = 'UNIT_EE_LINE_INFANTRY';
UPDATE Units SET Cost = 400, FaithCost = 500 WHERE Type = 'UNIT_SWEDISH_CAROLEAN'; -- replaces EE_LINE_INF (originally TERCIO)
UPDATE Units SET Cost = 400, FaithCost = 500 WHERE Type = 'UNIT_AMERICAN_MINUTEMAN'; -- replaces EE_LINE_INF(originally MUSKETMAN)
UPDATE Units SET Cost = 450, FaithCost = 500 WHERE Type = 'UNIT_EE_SKIRMISHER';
UPDATE Units SET Cost = 450, FaithCost = 500 WHERE Type = 'UNIT_EE_FIELD_GUN';
UPDATE Units SET Cost = 450, FaithCost = 550 WHERE Type = 'UNIT_PRIVATEER'; -- (350p)
UPDATE Units SET Cost = 500, FaithCost = 550 WHERE Type = 'UNIT_FRIGATE'; -- (375p)
UPDATE Units SET Cost = 550, FaithCost = 550 WHERE Type = 'UNIT_ENGLISH_SHIPOFTHELINE'; -- (375p) replaces FRIGATE
UPDATE Units SET Cost = 550, FaithCost = 550 WHERE Type = 'UNIT_EE_SHIP_OF_THE_LINE';
-- Industrial
UPDATE Units SET Cost = 700, FaithCost = 600 WHERE Type = 'UNIT_EE_UHLAN';
UPDATE Units SET Cost = 700, FaithCost = 600 WHERE Type = 'UNIT_RUSSIAN_COSSACK'; -- replaces EE_UHLAN

INSERT INTO Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType) VALUES
('UNIT_2HANDER',      'BUILDINGCLASS_ARMORY'),
('UNIT_EE_CARRACK',   'BUILDINGCLASS_HARBOR'),
('UNIT_EE_GALLEON',   'BUILDINGCLASS_HARBOR'),
('UNIT_EE_SHIP_OF_THE_LINE','BUILDINGCLASS_HARBOR'),
('UNIT_EE_LINE_INFANTRY','BUILDINGCLASS_ARMORY'),
('UNIT_EE_FIELD_GUN', 'BUILDINGCLASS_ARMORY'),
('UNIT_EE_ADVENTURER','BUILDINGCLASS_ARMORY'),
('UNIT_EE_SKIRMISHER','BUILDINGCLASS_ARMORY'),
('UNIT_EE_UHLAN',     'BUILDINGCLASS_STABLE'),
('UNIT_EE_UHLAN',     'BUILDINGCLASS_ARMORY');

-------------------------------------------------------
-- Add new EE buildings as required for purchases in 2 next Eras
-- Gunsmith: for all UNITCOMBAT_GUN, UNITCOMBAT_ARMOR, UNITCOMBAT_SIEGE units
-- Drydock: for all DOMAIN_SEA units
-------------------------------------------------------

insert into Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType)
	select Type, 'BUILDINGCLASS_EE_DRYDOCK'
	from Units
	where Domain = 'DOMAIN_SEA' and PrereqTech in(
		select Type
		from Technologies
		where Era in ('ERA_INDUSTRIAL', 'ERA_MODERN', 'ERA_POSTMODERN', 'ERA_FUTURE'));

insert into Unit_BuildingClassPurchaseRequireds (UnitType, BuildingClassType)
	select Type, 'BUILDINGCLASS_EE_GUNSMITH'
	from Units
	where (CombatClass = 'UNITCOMBAT_ARMOR' or CombatClass = 'UNITCOMBAT_GUN' or CombatClass = 'UNITCOMBAT_SIEGE') and PrereqTech in(
		select Type
		from Technologies
		where Era in ('ERA_INDUSTRIAL', 'ERA_MODERN'));

-------------------------------------------------------
-- Sounds
-------------------------------------------------------

INSERT INTO UnitGameplay2DScripts (UnitType, SelectionSound, FirstSelectionSound) VALUES
('UNIT_EE_ADVENTURER',   'AS2D_SELECT_SCOUT',     'AS2D_BIRTH_SCOUT'),
('UNIT_EE_FIELD_GUN',    'AS2D_SELECT_CANNON',    'AS2D_BIRTH_CANNON'),
('UNIT_EE_LINE_INFANTRY','AS2D_SELECT_MUSKETMAN', 'AS2D_BIRTH_MUSKETMAN'),
('UNIT_EE_SKIRMISHER',   'AS2D_SELECT_CROSSBOWMAN','AS2D_BIRTH_CROSSBOWMAN'),
('UNIT_EE_UHLAN',        'AS2D_SELECT_CAVALRY',   'AS2D_BIRTH_CAVALRY'),
('UNIT_EE_CARRACK',      'AS2D_SELECT_CARAVEL',   'AS2D_BIRTH_CARAVEL'),
('UNIT_EE_GALLEON',      'AS2D_SELECT_FRIGATE',   'AS2D_BIRTH_FRIGATE'),
('UNIT_EE_SHIP_OF_THE_LINE','AS2D_SELECT_CARAVEL','AS2D_BIRTH_CARAVEL');


----------------------------------------------------
-- Text (en_US)
----------------------------------------------------

INSERT INTO Language_en_US (Tag, Text) VALUES
-- Carrack
('TXT_KEY_UNIT_EE_CARRACK', 'Carrack'),
('TXT_KEY_UNIT_EE_CARRACK_HELP', 'Early Renaissance era melee naval unit used to gain early naval supremacy.'),
('TXT_KEY_UNIT_EE_CARRACK_PEDIA', 'Developed by the Genoese Republic for commercial purposes, a carrack is three- or four-masted sailing vessel. Utilized by Spain and Portugal for oceanic travel and exploration, the carrack was one of the most influential ship designs in history. Large and roomy to carry cargo across vast distances, they were used heavily across the Atlantic and Indian oceans, carrying new found wealth and resources back to the great cities of Europe. One of the most famous ships to go down a history, the Santa Maria, was a carrack that carried Columbus and his crew to discover the new world. Another famous ship of this design belongs to Vasco Da Gama, the Portuguese explorer who circumnavigated Africa, discovering a new route to spices of India. The end of the carrack came at the hands of the galleon. Developed from the carrack, the first galleons became a reality in the mid 16th century, though the carrack would persist for several more decades.'),
('TXT_KEY_UNIT_EE_CARRACK_STRATEGY', 'The Carrack upgrades from the Caravel. It allows you to better secure your coastal cities from seafaring Barbarians or counterattacks from enemy Civilizations.  Its early increased combat strength means it can be used, with support, to take small cities with low Defensive Strength.'),
-- Adventurer
('TXT_KEY_UNIT_EE_ADVENTURER', 'Adventurer'),
('TXT_KEY_UNIT_EE_ADVENTURER_HELP', 'Recon unit. Can see further and has additional movement while embarked.'),
('TXT_KEY_UNIT_EE_ADVENTURER_PEDIA', 'Throughout history there are those whose thirst for adventure led them from the safe confines of civilized lands. These adventurers, frequently funded by government stipends, would then journey into the unknown, charting their progress all the way. These expeditions, and the maps they helped create, became blueprints for the conquest and domestication of the once uncharted regions of the world.'),
('TXT_KEY_UNIT_EE_ADVENTURER_STRATEGY', 'An upgrade to the Explorer. The Adventurer has even more movement and strength, although is still quite weak.  The Adventurer excels at sea exploration, as it is able to move further while embarked.  Use it to finish meeting all the other Civilizations, or scout out locations for overseas colonies.'),
-- Field Gun
('TXT_KEY_UNIT_EE_FIELD_GUN', 'Field Gun'),
('TXT_KEY_UNIT_EE_FIELD_GUN_HELP', 'Enlightenment Era artillery unit. Moves at half-speed in enemy territory.'),
('TXT_KEY_UNIT_EE_FIELD_GUN_PEDIA', 'A field gun is a piece of light artillery that can be easily moved around the battlefield. During his wars in Europe, Napoleon used field guns to great effect. His employment of very large wheels allowed his guns to be quickly moved in the midst of battle, meaning enemy formations could be easily broken up. This strategy gradually became obsolete, however, as the development of road and rail, and the changing nature of the battlefield, allowed for most kinds of artillery to be moved at respectable speed.[NEWLINE][NEWLINE]By the beginning of the Second World War, the term "field gun" had come to mean any long-range artillery piece that fired at a low angle. However, because of the demand for artillery which could fire at both long-range and a high angle during the later stages of World War II, field guns became largely supplanted by howitzers, and today the term sees no widespread application.'),
('TXT_KEY_UNIT_EE_FIELD_GUN_STRATEGY', 'The Field Gun is the Enlightenment Era artillery unit.  While its range remains the same as the Cannon, from which it upgrades, it is much stronger. Like other siege units, it cannot see very far and must be protected. It also moves at half-speed in enemy territory, but Field Guns are essential to Enlightenment conquests.'),
-- First Rate
('TXT_KEY_UNIT_EE_ENGLISH_FIRST_RATE', 'First Rate'),
('TXT_KEY_UNIT_EE_ENGLISH_FIRST_RATE_HELP', 'Powerful Enlightenment Era naval melee unit which boosts the defensive strength of adjacent friendly units.  Only the English may build it.'),
('TXT_KEY_UNIT_EE_ENGLISH_FIRST_RATE_PEDIA', '“First-rate” is the classification used for the largest ships of the line maintained by the British Royal Navy.  Throughout the existence of the rating system, the threshold armament and crew for a ship to be considered first-rate changed.  However, it was established in the early 1700s that a first-rate ship loaded for wartime carried at least 100 guns.  First-rates were very expensive, heavy and slow in exchange for their massive firepower.  As a result, few were maintained at any given time, and they often served as flagships.  HMS Victory, Admrial Nelson’s famous flagship from the Battle of Trafalgar, is the only surviving first-rate.'),
('TXT_KEY_UNIT_EE_ENGLISH_FIRST_RATE_STRATEGY', 'The First Rate is England’s unique unit, replacing the Ship of the Line.  Like the Ship of the Line, it is a strong melee ship.  However, it is even stronger than the unit it replaces.  It also provides combat boosts to nearby allied ships when defending.  Use it as part of a larger fleet to greatly increase your naval firepower.'),
-- Galleon
('TXT_KEY_UNIT_EE_GALLEON', 'Galleon'),
('TXT_KEY_UNIT_EE_GALLEON_HELP', 'Renaissance Era ranged naval Unit. Can enter ocean tiles.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]Land attacks can only be performed on Coastal Tiles.[ENDCOLOR]'),
('TXT_KEY_UNIT_EE_GALLEON_PEDIA', 'A galleon is the design of a multi-story sailing vessel attributed to the Venetians. Employed extensively in the fleets of Spain and other European states to further their naval militaristic interests, the galleon were formidable warships that weighed up to 2000 metric tonnes. The galleon was powered entirely by wind, using sails carried on three or four masts, with a lateen sail continuing to be used on the last (usually third and fourth) masts. They were used in both military and trade applications, most famously in the Spanish treasure fleet, and the Manila Galleons. Demoting the carrack to be used just for cargo, these vessels became the forefront of European armadas and went on to colonize the world.'),
('TXT_KEY_UNIT_EE_GALLEON_STRATEGY', 'The Galleon is a Renaissance naval unit.  Upgrading from the Galleass, the Galleon is the first ranged ship to be able to enter Oceans.  Use a fleet of Galleons, supported by larger ships, to conquer overseas cities and protect your overseas holdings.'),
-- Line Infantry
('TXT_KEY_UNIT_EE_LINE_INFANTRY', 'Line Infantry'),
('TXT_KEY_UNIT_EE_LINE_INFANTRY_HELP', 'Basic front-line infantry unit of the Enlightenment Era.'),
('TXT_KEY_UNIT_EE_LINE_INFANTRY_PEDIA', 'With the massive proliferation of guns from the middle of the 17th century, the battlefield became dominated by linear tactics, according to which infantry were arranged into long thin lines and fired volleys. A line consisted of 2, 3, or 4 ranks of soldiers. The relatively short range at which smooth bore muskets could accurately hit a target, added to the slow reload, meant that massed formation firing was essential for maximizing enemy casualties. The line was considered the fundamental battle formation as it allowed for the largest deployment of firepower. In the years following the Napoleonic Wars, line infantry continued to be deployed as the main battle force, while light infantry provided fire support and covered the movement of units. With the invention of new weaponry, the concept of line infantry began to wane; men walking in formation line-abreast became far too easy a target. The growing accuracy and rate of fire of rifles, together with the invention of the gatling gun and machine gun, meant that close order line infantry would suffer huge losses before being able to close with their foe. With the turn of the 20th Century, this slowly led to infantry increasingly adopting skirmisher style light infantry tactics in battle, while retaining line infantry drills for training.'),
('TXT_KEY_UNIT_EE_LINE_INFANTRY_STRATEGY', 'The standard gunpowder unit of the Enlightenment Era, upgrading from and significantly outclassing the Tercio. The Line Infantry will form the backbone of Enlightenment armies, being used to fight other melee units and protect siege and ranged units.'),
-- Light Infantry
('TXT_KEY_UNIT_EE_SKIRMISHER', 'Light Infantry'),
('TXT_KEY_UNIT_EE_SKIRMISHER_HELP', 'Primary ranged unit of the Enlightenment era which must be adjacent to attack.'),
('TXT_KEY_UNIT_EE_SKIRMISHER_PEDIA', 'Light Infantry act as a skirmish force stationed ahead or alongside a larger body of friendly troops to harass the enemy. In ancient and medieval warfare, skirmishers typically carried bows, javelins, or slings. Acting as light infantry with minimal armor, they could run ahead of the main battle line, release a volley, and retreat before the clash of the opposing main forces. During the Napoleonic Wars the role of the skirmisher took on new notability, attempting to disrupt enemy forces by firing into their close-packed ranks and potentially causing early casualties and breaking enemy formation. A skirmish force screening the main body of infantry became so important that eventually all the major European powers developed specialized skirmishing infantry, e.g. the German Jaeger and the French Voltigeurs. While muskets were the predominant weapon at the time, the British Army experimented with rifles, which soon became the predominant firearm. A consequence of these wars was a trend to train line troops to adopt skirmisher tactics. By the late 19th century, the concept of fighting in formation was on the wane, and the distinctions between skirmisher and heavy infantry have largely disappeared.'),
('TXT_KEY_UNIT_EE_SKIRMISHER_STRATEGY', 'The Light Infantry is a primary ranged unit of the Enlightenment Era. It is very well suited to fight in difficult terrain, like hills and forests.'),
-- Ship of the Line
('TXT_KEY_UNIT_EE_SHIP_OF_THE_LINE', 'Ship of the Line'),
('TXT_KEY_UNIT_EE_SHIP_OF_THE_LINE_HELP', 'Powerful Enlightenment Era naval melee Unit. Grants adjacent ships combat bonus.'),
('TXT_KEY_UNIT_EE_SHIP_OF_THE_LINE_STRATEGY', 'The Ship of the Line is a melee naval unit of the Enlightenment Era.  Unlike the Corvette, the Ship of the Line requires Iron to build and maintain.  However, a boost to combat strength and a critical boost to movement speed make it worth the price.  Use it to crush outdated fleets with superior firepower and speed.'),
-- Uhlan
('TXT_KEY_UNIT_EE_UHLAN', 'Uhlan'),
('TXT_KEY_UNIT_EE_UHLAN_HELP', 'Mid game light cavalry unit good against other mounted units.'),
('TXT_KEY_UNIT_EE_UHLAN_PEDIA', 'The Uhlan was a Polish light cavalry unit armed with lances, sabres, and pistols which came to frequent the armies of 18th and 19th century Russia, Prussia, and Austria. Descendents of the Tartar settlers of Lithuania, the first Uhlan regiment was created by the Polish-Lithuanian Commonwealth in the early 1700s. Swift and unobstructed by the cumbersome armor which had previously dominated mounted warfare, the Uhlan quickly grew in popular use for their versatility and speed; able to conduct reconnaissance, skirmishes, or to head-on charges. Today, a ceremonial regiment of Uhlans is retained by the Polish Armed Forces.'),
('TXT_KEY_UNIT_EE_UHLAN_STRATEGY', 'The anti-cavalry movement unit of the Industrial Era, the Uhlan upgrades from the Lancer and fulfills largely the same role as its Renaissance predecessor.  Use it to directly counter the fast cavalry that enemies harass your invading armies with');

-- Corvette (ex. Privateer)
UPDATE Language_en_US
SET Text = 'Naval Unit that attacks as a melee unit. It is stronger and faster than the Carrack.'
WHERE Tag IN ('TXT_KEY_UNIT_PRIVATEER_STRATEGY');

-- Dutch Sea Beggar
--UPDATE Language_en_US
--SET Text = 'Naval Unit that specializes in attacking coastal cities to earn gold and capturing enemy ships. Stronger than Carrack, which it replaces. Only the Dutch can build it.'
--WHERE Tag = 'TXT_KEY_UNIT_HELP_SEA_BEGGAR';

-- Portugese Nau
UPDATE Language_en_US 
SET Text = 'Melee naval unit which excels at sea exploration. Has higher Combat Strength than the Carrack, and can perform an ability when adjacent to City-States to earn [ICON_GOLD] Gold and XP. May only be built by the Portuguese. [NEWLINE][NEWLINE]If possible, when a Nau sells its Exotic Cargo, a Feitoria is [COLOR_POSITIVE_TEXT]automatically created[ENDCOLOR] in its territory.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_PORTUGUESE_NAU';
UPDATE Language_en_US 
SET Text = 'This melee naval unit replaces the Carrack and is skilled at exploration. When it is in a tile next to land owned by another Civilization or City-State you are at peace with, it may perform a one-time trade mission to earn [ICON_GOLD] Gold and XP. The further the land is from your own capital, the greater the bonus, so it is best to use on distant players. Use this unit to explore the map and uncover the locations of other players.'
WHERE Tag = 'TXT_KEY_UNIT_PORTUGUESE_NAU_STRATEGY';

-- Swedish Carolean
UPDATE Language_en_US 
SET Text = 'Caroleans are the backbone of the Enlightenment era Swedish army. They start with the March promotion that allows it to Heal every turn, even if it performs an action. The Carolean also receives a 15% combat bonus when stacked with a Great General, and deals damage to all adjacent units after advancing from killing a unit.'
WHERE Tag = 'TXT_KEY_UNIT_SWEDISH_CAROLEAN_STRATEGY';

-- Spanish Conquistador
--UPDATE Language_en_US
--SET Text = 'Renaissance Era unit that specializes in scouting and colonizing overseas. Only Spain may build it. Replaces the Lancer, but is available with Exploration.'
--WHERE Tag = 'TXT_KEY_CIV5_SPAIN_CONQUISTADOR_HELP';
--UPDATE Language_en_US
--SET Text = 'The Conquistador is a multi-purpose unit that is strong both on land and at sea. Replacing the Lancer but becoming available with Exploration instead of Metallurgy, it is an exceptional scout on land with extra visibility. It also has the ability to found new cities, but only on a foreign continent that does not contain the Spanish capital. In the water, the Conquistador has the defensive embarkation promotion that allows it to better defend itself against naval units. It also suffers no penalty when attacking cities, unlike the Lancer.'
--WHERE Tag IN ('TXT_KEY_CIV5_SPAIN_CONQUISTADOR_STRATEGY');

-- Russian Cossack
UPDATE Language_en_US
SET Text = 'Only the Russians may build it. This Unit has a combat bonus when fighting enemies that have already taken damage, and is stronger than the Uhlan, which it replaces.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_COSSACK';
UPDATE Language_en_US
SET Text = 'The Cossack is the Russian unique unit, replacing the Uhlan. They are stronger than the Uhlan, and can also move after attacking. They get a combat bonus when battling damaged units. This makes Cossacks exceptionally strong at counter attacking, let the enemy chew up the front line peasants, then tear the weakened foe apart with a Cossack charge!'
WHERE Tag = 'TXT_KEY_UNIT_RUSSIAN_COSSACK_STRATEGY';

-- American Minuteman
UPDATE Language_en_US
SET Text = 'The Minuteman is the American unique unit, replacing the Line Infantry. The Minuteman can move through difficult terrain without penalty.'
WHERE Tag = 'TXT_KEY_UNIT_AMERICAN_MINUTEMAN_STRATEGY';
UPDATE Language_en_US
SET Text = 'Only the Americans may build it. This Unit may move through rough ground as though it were flat, unlike the Line Infantry which it replaces.'
WHERE Tag = 'TXT_KEY_UNIT_HELP_MINUTEMAN'; 

-- English First Rate (ranged)
UPDATE Language_en_US
SET Text = 'First Rate'
WHERE Tag = 'TXT_KEY_UNIT_ENGLISH_SHIPOFTHELINE';

																																																																							
											  
UPDATE Language_en_US
SET Text = 'The First Rate is the English unique unit, replacing the Frigate. The Ship of the Line has a higher Ranged Combat strength than the Frigate. It can also see one hex farther than the Frigate, allowing it to spot enemies in a significantly larger section of ocean. Like the frigate, it cannot fire on non-coastal land tiles.'
WHERE Tag = 'TXT_KEY_UNIT_ENGLISH_SHIPOFTHELINE_STRATEGY';

-- Howitzer (VP's Field Gun)
DELETE FROM Language_en_US WHERE Tag = 'TXT_KEY_UNIT_FIELD_GUN';
INSERT INTO Language_en_US (Tag, Text) VALUES
('TXT_KEY_UNIT_FIELD_GUN', 'Howitzer'),
('TXT_KEY_UNIT_FIELD_GUN_HELP', 'Industrial Era artillery unit, more powerful than a Field Gun. Moves at half-speed in enemy territory.'),
('TXT_KEY_UNIT_FIELD_GUN_PEDIA', 'A howitzer is a type of artillery piece characterized by a relatively short barrel and the use of comparatively small propellant charges to propel projectiles over relatively high trajectories, with a steep angle of descent. Introduced to European armies in the middle of 18th century, these field howitzers were also able to fire explosive shells. In the 1860s, artillery officers discovered that rifled siege howitzers (substantially larger than field howitzers) were a more efficient means of destroying walls than smoothbore siege guns or siege mortars. The lightest of these weapons (later known as "light siege howitzers") had calibers around 150 mm and fired shells that weighed between 40 and 50 kilograms. The heaviest (later called "medium siege howitzers") had calibers between 200 mm and 220 mm and fired shells that weighed about 100 kilograms (220 pounds).'),
('TXT_KEY_UNIT_FIELD_GUN_STRATEGY', 'Industrial Era artillery unit, more powerful than a Field Gun. Moves at half-speed in enemy territory.');
