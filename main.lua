function love.load()
    Classe = require "assets/Recursos/classic"
    Vetor = require "assets/Recursos/vector"
    anim = require "assets.Recursos.anim8"

    --sti = require 'assets/Recursos/sti'
    --gameMap = sti('assets/imagens/Map/map.lua', a, 1, 1)

    cenario = require "assets.classes.cenario"
    cenario = Cenario()

    camera = require "assets.Recursos.camera"
    cam = camera()

    require "assets.classes.boss"
    boss = Boss()

    require "assets/classes.hero"
    hero = Hero()

    require "assets/classes.inimigo01"
    enemy01 = Enemy01()

    require "assets/classes.inimigo02"
    enemy02 = Enemy02()

    require "assets.classes.npc"
    npc = NPC()

end

function love.update(dt)
    boss:update(dt)
    hero:update(dt)
    enemy01:update(dt)
    enemy02:update(dt)
    npc:update(dt)

    cam:lookAt(hero.x, hero.y)
end

function love.draw()
    cam:attach()
        cenario:draw()
        npc:draw()
        boss:draw()
        hero:draw()
        enemy01:draw()
        enemy02:draw()
    cam:detach()

    --gameMap:draw(1,1,1,1)

    -- Status

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 10, 10, hero.Hp, 10) -- hp
    love.graphics.setColor(1, 1, 1)

    love.graphics.setColor(0, 0, 1)
    love.graphics.rectangle("fill", 10, 30, hero.Mana, 10) -- mana
    love.graphics.setColor(1, 1, 1)
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

-- Function to check collision between triangle and circle
function TriangleCircle(ax, ay, bx, by, cx, cy, dx, dy, r)
    -- Get the center and radius of the circle
    local cx, cy, r = dx, dy, r

    -- Get the vertices of the triangle
    local ax, ay = ax, ay
    local bx, by = bx, by
    local cx, cy = cx, cy

    -- Check if the center of the circle is inside the triangle
    if pointInTriangle(dx, dy, ax, ay, bx, by, cx, cy) then
        return true
    end

    -- Check if any of the edges of the triangle intersect with the circle
    if lineCircleIntersection(ax, ay, bx, by, cx, cy, dx, dy, r) then
        return true
    end
    if lineCircleIntersection(bx, by, cx, cy, ax, ay, dx, dy, r) then
        return true
    end
    if lineCircleIntersection(cx, cy, ax, ay, bx, by, dx, dy, r) then
        return true
    end

    -- No collision
    return false
end

-- Function to check if a point is inside a triangle
function pointInTriangle(dx, dy, ax, ay, bx, by, cx, cy)
    -- Compute the barycentric coordinates of the point
    local u = ((cx - bx) * (dy - by) - (cy - by) * (dx - bx)) / ((cy - by) * (ax - bx) - (cx - bx) * (ay - by))
    local v = ((ax - cx) * (dy - cy) - (ay - cy) * (dx - cx)) / ((by - cy) * (ax - cx) - (ay - cy) * (bx - cx))
    local w = 1 - u - v

    -- Check if the point is inside the triangle
    if u >= 0 and v >= 0 and w >= 0 then
        return true
    end
    return false
end

-- Function to check if a line intersects with a circle
function lineCircleIntersection(ax, ay, bx, by, cx, cy, dx, dy, r)
    -- Compute the distance between the line and the center of the circle
    local dist = math.abs((dy - cy) * (bx - ax) - (dx - cx) * (by - ay)) / math.sqrt((by - ay) ^ 2 + (bx - ax) ^ 2)

    -- Check if the distance is less than the radius of the circle
    if dist < r then
        return true
    end
    return false
end
-- 
