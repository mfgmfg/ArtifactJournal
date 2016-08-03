-- our overrides
local ajC_ArtifactUI = {}

local function UpdateDropdown()
  lookupID = oC_ArtifactUI:GetArtifactInfo() or lookupID or 127857
  AJ_dropDown:SetValue(lookupID)
end

local function GetArtifactName(itemID)
  local name = GetItemInfo(itemID) or artifactdb[itemID]["info"][3] -- if we don't have name in cache, use english fallback
  return name
end

local function SetupFunctions()
  if oC_ArtifactUI then return end

  -- original
  oC_ArtifactUI = C_ArtifactUI

  function IsLookupIDCurrent()
    return lookupID == oC_ArtifactUI:GetArtifactInfo()
  end

  ajC_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.DoesEquippedArtifactHaveAnyRelicsSlotted(...) end
    return false
  end

  ajC_ArtifactUI.GetArtifactArtInfo = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetArtifactArtInfo(...) end
    local textureKit, titleName, titleR, titleG, titleB, barConnectedR, barConnectedG, barConnectedB, barDisconnectedR, barDisconnectedG, barDisconnectedB = unpack(artifactdb[lookupID]["artInfo"])
    titleName = GetArtifactName(lookupID)
    return textureKit, titleName, titleR, titleG, titleB, barConnectedR, barConnectedG, barConnectedB, barDisconnectedR, barDisconnectedG, barDisconnectedB
  end

  ajC_ArtifactUI.GetArtifactInfo = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetArtifactInfo(...) end
    return unpack(artifactdb[lookupID]["info"])
  end

  ajC_ArtifactUI.GetArtifactKnowledgeLevel = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetArtifactKnowledgeLevel(...) end
    return 0
  end

  ajC_ArtifactUI.GetArtifactKnowledgeMultiplier = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetArtifactKnowledgeMultiplier(...) end
    return 1
  end

  ajC_ArtifactUI.GetMetaPowerInfo = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetMetaPowerInfo(...) end
    return 211309, 0, 0
  end

  ajC_ArtifactUI.GetNumRelicSlots = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetNumRelicSlots(...) end
    return 3
  end

  ajC_ArtifactUI.GetPointsRemaining = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetPointsRemaining(...) end
    return 0
  end

  ajC_ArtifactUI.GetPowers = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetPowers(...) end
    local ks = {}
    local n = 0
    for k in pairs(artifactdb[lookupID]["powers"]) do
      tinsert(ks,k)
    end
    --table.sort(ks) -- not sure if needed
    return ks
  end

  ajC_ArtifactUI.GetPowersAffectedByRelic = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetPowersAffectedByRelic(...) end
    return -- don't return nil, return empty
  end

  ajC_ArtifactUI.GetPowersAffectedByRelicItemID = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetPowersAffectedByRelicItemID(...) end
    return -- don't return nil, return empty
  end

  ajC_ArtifactUI.GetRelicInfo = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetRelicInfo(...) end
    return nil
  end

  ajC_ArtifactUI.GetRelicInfoByItemID = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetRelicInfoByItemID(...) end
    return nil
  end

  ajC_ArtifactUI.GetRelicSlotType = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetRelicSlotType(...) end
    local relicSlotIndex = ...
    return artifactdb[lookupID]["relicSlots"][relicSlotIndex]
  end

  ajC_ArtifactUI.GetTotalPurchasedRanks = function(...)
    if IsLookupIDCurrent() then return oC_ArtifactUI.GetTotalPurchasedRanks(...) end
    return 34
  end

  ajC_ArtifactUI.IsViewedArtifactEquipped = function(...)
    return IsLookupIDCurrent() and oC_ArtifactUI.IsViewedArtifactEquipped(...)
  end


  ajC_ArtifactUI.AddPower = C_ArtifactUI.AddPower
  ajC_ArtifactUI.ApplyCursorRelicToSlot = C_ArtifactUI.ApplyCursorRelicToSlot
  ajC_ArtifactUI.CanApplyCursorRelicToSlot = C_ArtifactUI.CanApplyCursorRelicToSlot
  ajC_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot = C_ArtifactUI.CanApplyRelicItemIDToEquippedArtifactSlot
  ajC_ArtifactUI.CanApplyRelicItemIDToSlot = C_ArtifactUI.CanApplyRelicItemIDToSlot
  ajC_ArtifactUI.CheckRespecNPC  = C_ArtifactUI.CheckRespecNPC 
  ajC_ArtifactUI.Clear = C_ArtifactUI.Clear
  ajC_ArtifactUI.ClearForgeCamera  = C_ArtifactUI.ClearForgeCamera 
  ajC_ArtifactUI.ConfirmRespec = C_ArtifactUI.ConfirmRespec
  ajC_ArtifactUI.GetAppearanceInfo = C_ArtifactUI.GetAppearanceInfo
  ajC_ArtifactUI.GetAppearanceInfoByID = C_ArtifactUI.GetAppearanceInfoByID
  ajC_ArtifactUI.GetAppearanceSetInfo = C_ArtifactUI.GetAppearanceSetInfo
  ajC_ArtifactUI.GetArtifactXPRewardTargetInfo = C_ArtifactUI.GetArtifactXPRewardTargetInfo -- unused?
  ajC_ArtifactUI.GetCostForPointAtRank  = C_ArtifactUI.GetCostForPointAtRank 

  -- avoid touching these 4
  ajC_ArtifactUI.GetEquippedArtifactArtInfo = C_ArtifactUI.GetEquippedArtifactArtInfo
  ajC_ArtifactUI.GetEquippedArtifactInfo = C_ArtifactUI.GetEquippedArtifactInfo
  ajC_ArtifactUI.GetEquippedArtifactNumRelicSlots  = C_ArtifactUI.GetEquippedArtifactNumRelicSlots 
  ajC_ArtifactUI.GetEquippedArtifactRelicInfo = C_ArtifactUI.GetEquippedArtifactRelicInfo

  ajC_ArtifactUI.GetForgeRotation  = C_ArtifactUI.GetForgeRotation 
  ajC_ArtifactUI.GetItemLevelIncreaseProvidedByRelic = C_ArtifactUI.GetItemLevelIncreaseProvidedByRelic
  ajC_ArtifactUI.GetPowerInfo = C_ArtifactUI.GetPowerInfo
  ajC_ArtifactUI.GetPowerLinks = C_ArtifactUI.GetPowerLinks

  ajC_ArtifactUI.GetPreviewAppearance = C_ArtifactUI.GetPreviewAppearance  

  -- don't touch these 3
  ajC_ArtifactUI.GetRespecArtifactArtInfo = C_ArtifactUI.GetRespecArtifactArtInfo
  ajC_ArtifactUI.GetRespecArtifactInfo = C_ArtifactUI.GetRespecArtifactInfo
  ajC_ArtifactUI.GetRespecCost = C_ArtifactUI.GetRespecCost

  ajC_ArtifactUI.IsAtForge = C_ArtifactUI.IsAtForge
  ajC_ArtifactUI.IsPowerKnown = C_ArtifactUI.IsPowerKnown
  ajC_ArtifactUI.GetNumAppearanceSets = C_ArtifactUI.GetNumAppearanceSets
  ajC_ArtifactUI.GetNumObtainedArtifacts = C_ArtifactUI.GetNumObtainedArtifacts
  ajC_ArtifactUI.SetAppearance = C_ArtifactUI.SetAppearance
  ajC_ArtifactUI.SetForgeCamera = C_ArtifactUI.SetForgeCamera
  ajC_ArtifactUI.SetForgeRotation = C_ArtifactUI.SetForgeRotation
  ajC_ArtifactUI.SetPreviewAppearance = C_ArtifactUI.SetPreviewAppearance
  ajC_ArtifactUI.ShouldSuppressForgeRotation = C_ArtifactUI.ShouldSuppressForgeRotation

  C_ArtifactUI = ajC_ArtifactUI
end

local f = CreateFrame('frame')
f:SetScript('OnEvent', function(self, event, ...)
  if event == 'PLAYER_ENTERING_WORLD' then
    --lookupID = GetInventoryItemID("player", INVSLOT_MAINHAND) or 127857
    lookupID = 127857
    f:RegisterEvent('ARTIFACT_UPDATE')
    f:UnregisterEvent('PLAYER_ENTERING_WORLD')
    for i=1, #artifact_ordered do
      GetItemInfo(artifact_ordered[i])
    end
  elseif event == 'ARTIFACT_UPDATE' then
    UpdateDropdown()
  end
end)
f:RegisterEvent('PLAYER_ENTERING_WORLD')

local function AddDropdown()
  --lookupID = oC_ArtifactUI:GetArtifactInfo() or lookupID or 127857
  if ArtifactFrame and not dropdown then
    AJ_dropDown = CreateFrame("FRAME", "AJDropDown", ArtifactFrame.PerksTab, "UIDropDownMenuTemplate")
    function AJ_dropDown:SetValue(newValue)
      lookupID = newValue
      UIDropDownMenu_SetText(AJ_dropDown, GetArtifactName(lookupID))
      ArtifactFrame:SetupPerArtifactData()
      ArtifactFrame.PerksTab.newItem = true
      ArtifactFrame.PerksTab.perksDirty = true
      ArtifactFrame.PerksTab:TryRefresh()
      ArtifactFrame.PerksTab.TitleContainer:RefreshTitle()
      ArtifactFrame.PerksTab.TitleContainer:EvaluateRelics();
      ArtifactFrame.PerksTab.finalPowerButton:Show()
    end
    -- Create the dropdown, and configure its appearance
    AJ_dropDown:SetPoint("BOTTOMRIGHT", ArtifactFrame, "BOTTOMRIGHT")
    UIDropDownMenu_SetWidth(AJ_dropDown, 250)
    UIDropDownMenu_SetText(AJ_dropDown, GetArtifactName(lookupID))

    -- Create and bind the initialization function to the dropdown menu
    UIDropDownMenu_Initialize(AJ_dropDown, function(self, menuList)
      local info = UIDropDownMenu_CreateInfo()
      info.func = self.SetValue
      for i=1, #artifact_ordered do
        local aid = artifact_ordered[i]
        local _, specName, _, icon, _, _, class = GetSpecializationInfoByID(artifact_spec[aid])
        local classColor = RAID_CLASS_COLORS[class].colorStr
        info.text, info.arg1, info.checked = GetArtifactName(aid).." - |c"..classColor..specName, aid, aid == lookupID
        UIDropDownMenu_AddButton(info)
      end
    end)
  end
end

SLASH_AJ1, SLASH_AJ2 = '/aj', '/artifactjournal';
function SlashCmdList.AJ(msg, editbox)
  SetupFunctions()
  AddDropdown()
  ShowUIPanel(ArtifactFrame)
  UpdateDropdown()
end