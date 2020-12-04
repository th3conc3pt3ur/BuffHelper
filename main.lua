--[[buff list 

Spell_Holy_WordFortitude = 21562
Ability_Warrior_BattleShout = 6673
Spell_Holy_MagicalSentry = 1459
]]
local btn = CreateFrame("Button", "myButton", UIParent, "SecureActionButtonTemplate");
btn:SetAttribute("type", "spell");
btn:SetAttribute("unit","player");
btn:SetPoint('CENTER');
btn:SetSize(32, 32)
btn:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
btn:SetScript("OnEvent", CheckIcon)
btn:SetScript('OnClick', function()
    btn:Hide()
end)
btn:Hide();

function IterateQueriableEffect(qFunc, unit, matchTexture, id, castable)
    id = id or 1;--default value, making id optional;
    while true do
        local name, rank, texture, count, type, duration, timeleft = qFunc(unit, id, castable);
        if not name then
            break;
        end
        if string.match(texture, matchTexture) then
            id = id - 1;
            if id == 0 then
                return name, rank, texture, count, type, duration, timeleft;
            end
        end
    end
end
function HaveBuff(target,buff)
    name, rank, texture, count, duration, timeleft = IterateQueriableEffect(UnitBuff, target,buff);
    if not name then
        return false;
    else 
        return true;
    end
end
function CheckIcon()
    local member
    local areAllBuff = true
    local playerClass, englishClass = UnitClass("player");

    if not HaveBuff("player","Spell_Holy_WordFortitude") then areAllBuff = false end
    if not HaveBuff("player","Ability_Warrior_BattleShout") then areAllBuff = false end
    if not HaveBuff("player","Spell_Holy_MagicalSentry") then areAllBuff = false end
    
    --[[name, rank, texture, count, duration, timeleft = IterateQueriableEffect(UnitBuff, "player", "Spell_Holy_WordFortitude");
    if not name then
        areAllBuff = false
    end
    name, rank, texture, count, duration, timeleft = IterateQueriableEffect(UnitBuff, "player", "Ability_Warrior_BattleShout");
    if not name then
        areAllBuff = false
    end
    name, rank, texture, count, duration, timeleft = IterateQueriableEffect(UnitBuff, "player", "Spell_Holy_MagicalSentry");
    if not name then
        areAllBuff = false
    end
    ]]
    local members = GetNumGroupMembers()
    if members > 0 then
        for groupIndex = 1, members do
            --member = GetMember("party"..groupIndex)
            if englishClass == "PRIEST" then
                if not HaveBuff("party"..groupIndex,"Spell_Holy_WordFortitude") then areAllBuff = false end
            end
            if englishClass == "WARRIOR" then
                if not HaveBuff("party"..groupIndex,"Ability_Warrior_BattleShout") then areAllBuff = false end
            end
            if englishClass == "MAGE" then
                if not HaveBuff("party"..groupIndex,"Spell_Holy_MagicalSentry") then areAllBuff = false end
            end
        end
    end
    if areAllBuff == false then
        --display button for buff
        -- button for Spell_Holy_WordFortitude = 21562
        if englishClass == "PRIEST" then
            name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(21562);
            btn:SetAttribute("spell", name);
        end
        if englishClass == "WARRIOR" then
            --Ability_Warrior_BattleShout = 6673
            name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(6673);
            btn:SetAttribute("spell", name);
        end
        if englishClass == "MAGE" then
            --Spell_Holy_MagicalSentry = 1459
            name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(1459);
            btn:SetAttribute("spell", name);
        end
        btn:Show()
    end
end