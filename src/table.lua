local oldTable = table
local table = oldTable

--- get the index of a value
function table.indexOf(tbl, value)
    for i, v in pairs(tbl) do
        if v == value then
            return i
        end
    end

    return nil
end

--- get middle value of an array
function table.getMiddle(array)
    return array[math.floor((#array / 2) + 0.5)]
end

--- reverse iterator func
function table.rpairs(t)
    return function(t, i)
        i = i - 1
        if i ~= 0 then
            return i, t[i]
        end
    end, t, #t + 1
end

--- slices the values of an array
function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end

    return sliced
end

--- lua 5.1 does not have table.find
function table.find(tbl, item)
    for i = 1, #tbl do
        if tbl[i] == item then
            return true
        end
    end

    return false;
end

--- dictionary support
function table.drop(tbl, value)
    local alreadyRemoved = false
    local newTbl = tbl

    for k, v in pairs(tbl) do
        if (not alreadyRemoved) then
            if (v == value) then
                newTbl[k] = nil
            end
        else
            break
        end
    end

    return newTbl
end

--- dumps out all values of a array/dict
function table.dump(o)
    local objType = type(o)
    if (objType == 'table') then
        local s = '{ '
            for k,v in pairs(o) do
                if type(k) ~= 'number' then k = '"'..k..'"' end
                s = s .. '['..k..'] = ' .. table.dump(v) .. ', '
            end
        return s .. '} '
    elseif (objType == 'string') then
        return ("\'%s\'"):format(tostring(o))
    elseif (objType == 'number') then
        return tostring(o)
    end
end

--- export
return table