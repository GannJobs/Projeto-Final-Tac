function love.load()
    Classe = require "assets/Recursos/classic"
    Vetor = require "assets/Recursos/vector"
    anim = require "assets.Recursos.anim8"

    require "assets/classes.hero"
    hero = Hero()

    require "assets/classes.inimigo01"
    enemy01 = Enemy01()

    require "assets/classes.inimigo02"
    enemy02 = Enemy02()

end

function love.update(dt)
    hero:update(dt)
    enemy01:update(dt)
    enemy02:update(dt)
end

function love.draw()
    hero:draw()
    enemy01:draw()
    enemy02:draw()
end

function RangeVisao(a, Va, Vb)
    local DistVetores = math.sqrt((Va.x - Vb.x) ^ 2 + (Va.y - Vb.y) ^ 2)
    if a >= DistVetores then
        return true
    else
        return false
    end
end

function RangeAttack(a, b, Va, Vb)
    local DistVetores = math.sqrt((Va.x - Vb.x) ^ 2 + (Va.y - Vb.y) ^ 2)
    if a + b >= DistVetores then
        return true
    else
        return false
    end
end

function circleRect(cx, cy, radius, rx, ry, rw, rh)

    local testX = cx;
    local testY = cy;

    if cx < rx then
        testX = rx
    else
        if cx > rx + rw then
            testX = rx + rw
        end
    end

    if cy < ry then
        testY = ry
    else
        if cy > ry + rh then
            testY = ry + rh
        end
    end

    local distX = cx - testX;
    local distY = cy - testY;
    local distance = math.sqrt((distX * distX) + (distY * distY));

    if (distance <= radius) then
        return true;
    end
    return false;

end

-- colisao do triangulo com o circulo da skill - 1
function PolyCircle(x1,y1,x2,y2,x3,y3,C,r)

    local collision = LineCircle(x1,y1,x2,y2,C.x,C.y,r)
    if collision then
        return true
    end
    collision = LineCircle(x1,y1,x3,y3,C.x,C.y,r)
    if collision then
        return true
    end
    collision = LineCircle(x2,y2,x3,y3,C.x,C.y,r)
    if collision then
        return true
    end
    return false
    
end
-- 
