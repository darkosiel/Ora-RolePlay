-- Better optimized function than the fivem one (https://github.com/GoatG33k/FiveM-dist-calc-perf-testing#results)
function getDistanceBetweenCoords(a, b, c, d, e, f)
    local v1 = type(a) == "vector3" and a or vector3(a, b, c)
    local v2 = type(a) == "vector3" and (type(b) == "vector3" and b or (type(b) == "table" and vector3(b[1], b[2], b[3]) or vector3(b, c, d))) or vector3(d, e, f)
    return #(v1 - v2)
end
