local spell_holy_wordfortitude
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
local member
local areAllBuff = true
for groupIndex = 1, 4 do
    --member = GetMember("party"..groupIndex)
    name, rank, texture, count, duration, timeleft = IterateQueriableEffect(UnitBuff, "party"..groupIndex, "Spell_Holy_WordFortitude");
    if name then
        --message("Player is buffed with " .. name .. " (" .. rank .. ")");
    else
        --message("Player is not buffed with Mark of the Wild.");
        areAllBuff = false
    end
end
if areAllBuff == false then
    --display button for buff
end 
