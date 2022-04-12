DIST_SPEED = {
    CONST_DIST_CLOSE = 19.0,
    CONST_DIST_NORMAL = 20.0,
    CONST_DIST_DIVE = 15.0,
}

function ComputeAfterHitVelocity(heading, distName, isServe)
    heading = heading * -1 -- dont know why -1, but inverting court heading fixes stuff
    local isW = IsDisabledControlPressed(0, 32)
    local isS = IsDisabledControlPressed(0, 33)
    local isA = IsDisabledControlPressed(0, 34)
    local isD = IsDisabledControlPressed(0, 35)

    -- W/S/(nothing) - Z axis
    -- A/D/(nothing) - left/right
   
    local vertDist = 0.25
    local fwdDist = 0.9
    local horizontalDist = 0.0

    if isServe then
        vertDist = 0.15
    end

    if isW and isA then
        vertDist = 0.15
        fwdDist = 1.15
        horizontalDist = -0.25
    elseif isW and isD then
        vertDist = 0.15
        fwdDist = 1.15
        horizontalDist = 0.25
    elseif isS and isA then
        if isServe then
            horizontalDist = -0.35
        else
            vertDist = 0.2
            fwdDist = 0.2
            horizontalDist = -0.2
        end
    elseif isS and isD then
        if isServe then
            horizontalDist = 0.35
        else
            vertDist = 0.2
            fwdDist = 0.2
            horizontalDist = 0.2
        end
    elseif isA then
        if isServe then
            horizontalDist = -0.25
        else
            horizontalDist = -0.19
        end
    elseif isD then
        if isServe then
            horizontalDist = 0.25
        else
            horizontalDist = 0.19
        end
    elseif isW then
        vertDist = 0.15
        fwdDist = 1.15
    elseif isS then
        vertDist = 0.3
        fwdDist = 0.5
    end

    -- randomize
    rndHorizontalDist = math.random(-1000, 1000)/30000
    rndFwdDist = math.random(0, 1000)/30000
    rndVertDist = math.random(-500, 1000)/30000

    local finalStraightVelocity = vector3(horizontalDist + rndHorizontalDist, fwdDist + rndFwdDist, vertDist + rndVertDist) * DIST_SPEED[distName]

    local adjustedVec = rotateVec3(finalStraightVelocity, vector3(0.0, 0.0, 1.0), math.rad(heading))

    print(adjustedVec)
    return adjustedVec
end

function applyMatrixRowsToVec3(v, r1, r2, r3)
    -- Let M be a matrix with rows r1, r2, and r3. Return M*v.
    local dot1 = v.x * r1.x + v.y * r1.y + v.z * r1.z
    local dot2 = v.x * r2.x + v.y * r2.y + v.z * r2.z
    local dot3 = v.x * r3.x + v.y * r3.y + v.z * r3.z

    return vector3(dot1, dot2, dot3)
end
    

function rotationVectors(u, angle)
-- Returns three 3D vectors corresponding to the rows of a matrix
-- implementing a rotation of the given angle around the given axis.
    
    -- The following is pretty efficient, but using whole-matrix operations as is
    -- done above is faster still. Also, this expanded form requires a unit vector u.
    local c = math.cos(angle)
    local s = math.sin(angle)
    local d = 1-c
    local su = s*u
    local du = d*u
    local r1 = du.x*u + vector3(c, su.z, -su.y)
    local r2 = du.y*u + vector3(-su.z, c, su.x)
    local r3 = du.z*u + vector3(su.y, -su.x, c)
    return r1, r2, r3
end

function rotateVec3(v, u, angle)
--  Return vector v rotated angle degrees around vector u.
    return applyMatrixRowsToVec3(v, rotationVectors(u, angle))
end
