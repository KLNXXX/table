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

--- get the length of a table/array
function table.length(tbl)
    local count = 0

    for k, v in pairs(tbl) do
        count = count + 1
    end

    return count
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

--- converts string to array
function table.array(input)
    local txt = {}

    for i = 1, input:len() do
        txt[i] = input:sub(i, i)
    end

    return txt
end

--- merge contents of two tables
--- will overwrite content of tbl if both keys are the same
function table.merge(tbl1, tbl2)
    for k, v in pairs(tbl2) do
        if (type(v) == "table") then
            if (type(tbl1[k] or false) == "table") then
                table.merge(tbl1[k] or {}, tbl2[k] or {})
            else
                tbl1[k] = v
            end
        else
            tbl1[k] = v
        end
    end

    return tbl1
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

--- fill an array with values
function table.fill(tbl, val, from, to)
    for idx = from, to do
        tbl[idx] = val
    end

    return tbl
end

--- dumps out all values of a array/dict
local function _addType(main, _type)
    return ("%s : %s"):format(main, _type)
end

function table.dump(o, addTypes)
    --- luau support
    local type = typeof or type
    local txt = tostring
    local objType = type(o)
    
    if (objType == 'table') then
        local tblLength = table.length(o)
        local iteration = 0
        local s = '{'

        for k, v in pairs(o) do
            iteration = iteration + 1

            if type(k) ~= 'number' then k = ("\'%s\'"):format(k) end
            s = s .. ("[%s] = %s"):format(k, table.dump(v, addTypes))

            if (iteration < tblLength) then
                s = s .. ", "
            end
        end

        return s .. '} '
    elseif (objType == 'string') then
        if (addTypes) then
            return _addType(("\'%s\'"):format(txt(o)), objType)
        else
            return ("\'%s\'"):format(txt(o))
        end
    elseif (objType == 'number') then
        if (addTypes) then
            return _addType(txt(o), objType)
        else
            return txt(o)
        end
    end
end

--- export
return table