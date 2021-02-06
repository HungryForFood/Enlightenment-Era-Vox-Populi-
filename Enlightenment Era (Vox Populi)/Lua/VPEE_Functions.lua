print("Loading VPEE_Functions.lua from VP-EE mod");

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

--------------------------------------------
-- Fasil Ghebbi
-- Infixo: rewritten, not using PlotIterators, should be much faster
--------------------------------------------

local buildingFasilID = GameInfoTypes.BUILDING_EE_FASIL_GHEBBI
local unitPromotionFasilID = GameInfoTypes.PROMOTION_EE_FASIL_GHEBBI
local fasilAuraRange = 3 --GameDefines.MAXIMUM_ACQUIRE_PLOT_DISTANCE

function CBOEE_Fasil(playerID)
	--print("CBOEE_Fasil() for player; aura range is", playerID, fasilAuraRange);
	local player = Players[playerID]
	if (player:IsAlive() and player:CountNumBuildings(buildingFasilID) == 1) then
		--print("Player owns Fasil");
		local plotFasil
		for city in player:Cities() do
			if city:IsHasBuilding(buildingFasilID) then
				plotFasil = city:Plot()
				--print("Fasil is in", city:GetName());
			end
		end
		for unit in player:Units() do
			if unit:IsCombatUnit() then
				if (Map.PlotDistance(unit:GetX(), unit:GetY(), plotFasil:GetX(), plotFasil:GetY()) <= fasilAuraRange) then
					--print("Unit IN range of Fasil", unit:GetName());
					unit:SetHasPromotion(unitPromotionFasilID, true);
				else
					--print("Unit OUT OF range of Fasil", unit:GetName());
					unit:SetHasPromotion(unitPromotionFasilID, false);
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(CBOEE_Fasil)

local iKronborg = GameInfoTypes["BUILDING_EE_KRONBORG"]
local iKronborgDummy = GameInfoTypes["BUILDING_EE_KRONBORG_DUMMY"]
local HasKronborg = false
local iKronborgOwner
local iKronborgCity
local iVersailles = GameInfoTypes["BUILDING_EE_VERSAILLES"]
local HasVersailles = false 
local iVersaillesOwner
local iVersaillesCity
local tWonderCity = {}
print("Kronborg is", iKronborg, "Kronborg Dummy is", iKronborgDummy, "Versailles is ", iVersailles);

--------------------------------------------
-- Kronborg, Versailles: load game, check if they are built
--------------------------------------------
function OnLoadScreenClose()
for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iKronborg) then
				HasKronborg = true
				iKronborgCity = pCity:GetID()
				iKronborgOwner = i
			end
			if pCity:IsHasBuilding(iVersailles) then
				HasVersailles = true
				iVersaillesCity = pCity:GetID()
				iVersaillesOwner = i
				for pCity in pPlayer:Cities() do
					tWonderCity[pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
				end
			end
		end
	
	end
end
end
Events.LoadScreenClose.Add(OnLoadScreenClose)

--------------------------------------------
-- Kronborg, Versailles: check if wonder was built
--------------------------------------------
function OnCityConstructed (iPlayer, iCity, iBuilding, bGold, bFaith) 
	if iBuilding == iKronborg then
		print("Kronborg constructed by player "..iPlayer.." in city "..iCity);
		HasKronborg = true
		iKronborgCity = iCity
		iKronborgOwner = iPlayer
		local pPlayer = Players[iPlayer]
		for pCity in pPlayer:Cities() do
			if pCity:IsCoastal(10) then
				print("City "..pCity:GetName().." is coastal, so granting Kronborg Dummy...");
				pCity:SetNumRealBuilding (iKronborgDummy, 1);
				--if pCity:GetNumRealBuilding(iKronborgDummy) > 0 then print("...granted ok"); end
			else
				print("City "..pCity:GetName().." is NOT coastal");
			end
		end
	end
	if iBuilding == iVersailles then
		print("Versailles constructed by player "..iPlayer.." in city "..iCity);
		HasVersailles = true
		iVersaillesCity = iCity
		iVersaillesOwner = iPlayer
		local pPlayer = Players[iPlayer]
		for pCity in pPlayer:Cities() do
			local WLTKDCounter = pCity:GetWeLoveTheKingDayCounter()
			if WLTKDCounter > 0 then
				print("WLTKD in city "..pCity:GetName().." for "..WLTKDCounter.." turns will be extended");
				WLTKDCounter = WLTKDCounter + round(WLTKDCounter / 2, 0)
				pCity:SetWeLoveTheKingDayCounter(WLTKDCounter)
			else
				print("No WLTKD in city "..pCity:GetName());
			end
			tWonderCity[pCity:GetID()] = WLTKDCounter
		end
	end
end
GameEvents.CityConstructed.Add(OnCityConstructed)

--------------------------------------------
-- Versailles: decrease WLTKD by 1 or extend by 50%
--------------------------------------------
function EE_Versailles (iPlayer)
	if HasVersailles then
		if iPlayer == iVersaillesOwner then
			local pPlayer = Players[iPlayer]
			if (pPlayer:IsAlive() and pPlayer:CountNumBuildings(iVersailles) == 1) then			
				if pPlayer:IsBarbarian() then return end
				if pPlayer:IsMinorCiv() then return end
				for pCity in pPlayer:Cities() do
					local WLTKDCounter = pCity:GetWeLoveTheKingDayCounter()
					local iCity = pCity:GetID()
					if WLTKDCounter > 0 then 
						if tWonderCity[iCity] < WLTKDCounter then -- no need to check equality (extends by 0?)
							local CounterDiff = WLTKDCounter - tWonderCity[iCity]
							WLTKDCounter = WLTKDCounter + round(CounterDiff / 2, 0)
							pCity:SetWeLoveTheKingDayCounter(WLTKDCounter)
							tWonderCity[iCity] = WLTKDCounter
						else 
							-- this causes the counter to go down twice: 1st by game, 2nd here
							--WLTKDCounter = WLTKDCounter - 1
							--pCity:SetWeLoveTheKingDayCounter(WLTKDCounter)
							tWonderCity[iCity] = WLTKDCounter						
						end
					end
				end
			else
				HasVersailles = false
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(EE_Versailles)

--------------------------------------------
-- Kronborg, Versailles: check if wonder conquered by another player
--------------------------------------------
function OnCityCaptureComplete (iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if HasKronborg then	
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetPlotCity()
		local iConqCity = pConqCity:GetID()
		if iConqCity == iKronborgCity then
			local pOldOwner = Players[iOldOwner]
			for pCity in pOldOwner:Cities() do
				if pCity:IsCoastal(10) then
					pCity:SetNumRealBuilding (iKronborgDummy, 0)
				end
			end
			local pNewOwner = Players[iNewOwner]
			iKronborgOwner = iNewOwner
			for pCity in pNewOwner:Cities() do
				if pCity:IsCoastal(10) then
					pCity:SetNumRealBuilding (iKronborgDummy, 1)
				end
			end		
		else
			if iNewOwner == iKronborgOwner and pConqCity:IsCoastal(10) then
				pConqCity:SetNumRealBuilding (iKronborgDummy, 1)
			end
		end
	end
	if HasVersailles then 
		local pPlot = Map.GetPlot(iX, iY)
		local pConqCity = pPlot:GetPlotCity()
		local iConqCity = pConqCity:GetID()
		if iConqCity == iVersaillesCity then
			iVersaillesOwner = iNewOwner
			local pNewOwner = Players[iNewOwner]
			tWonderCity = {}
			for pCity in pNewOwner:Cities() do
				local WLTKDCounter = pCity:GetWeLoveTheKingDayCounter()
				if WLTKDCounter > 0 then
					WLTKDCounter = WLTKDCounter + round(WLTKDCounter / 2, 0)
					pCity:SetWeLoveTheKingDayCounter(WLTKDCounter)
				end
				tWonderCity[pCity:GetID()] = WLTKDCounter			
			end
		else 
			if iNewOwner == iVersaillesOwner then			
				local WLTKDCounter = pConqCity:GetWeLoveTheKingDayCounter()
				if WLTKDCounter > 0 then
					WLTKDCounter = WLTKDCounter + round(WLTKDCounter / 2, 0)
					pConqCity:SetWeLoveTheKingDayCounter(WLTKDCounter)
				end
				tWonderCity[iConqCity] = WLTKDCounter
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptureComplete)

--------------------------------------------
-- Kronborg, Versailles: check if new city has effects
--------------------------------------------
function OnPlayerCityFounded (iPlayer, iX, iY)
	if HasKronborg then
		if iPlayer == iKronborgOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetPlotCity()
			if pCity:IsCoastal(10) then
				pCity:SetNumRealBuilding (iKronborgDummy, 1)
			end
		end
	end
	if HasVersailles then 
		if iPlayer == iVersaillesOwner then
			local pPlot = Map.GetPlot(iX, iY)
			local pCity = pPlot:GetPlotCity()
			tWonderCity[pCity:GetID()] = pCity:GetWeLoveTheKingDayCounter()
		end
	end
end
GameEvents.PlayerCityFounded.Add(OnPlayerCityFounded)

print("Finished loading VPEE_Functions.lua from VP-EE mod");