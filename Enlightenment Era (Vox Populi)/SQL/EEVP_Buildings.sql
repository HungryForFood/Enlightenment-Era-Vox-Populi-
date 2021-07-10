----------------------------------------------------
-- Enlightenment Era (Vox Populi)
-- BUILDINGS
-- 2018-01-31 Reworked by Infixo from EE & VP-EE mods
----------------------------------------------------

----------------------------------------------------
-- Generic info
----------------------------------------------------

INSERT INTO Buildings (Type, PrereqTech, ArtDefineTag, PortraitIndex, IconAtlas) VALUES
('BUILDING_EE_ACADEMY',    'TECH_EE_HUMANISM',     'FORGE',  3,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_BASTION',    'TECH_EE_FORTIFICATION','CASTLE', 1,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_CLOTH_MILL', 'TECH_EE_MANUFACTURING','FORGE',  4,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_DRYDOCK',    'TECH_EE_WARSHIPS',     'HARBOR', 6,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_GALLERY',    'TECH_ARCHITECTURE',    'MUSEUM',22,'BW_ATLAS_1'),
('BUILDING_EE_GUNSMITH',   'TECH_EE_FLINTLOCK',    'FORGE',  0,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_MANOR',      'TECH_EE_SOVEREIGNTY',  'FORGE',  0,'ENLIGHTENMENT_VP_BUILDING_ATLAS'),
('BUILDING_EE_MENAGERIE',  'TECH_EE_ROMANTICISM',  'THEATRE',1,'ENLIGHTENMENT_VP_BUILDING_ATLAS'),
('BUILDING_EE_SALON',      'TECH_EE_HUMANISM',     'FORGE',  2,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_TAVERN',     'TECH_MACHINERY',       'FORGE',  7,'ENLIGHTENMENT_BUILDING_ATLAS'),
('BUILDING_EE_WEIGH_HOUSE','TECH_EE_MANUFACTURING','FORGE', 27,'BW_ATLAS_1');

UPDATE Buildings
SET BuildingClass = 'BUILDINGCLASS_'||SUBSTR(Type,10), Description = 'TXT_KEY_'||Type,
	Civilopedia = 'TXT_KEY_'||Type||'_PEDIA', Strategy = 'TXT_KEY_'||Type||'_STRATEGY', Help = 'TXT_KEY_'||Type||'_HELP',
	MinAreaSize = -1, HurryCostModifier = -20, ConquestProb = 66
WHERE Type IN (
'BUILDING_EE_ACADEMY',
'BUILDING_EE_BASTION',
'BUILDING_EE_CLOTH_MILL',
'BUILDING_EE_DRYDOCK',
'BUILDING_EE_GALLERY',
'BUILDING_EE_GUNSMITH',
'BUILDING_EE_MANOR',
'BUILDING_EE_MENAGERIE',
'BUILDING_EE_SALON',
'BUILDING_EE_TAVERN',
'BUILDING_EE_WEIGH_HOUSE');

INSERT INTO BuildingClasses (Type, DefaultBuilding, Description)
SELECT 'BUILDINGCLASS_'||SUBSTR(Type,10), Type, 'TXT_KEY_'||Type
FROM Buildings
WHERE Type IN (
'BUILDING_EE_ACADEMY',
'BUILDING_EE_BASTION',
'BUILDING_EE_CLOTH_MILL',
'BUILDING_EE_DRYDOCK',
'BUILDING_EE_GALLERY',
'BUILDING_EE_GUNSMITH',
'BUILDING_EE_MANOR',
'BUILDING_EE_MENAGERIE',
'BUILDING_EE_SALON',
'BUILDING_EE_TAVERN',
'BUILDING_EE_WEIGH_HOUSE');


-- Non-EE buildings
UPDATE Buildings
SET PrereqTech = 'TECH_EE_ROMANTICISM', PortraitIndex = 5, IconAtlas = 'ENLIGHTENMENT_BUILDING_ATLAS'
WHERE Type = 'BUILDING_MUSEUM';

UPDATE Buildings SET PrereqTech = 'TECH_DYNAMITE' WHERE Type = 'BUILDING_ARSENAL';


------------------------------------------------------------------------------------------------------------------------	
-- Building costs
-- CLA: 150/200, ? faith, 1 maint
-- MED: 300/350, 250 faith, 2 maint
-- REN: 500/600, 300 faith, 3 maint		=> 2/27 400 faith
-- ENL: 700/800, 350 faith, 3 maint		=> 2/27 750/900
-- IND: 900/1000, 400 faith, 4 maint 	=> 2/27 1000/1250 (seaport 1500), 500 faith, 4/5 maint
-- 										=> MOD: 1800/2000, 600 faith, 5/6 maint
------------------------------------------------------------------------------------------------------------------------	

-- column 6 (MED2)
UPDATE Buildings SET Cost = 300, GoldMaintenance = 2 WHERE Type = 'BUILDING_EE_TAVERN';

-- column 7 (REN1)
--UPDATE Buildings SET Cost = 500, GoldMaintenance = 3 WHERE Type = 'BUILDING_THEATRE';

-- column 8 (REN2)
UPDATE Buildings SET Cost = 600, GoldMaintenance = 4 WHERE Type = 'BUILDING_EE_MANOR';
UPDATE Buildings SET Cost = 600, GoldMaintenance = 4 WHERE Type = 'BUILDING_EE_GALLERY';

-- column 9 (EE1)
UPDATE Buildings SET Cost = 750, GoldMaintenance = 4 WHERE Type = 'BUILDING_EE_SALON';
UPDATE Buildings SET Cost = 750, GoldMaintenance = 4 WHERE Type = 'BUILDING_EE_ACADEMY';
UPDATE Buildings SET Cost = 750, GoldMaintenance = 4 WHERE Type = 'BUILDING_EE_GUNSMITH';
UPDATE Buildings SET Cost = 750, GoldMaintenance = 4 WHERE Type = 'BUILDING_KREPOST'; -- replaces EE_BASTION, but it's earlier

-- column 10 (EE2)
UPDATE Buildings SET Cost = 900 WHERE Type = 'BUILDING_EE_WEIGH_HOUSE';
UPDATE Buildings SET Cost = 900, GoldMaintenance = 5 WHERE Type = 'BUILDING_EE_CLOTH_MILL';
UPDATE Buildings SET Cost = 900, GoldMaintenance = 5 WHERE Type = 'BUILDING_EE_DRYDOCK';
UPDATE Buildings SET Cost = 900, GoldMaintenance = 5 WHERE Type = 'BUILDING_EE_BASTION';

-- column 11 (IND1)
UPDATE Buildings SET Cost = 1250, GoldMaintenance = 6 WHERE Type = 'BUILDING_EE_MENAGERIE';
--UPDATE Buildings SET Cost = 1250 WHERE Type = 'BUILDING_MUSEUM'; -- precaution, same as VP

-- column 12 (IND2)
--UPDATE Buildings SET Cost = 1000 WHERE Type = 'BUILDING_ARSENAL'; -- precaution, same as VP

UPDATE Buildings
SET EmpireNeedsModifier = '-5'
WHERE Type = 'BUILDING_EE_BASTION';
------------------------------------------------------------------------------------------------------------------------	
-- Building Lines
-- Castle -> Bastion -> Arsenal
-- Gallery -> Museum
-- Harbor -> Drydock
-- Circus -> Theatre/Zoo -> Menagerie
-- Bank -> Weigh House
------------------------------------------------------------------------------------------------------------------------	

INSERT INTO Building_ClassesNeededInCity (BuildingType, BuildingClassType) VALUES
('BUILDING_EE_BASTION', 'BUILDINGCLASS_CASTLE'),
('BUILDING_EE_DRYDOCK', 'BUILDINGCLASS_HARBOR'),
--('BUILDING_THEATRE', 'BUILDINGCLASS_CIRCUS'),
--('BUILDING_EE_TAVERN', 'BUILDINGCLASS_COLOSSEUM'),
('BUILDING_EE_MENAGERIE', 'BUILDINGCLASS_THEATRE'),
--('BUILDING_STADIUM', 'BUILDINGCLASS_EE_MENAGERIE'),
('BUILDING_EE_WEIGH_HOUSE', 'BUILDINGCLASS_BANK');

UPDATE Building_ClassesNeededInCity SET BuildingClassType = 'BUILDINGCLASS_EE_BASTION' WHERE BuildingType = 'BUILDING_ARSENAL';
--UPDATE Building_ClassesNeededInCity SET BuildingClassType = 'BUILDINGCLASS_EE_WEIGH_HOUSE' WHERE BuildingType = 'BUILDING_STOCK_EXCHANGE';
UPDATE Building_ClassesNeededInCity SET BuildingClassType = 'BUILDINGCLASS_EE_GALLERY' WHERE BuildingType = 'BUILDING_MUSEUM';
--UPDATE Building_ClassesNeededInCity SET BuildingClassType = 'BUILDINGCLASS_EE_MENAGERIE' WHERE BuildingType = 'BUILDING_STADIUM';

----------------------------------------------
-- Gallery
----------------------------------------------

UPDATE Buildings
SET GreatWorkSlotType = 'GREAT_WORK_SLOT_ART_ARTIFACT', GreatWorkCount = 1
WHERE Type = 'BUILDING_EE_GALLERY';

DELETE FROM Building_BuildingClassYieldChanges WHERE BuildingType = 'BUILDING_MUSEUM';
INSERT INTO Building_BuildingClassYieldChanges (BuildingType, BuildingClassType, YieldType, YieldChange)
VALUES ('BUILDING_EE_GALLERY', 'BUILDINGCLASS_ARTISTS_GUILD', 'YIELD_GOLD', 1);
	
-- Gallery: +15% Artists
INSERT INTO Building_SpecificGreatPersonRateModifier (BuildingType, SpecialistType, Modifier)
VALUES ('BUILDING_EE_GALLERY', 'SPECIALIST_ARTIST', 15);

INSERT INTO Building_SpecialistYieldChangesLocal
	(BuildingType, SpecialistType, YieldType, Yield)
VALUES
	('BUILDING_EE_GALLERY', 'SPECIALIST_ARTIST', 'YIELD_CULTURE', 1);
	
	
INSERT INTO Building_GreatWorkYieldChangesLocal
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_EE_GALLERY', 'YIELD_CULTURE', 1);

-- Museum: +25% Artists (for balance)
UPDATE Building_SpecificGreatPersonRateModifier
SET Modifier = 25
WHERE BuildingType = 'BUILDING_MUSEUM' AND SpecialistType = 'SPECIALIST_ARTIST';

UPDATE Building_ThemingYieldBonus
SET Yield = 5
WHERE BuildingType = 'BUILDING_MUSEUM';

----------------------------------------------
-- Menagerie
----------------------------------------------



UPDATE Building_FeatureYieldChanges
SET BuildingType = 'BUILDING_EE_MENAGERIE'
WHERE BuildingType = 'BUILDING_THEATRE';

INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_MENAGERIE', 'YIELD_SCIENCE', 3),
('BUILDING_EE_MENAGERIE', 'YIELD_GOLD', 2),
('BUILDING_EE_MENAGERIE', 'YIELD_CULTURE', 2);
	
INSERT INTO Building_ResourceYieldChanges
	(BuildingType, ResourceType, YieldType, Yield)
VALUES
	('BUILDING_EE_MENAGERIE', 'RESOURCE_BISON', 'YIELD_GOLD', 1),
	('BUILDING_EE_MENAGERIE', 'RESOURCE_DEER', 'YIELD_GOLD', 1),
	('BUILDING_EE_MENAGERIE', 'RESOURCE_IVORY', 'YIELD_GOLD', 1);  

----------------------------------------------
-- Academy and Salon
-- Science: Palace 1/3, Public School 1/2, Skola 1/1
-- Culture: Gallery 1/6, Museum 1/4, BrTow 1/5
----------------------------------------------

UPDATE Buildings SET MutuallyExclusiveGroup = 17 WHERE Type = 'BUILDING_EE_ACADEMY' OR Type = 'BUILDING_EE_SALON';


INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_ACADEMY', 'YIELD_SCIENCE', 2),
('BUILDING_EE_SALON',   'YIELD_CULTURE', 2);

INSERT INTO Building_SpecificGreatPersonRateModifier (BuildingType, SpecialistType, Modifier) VALUES
('BUILDING_EE_ACADEMY', 'SPECIALIST_SCIENTIST', 15),
('BUILDING_EE_ACADEMY', 'SPECIALIST_MERCHANT', 15),
('BUILDING_EE_ACADEMY', 'SPECIALIST_ENGINEER', 15),
('BUILDING_EE_SALON', 'SPECIALIST_ARTIST', 15),
('BUILDING_EE_SALON', 'SPECIALIST_WRITER', 15),
('BUILDING_EE_SALON', 'SPECIALIST_MUSICIAN', 15);

INSERT INTO Building_YieldChangesPerPop (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_ACADEMY', 'YIELD_SCIENCE', 20), -- 1/5 pop
('BUILDING_EE_SALON', 'YIELD_CULTURE', 20);  -- 1/5 pop

----------------------------------------------
-- Weigh House and Cloth Mill
-- Gold: PaperMaker 1/4, StockExch 1/2
----------------------------------------------

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MERCHANT' , SpecialistCount = 1, TradeRouteSeaGoldBonus = 100
WHERE Type = 'BUILDING_EE_WEIGH_HOUSE';

UPDATE Buildings
SET River = 1
WHERE Type = 'BUILDING_EE_CLOTH_MILL';

INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_CLOTH_MILL',  'YIELD_PRODUCTION', 3),
('BUILDING_EE_WEIGH_HOUSE', 'YIELD_GOLD',       3);

INSERT INTO Building_YieldChangesPerPop (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_CLOTH_MILL',  'YIELD_PRODUCTION', 25), -- 1/4 pop, but no Engi
('BUILDING_EE_WEIGH_HOUSE', 'YIELD_GOLD',       20); -- 1/5 pop, but there's a Merchant

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield) VALUES
('BUILDING_EE_CLOTH_MILL', 'RESOURCE_COTTON', 'YIELD_GOLD', 2),
('BUILDING_EE_CLOTH_MILL', 'RESOURCE_SHEEP',  'YIELD_GOLD', 2),
('BUILDING_EE_CLOTH_MILL', 'RESOURCE_SILK',   'YIELD_GOLD', 2);

----------------------------------------------
-- Bastion
-- Bastion needs more since it's far from Castle
-- Lower other defensive buildings for balance
----------------------------------------------

UPDATE Buildings
SET AllowsRangeStrike = 1, NeverCapture = 1, ConquestProb = 0
WHERE Type = 'BUILDING_EE_BASTION';

UPDATE Buildings SET Defense = 1000, ExtraCityHitPoints = 100, CitySupplyModifier = 10, CityRangedStrikeRange = 1, HealRateChange = 10 WHERE Type = 'BUILDING_EE_BASTION';
UPDATE Buildings SET Defense = 1500, ExtraCityHitPoints = 125, CitySupplyModifier = 10, CityRangedStrikeRange = 0, HealRateChange =  0 WHERE Type = 'BUILDING_ARSENAL';
UPDATE Buildings SET Defense = 2000, ExtraCityHitPoints = 150, CitySupplyModifier = 20 WHERE Type = 'BUILDING_MILITARY_BASE';

-- add EE_BASTION to Defender of Faith Belief
INSERT INTO Belief_BuildingClassYieldChanges
		(BeliefType, BuildingClassType, YieldType, YieldChange)
SELECT DISTINCT BeliefType, 'BUILDINGCLASS_EE_BASTION', YieldType, YieldChange
FROM Belief_BuildingClassYieldChanges WHERE BeliefType = 'BELIEF_DEFENDER_FAITH';
	
----------------------------------------------
-- Ostrog (KREPOST) must replace Bastion as the latter comes before Arsenal
----------------------------------------------

UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_EE_BASTION'
WHERE BuildingType = 'BUILDING_KREPOST';

UPDATE Buildings  -- VP: Arsenal, Metallurgy
SET BuildingClass = 'BUILDINGCLASS_EE_BASTION', PrereqTech = 'TECH_EE_FLINTLOCK', Defense = 1000, ExtraCityHitPoints = 100, CityIndirectFire = 0
WHERE Type = 'BUILDING_KREPOST'; 

----------------------------------------------
-- Tavern
----------------------------------------------
INSERT INTO Building_YieldChanges (BuildingType, YieldType, Yield) VALUES
('BUILDING_EE_TAVERN', 'YIELD_FOOD', 2);


INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield) VALUES
('BUILDING_EE_TAVERN', 'RESOURCE_WHEAT', 'YIELD_FOOD', 1),
('BUILDING_EE_TAVERN', 'RESOURCE_BISON', 'YIELD_FOOD', 1),
('BUILDING_EE_TAVERN', 'RESOURCE_DEER', 'YIELD_FOOD', 1),
('BUILDING_EE_TAVERN', 'RESOURCE_WINE', 'YIELD_FOOD', 1),
('BUILDING_EE_TAVERN', 'RESOURCE_FISH', 'YIELD_FOOD', 1);

----------------------------------------------
-- Gunsmith
----------------------------------------------

UPDATE Buildings
SET CitySupplyFlat = 1
WHERE Type = 'BUILDING_EE_GUNSMITH';

INSERT INTO Building_UnitCombatProductionModifiers (BuildingType, UnitCombatType, Modifier) VALUES 
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_ARMOR', 25),
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_GUN', 25),
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_SIEGE', 25);

INSERT INTO Building_UnitCombatFreeExperiences (BuildingType, UnitCombatType, Experience) VALUES
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_ARMOR', 15),
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_GUN', 15),
('BUILDING_EE_GUNSMITH', 'UNITCOMBAT_SIEGE', 15);
	
----------------------------------------------
-- Japan's UA
----------------------------------------------

INSERT INTO Trait_BuildingClassYieldChanges
		(TraitType, BuildingClassType, YieldType, YieldChange)
SELECT DISTINCT bcyc.TraitType, bc.Type, bcyc.YieldType, bcyc.YieldChange
FROM BuildingClasses bc, Trait_BuildingClassYieldChanges bcyc WHERE bc.Type IN('BUILDINGCLASS_EE_BASTION', 'BUILDINGCLASS_EE_GUNSMITH') AND bcyc.TraitType = 'TRAIT_FIGHT_WELL_DAMAGED';

----------------------------------------------
-- Manor
----------------------------------------------

UPDATE Buildings
SET GreatPeopleRateModifier = 15
WHERE Type = 'BUILDING_EE_MANOR';

----------------------------------------------
-- Drydock
----------------------------------------------

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_ENGINEER' , SpecialistCount = 1, TrainedFreePromotion = 'PROMOTION_EE_DRYDOCK', CitySupplyModifier = 10
WHERE Type = 'BUILDING_EE_DRYDOCK';



------------------------
-- Flavors
------------------------

INSERT INTO Building_Flavors (BuildingType, FlavorType, Flavor) VALUES
('BUILDING_EE_ACADEMY', 'FLAVOR_SCIENCE', 35),
('BUILDING_EE_BASTION', 'FLAVOR_CITY_DEFENSE', 20),
('BUILDING_EE_CLOTH_MILL', 'FLAVOR_PRODUCTION', 25),
('BUILDING_EE_CLOTH_MILL', 'FLAVOR_GOLD', 15),
('BUILDING_EE_DRYDOCK', 'FLAVOR_NAVAL', 30),
('BUILDING_EE_DRYDOCK', 'FLAVOR_MILITARY_TRAINING', 20),
('BUILDING_EE_GALLERY', 'FLAVOR_CULTURE', 20),
('BUILDING_EE_GUNSMITH', 'FLAVOR_MILITARY_TRAINING', 25),
('BUILDING_EE_MANOR', 'FLAVOR_GREAT_PEOPLE', 45),
('BUILDING_EE_MANOR', 'FLAVOR_CULTURE', 15),
('BUILDING_EE_SALON', 'FLAVOR_CULTURE', 35),
('BUILDING_EE_WEIGH_HOUSE', 'FLAVOR_GOLD', 25),
('BUILDING_EE_MENAGERIE', 'FLAVOR_EXPANSION', 6), -- Menagerie / boredom
('BUILDING_EE_MENAGERIE', 'FLAVOR_GROWTH', 6),
('BUILDING_EE_MENAGERIE', 'FLAVOR_CULTURE', 20),
('BUILDING_EE_MENAGERIE', 'FLAVOR_GOLD', 15),
('BUILDING_EE_TAVERN', 'FLAVOR_HAPPINESS', 5),
('BUILDING_EE_TAVERN', 'FLAVOR_EXPANSION', 6), -- Tavern / boredom
('BUILDING_EE_TAVERN', 'FLAVOR_GROWTH', 6);

INSERT INTO Building_UnhappinessNeedsFlatReduction
	(BuildingType, YieldType, Yield)
VALUES
	('BUILDING_EE_ACADEMY', 'YIELD_SCIENCE', 1),
	('BUILDING_EE_SALON', 'YIELD_CULTURE', 1),
	('BUILDING_EE_MENAGERIE', 'YIELD_CULTURE', 1),
	('BUILDING_EE_MANOR', 'YIELD_PRODUCTION', 1),
	('BUILDING_EE_TAVERN', 'YIELD_CULTURE', 1);
----------------------------------------------------
-- Text (en_US)
----------------------------------------------------

INSERT INTO Language_en_US (Tag, Text) VALUES
-- Academy
('TXT_KEY_BUILDING_EE_ACADEMY', 'Academy'),
('TXT_KEY_BUILDING_EE_ACADEMY_HELP', '-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_RESEARCH] Illiteracy. +2 [ICON_RESEARCH] Science in the the city and +1 [ICON_RESEARCH] Science for every 5 [ICON_CITIZEN] Citizens in the City. +15% [ICON_GREAT_SCIENTIST] Great Scientist, [ICON_GREAT_ENGINEER] Great Engineer and [ICON_GREAT_MERCHANT] Great Merchant rate in the City.[NEWLINE][NEWLINE]City must not contain a [COLOR_NEGATIVE_TEXT]Salon[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_ACADEMY_STRATEGY', 'The Academy is an Enlightenment era building which increases the [ICON_RESEARCH] Science output of a city. It may not be built in a city with an Salon, forcing cities to specialise in either Culture or Science.'),
('TXT_KEY_BUILDING_EE_ACADEMY_PEDIA', 'An academy is an organized body of scholars supported by state funding, though generally independent of direct government influence, that coordinates research, establishes standards for their respective fields, and maintain various research facilities within their jurisdiction. The amount of power and influence an academy yields varies considerable between nations. In some, the a single academy may oversee multiple, or all, scientific disciplines, while in others each discipline is guided by its own academy. While academies dedicated to the natural sciences began forming in the 1600s, they truly began to flourish in the 1700s as royalty throughout Europe followed the model set by Frederick III of Prussia when he founded the Prussian Academy of Sciences in 1700.'),
-- Bastion
('TXT_KEY_BUILDING_EE_BASTION', 'Bastion'),
('TXT_KEY_BUILDING_EE_BASTION_HELP', 'Military Units supplied by this City''s population increased by 10%. Increases the City''s [ICON_RANGE_STRENGTH] Ranged Strike Range by 1. Garrisoned units receive an additional 10 Health when healing in this city.[NEWLINE][NEWLINE]Empire [ICON_HAPPINESS_3] Needs Modifier is reduced by 5% in this City.[NEWLINE][NEWLINE]City must have a [COLOR_CYAN]Castle[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_BASTION_STRATEGY', 'The Bastion is an Enlightenment-era military building that increases Defense Strength by 5 and Hit Points by 100, making the city more difficult to capture. Increases the City''s [ICON_RANGE_STRENGTH] Ranged Strike Range by 1. Increases Military Units supplied by this City''s population by 10%. The city must possess a [COLOR_CYAN]Castle[ENDCOLOR] before it can construct a Bastion.'),
('TXT_KEY_BUILDING_EE_BASTION_PEDIA', 'A bastion is an angular projection extending from a fortification, specifically designed to address the changes gunpowder had brought to the landscape of war. Their angular shape eliminated dead space in front of the bastion, allowing neighboring bastions to fire upon enemies should they reach the base. Bastions tend to be short and broad, providing ample room for cannons and their crews while presenting a smaller profile for enemy artillery to attack. Should a cannonball strike the bastion and penetrate its stone facade, the interior of hard-packed earth and rubble would absorb the blow. Advances in artillery during the 19th Century, however, would render even these defensive measures obsolete.'),
-- Cloth Mill
('TXT_KEY_BUILDING_EE_CLOTH_MILL', 'Cloth Mill'),
('TXT_KEY_BUILDING_EE_CLOTH_MILL_HELP', '+3 [ICON_PRODUCTION] Production in the City and +1 [ICON_PRODUCTION] Production for every 4 [ICON_CITIZEN] Citizens in the City. Each source of [ICON_RES_COTTON] Cotton, [ICON_RES_SHEEP] Sheep and [ICON_RES_SILK] Silk worked by this City produces +2 [ICON_GOLD] Gold.[NEWLINE][NEWLINE]City must be built next to a [COLOR_CYAN]River[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_CLOTH_MILL_STRATEGY', 'The Cloth Mill is an Enlightenment-era building which increases the production yield of the city, as well as the gold output of nearby sources of [ICON_RES_COTTON] Cotton, [ICON_RES_SHEEP] Sheep and [ICON_RES_SILK] Silk.'),
('TXT_KEY_BUILDING_EE_CLOTH_MILL_PEDIA', 'A cloth mill is an early mechanized workshop for the production of yarn and cloth that set the stage for the development of factories during the Industrial Revolution. Initially cloth mills were dependent upon fast-moving streams and rivers to drive their water wheels, but in time they would rely upon steam to turn their machinery. The first cloth mills were developed in northern England in 1740s, but soon spread the American colonies and beyond.'),
-- Drydock
('TXT_KEY_BUILDING_EE_DRYDOCK', 'Drydock'),
('TXT_KEY_BUILDING_EE_DRYDOCK_HELP', 'Naval units trained in this city have +15% [ICON_STRENGTH] Combat Strength. Increases the Military Unit Supply Cap from Population in the City by 10%.[NEWLINE][NEWLINE]City must have a [COLOR_CYAN]Harbor[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_DRYDOCK_STRATEGY', 'The Drydock is a late Enlightenment Era building which increases the combat strength of naval units which are trained in the city. Increases the Military Unit Supply Cap from Population in the City .In order to build a Drydock, the city must first contain a Harbor.'),
('TXT_KEY_BUILDING_EE_DRYDOCK_PEDIA', 'A drydock is a rectangular basin that can be flooded and drained to facilitate the construction and maintenance of ships and other watercraft.  Vessels are constructed or repaired in the drydock while it is drained. Once the vessel is ready to set sail, the dock is filled with water. Most drydocks are stationary docks built along the coast, though mobile floating drydocks exist that can take smaller vessels aboard for repairs.'),
-- Gallery
('TXT_KEY_BUILDING_EE_GALLERY', 'Gallery'),
('TXT_KEY_BUILDING_EE_GALLERY_HELP', '+1 [ICON_CULTURE] Culture from [ICON_GREAT_WORK] Great Works and Artist in the City. Contains one Great Work of Art slot. +15% [ICON_GREAT_ARTIST] Great Artist Rate in the City, and all Artists'' Guilds produce +1 [ICON_GOLD] Gold.'),
('TXT_KEY_BUILDING_EE_GALLERY_STRATEGY', 'The Gallery is a Renaissance-era cultural building. It has only one slot for a Great Work of Art or an artifact, but does not require prior Great Work buildings to have been constructed first.'),
('TXT_KEY_BUILDING_EE_GALLERY_PEDIA', 'Galleries are places where art is exhibited, either for the general public or for a private audience. Churches, monasteries, and the palaces of monarchs tended to serve as public galleries in medieval Europe, showcasing religious relics and paintings. Private collections held by nobility were also commonplace, and were often, upon condition, opened to the public.[NEWLINE][NEWLINE]By the 18th century, many of these private collections became nationalised and put on public display in newly established art museums. One of the most prestigious examples is the State Hermitage Museum in Russia, to which Catherine the Great purchased and donated many fine collections of art. Today, public galleries continue to be used as a means to display the cultural pride of a nation.'),
-- Gunsmith
('TXT_KEY_BUILDING_EE_GUNSMITH', 'Gunsmith'),
('TXT_KEY_BUILDING_EE_GUNSMITH_HELP', ' +25% [ICON_PRODUCTION] Production when building Gunpowder, Armor and Siege Units which also receive additional 15 XP. Increases the Military Unit Supply Cap by 2.'),
('TXT_KEY_BUILDING_EE_GUNSMITH_STRATEGY', 'The Gunsmith increases the speed at which the city produces Gunpowder Units.'),
('TXT_KEY_BUILDING_EE_GUNSMITH_PEDIA', 'Gunsmiths are skilled craftsmen devoted to the design, modification, manufacture and repair of firearms. Before the advent of Eli Whitney''s Mill River Armory in the 1790s AD Samuel Colt''s mass production of handguns at his factories in Hartford (USA) and London (UK) in the mid-1800s, the gunsmith shop was a vital establishment in any "civilized" settlement.'),
-- Manor
('TXT_KEY_BUILDING_EE_MANOR', 'Manor'),
('TXT_KEY_BUILDING_EE_MANOR_HELP', '-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_FOOD]/[ICON_PRODUCTION] Distress. +15% Generation of [ICON_GREAT_PEOPLE] Great People.'),
('TXT_KEY_BUILDING_EE_MANOR_STRATEGY', 'Slightly reduces Distress. Increases the rate at which Great People are generated in a city.'),
('TXT_KEY_BUILDING_EE_MANOR_PEDIA', 'During the Middle Ages, the manor house was the dwelling of the lord of the manor (or the residential bailiff) and the administrative center of his feudal estate. The medieval manor was generally fortified in proportion to the degree of peaceful settlement of the country or region in which it was located. It served as the center of secular village life, and its great hall was the scene of the manorial court and the place of assembly of the tenantry. With increased prosperity and the desire for more commodious dwellings, the 16th-century manor house evolved into the Renaissance country house. In England more elaborate buildings were constructed, reflecting a new era of formality. The houses were frequently of regular quadrangular plan, with the hall diminished in size and importance. In later years the title of manor house in England lost particular significance, having been adopted by large country mansions that had no manorial foundation.'),
-- Menagerie
('TXT_KEY_BUILDING_EE_MENAGERIE', 'Menagerie'),
('TXT_KEY_BUILDING_EE_MENAGERIE_HELP', '-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_CULTURE] Boredom. Nearby Jungle and Forest tiles gain +2 [ICON_TOURISM] Tourism and +1 [ICON_CULTURE] Culture. Increases [ICON_RESEARCH] Science, [ICON_CULTURE] Culture and [ICON_GOLD] Gold.[NEWLINE][NEWLINE]City must have a [COLOR_CYAN]Zoo[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_MENAGERIE_PEDIA', 'The oldest known zoological menagerie (or "zoo") has been excavated at Hierakonpolis and dates to c. 3500 BC; the oldest existing zoo, the Tiergarten Schoenbrunn in Vienna, evolved from the exotic animal collection maintained by the Habsburg dynasty and was opened to the public in 1765 AD.'),
('TXT_KEY_BUILDING_EE_MENAGERIE_STRATEGY', 'The Menagerie reduces Boredom in a city, and produces additional Science and Culture. The city must possess a Zoo before the Menagerie can be constructed.'),
-- Salon
('TXT_KEY_BUILDING_EE_SALON', 'Salon'),
('TXT_KEY_BUILDING_EE_SALON_HELP', '-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_CULTURE] Boredom. +2 [ICON_CULTURE] Culture in the the city and +1 [ICON_CULTURE] Culture for every 5 [ICON_CITIZEN] Citizens in the City. +15% [ICON_GREAT_ARTIST] Great Artist, [ICON_GREAT_MUSICIAN] Great Musician and [ICON_GREAT_WRITER] Great Writer rate in the City.[NEWLINE][NEWLINE]City must not contain an [COLOR_NEGATIVE_TEXT]Academy[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_SALON_PEDIA', 'A salon is a place where people would gather to participate in sophisticated discussion. First appearing in Italy during the 16th century, most salons are associated with those which flourished in France during the Enlightenment. There, the wealthy and intellectual would meet in order to entertain and to expand upon their knowledge of refinements such as art, philosophy, and poetry. Salons were often the staging point for the great literary and philosophical movements of the 18th and 19th centuries.'),
('TXT_KEY_BUILDING_EE_SALON_STRATEGY', 'The Salon is an Enlightenment-era building which increases the [ICON_CULTURE] Culture output of a city. It may not be built in a city with an Academy, forcing cities to specialise in either Culture or Science.'),
-- Tavern
('TXT_KEY_BUILDING_EE_TAVERN', 'Tavern'),
('TXT_KEY_BUILDING_EE_TAVERN_HELP', '+2 [ICON_FOOD] Food in the City and -1 [ICON_HAPPINESS_3] Unhappiness from [ICON_CULTURE] Boredom. Nearby [ICON_RES_WHEAT] Wheat, [ICON_RES_DEER] Deer, [ICON_RES_FISH] Fish , [ICON_RES_WINE] Wine and [ICON_RES_BISON] Bison: +1 [ICON_FOOD] Food.'),
('TXT_KEY_BUILDING_EE_TAVERN_STRATEGY', 'The Tavern increases the [ICON_FOOD] Food output of the city.'),
('TXT_KEY_BUILDING_EE_TAVERN_PEDIA', 'Establishments for the dispensation and consumption of alcoholic beverages have been a fixture of cities throughout human civilization. The Babylonian Code of Hammurabi suggests the death penalty for proprietors diluting beer, while the ancient Greek lesche and phatnai catered to the needs of foreign traders and envoys. The traditional English tavern has its roots in the Roman period and, although still considered a place of ill-repute, the taberna was understood as a higher class establishment than the similar caupona which served slaves and the lower classes. Tabernae eventually evolved into alehouses run by women and finally the medieval English inn; sanctuaries for wayfaring strangers, thieves, and political malcontents. By the middle of the 16th century the dining-out habit was well established among townsmen of all classes, and the tavern originated the custom of providing a daily meal at a fixed time. As taverns gradually became more socially acceptable, some of the better houses became regular meeting halls and unofficial clubhouses providing companionship to the masses.'),
-- Weigh House
('TXT_KEY_BUILDING_EE_WEIGH_HOUSE', 'Weigh House'),
('TXT_KEY_BUILDING_EE_WEIGH_HOUSE_HELP', '+3 [ICON_GOLD] Gold in the the city and +1 [ICON_GOLD] Gold for every 5 [ICON_CITIZEN] Citizens in the City. Adds a [ICON_GREAT_MERCHANT] Merchant Specialist.[NEWLINE][NEWLINE]City must have a [COLOR_CYAN]Bank[ENDCOLOR].'),
('TXT_KEY_BUILDING_EE_WEIGH_HOUSE_STRATEGY', 'The weigh house improves the [ICON_GOLD] Gold output of a city. In order to be built, the city must first contain a Bank.'),
('TXT_KEY_BUILDING_EE_WEIGH_HOUSE_PEDIA', 'A weigh house is building in which goods are weighed so that taxes might be reliably levied on trade within a city and that disputes regarding the quantity and quality of trade goods might be accurately resolved. Such buildings might be controlled by the city, merchant guilds, or, more rarely, but foreign merchants granted special privileges within the city. Prior to the spread of international standard measurements, a typical weigh house could be found near a city’s market or center, or within its town hall, guild hall, or courthouse.');

-- Museum
UPDATE Language_en_US
SET Text = '+1 [ICON_CULTURE] Culture for every 4 [ICON_CITIZEN] Citizens in the City. [ICON_GREAT_WORK] Great Works in the City produce +1 [ICON_TOURISM] Tourism. +25% [ICON_GREAT_ARTIST] Great Artist Rate in the City.[NEWLINE][NEWLINE]-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_CULTURE] Boredom.[NEWLINE][NEWLINE]+5 [ICON_CULTURE] Culture if [COLOR_POSITIVE_TEXT]Themed[ENDCOLOR].'
WHERE Tag = 'TXT_KEY_BUILDING_MUSEUM_HELP';


-- Arsenal
UPDATE Language_en_US
SET Text = 'The Arsenal is an Industrial-era military building that increases Defense Strength by 15 and Hit Points by 125, making the city more difficult to capture. Allows the City to Ranged Strike indirectly, ignoring Line of Sight. Increases Military Units supplied by this City''s population by 15%. Also helps with managing the Empire Needs Modifier in this City. The city must possess a Bastion before it can construct an Arsenal.'
WHERE Tag = 'TXT_KEY_BUILDING_ARSENAL_STRATEGY';

UPDATE Language_en_US
SET Text = 'Military Units Supplied by this City''s population increased by 15%. Allows [COLOR_POSITIVE_TEXT]Indirect Fire[ENDCOLOR].[NEWLINE][NEWLINE] Foreign [ICON_SPY] Spies cannot Steal [ICON_RESEARCH] Science from this City.[NEWLINE][NEWLINE]Empire [ICON_HAPPINESS_3] Needs Modifier is reduced by 5% in this City.'
WHERE Tag = 'TXT_KEY_BUILDING_ARSENAL_HELP';


-- Military Base

UPDATE Language_en_US SET Text = Text||'[NEWLINE][NEWLINE]City must have an [COLOR_CYAN]Arsenal[ENDCOLOR].' WHERE Tag IN ('TXT_KEY_BUILDING_MILITARY_BASE_HELP');	
												  
UPDATE Language_en_US
SET Text = 'The Military Base is a late-game building which increases Defensive Strength by 20 and Hit Points by 150, and improves defense against air units. The city must possess an [COLOR_CYAN]Arsenal[ENDCOLOR] before a Military Base may be constructed. Garrisoned units receive an additional 10 Health when healing in this city. Increases Military Units supplied by this City''s population by 20%.'
WHERE Tag = 'TXT_KEY_BUILDING_MILITARY_BASE_STRATEGY';

	  
UPDATE Language_en_US
SET Text = '+1 [ICON_PRODUCTION] Production and [ICON_GOLD] Gold to Camps, Mines, Lumbermills, and Strategic Resources. Increases the City''s [ICON_RANGE_STRENGTH] Ranged Strike Range by 1. Military Units Supplied by this City''s population increased by 15%. Enemy land Units must expend 1 extra [ICON_MOVES] Movement per Tile if they move into a tile worked by this City.[NEWLINE][NEWLINE]Empire [ICON_HAPPINESS_3] Needs Modifier is reduced by 5% in this City.'
WHERE Tag = 'TXT_KEY_BUILDING_KREPOST_HELP';

UPDATE Language_en_US
SET Text = '+1000 [ICON_TOURISM] Tourism with all known Civilizations when completed. When any [ICON_INTERNATIONAL_TRADE] Trade Route originating here and targeting another Civ is completed, receive a [ICON_TOURISM] Tourism boost with the Civ based on your recent [ICON_CULTURE] Culture and [ICON_TOURISM] Tourism output.[NEWLINE][NEWLINE]-1 [ICON_HAPPINESS_3] Unhappiness from [ICON_CULTURE] Boredom.'
WHERE Tag = 'TXT_KEY_BUILDING_THEATRE_HELP';

--====================================================
UPDATE Language_en_US
SET Text = 'May build Amphitheaters, Opera Houses, Gallery, Museums, Broadcast Towers, and Stadiums with [ICON_PEACE] Faith. These buildings produce +2 [ICON_CULTURE] Culture each. Holy City owner gains +1 [ICON_HAPPINESS_1] Happiness for every two Cities following this Religion.'
WHERE Tag = 'TXT_KEY_BELIEF_UNDERGROUND_SECT';

UPDATE Buildings
SET UnlockedByBelief = '1'
WHERE BuildingClass = 'BUILDINGCLASS_EE_GALLERY';

INSERT INTO Belief_BuildingClassYieldChanges
		(BeliefType, BuildingClassType, YieldType, YieldChange)
SELECT DISTINCT BeliefType, 'BUILDINGCLASS_EE_GALLERY', YieldType, YieldChange
FROM Belief_BuildingClassYieldChanges WHERE BeliefType = 'BELIEF_UNDERGROUND_SECT';

INSERT INTO Belief_BuildingClassFaithPurchase
		(BeliefType, BuildingClassType)
SELECT DISTINCT BeliefType, 'BUILDINGCLASS_EE_GALLERY'
FROM Belief_BuildingClassFaithPurchase WHERE BeliefType = 'BELIEF_UNDERGROUND_SECT';

UPDATE Buildings SET FaithCost = 200 WHERE Type = 'BUILDING_EE_GALLERY';