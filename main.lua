local my_font = love.graphics.newFont('assets/Recursos/alagard.ttf')

function love.load()
    Classe = require "assets/Recursos/classic"
    Vetor = require "assets/Recursos/vector"
    anim = require "assets.Recursos.anim8"

    cenario = require "assets.classes.cenario"
    cenario = Cenario()

    camera = require "assets.Recursos.camera"
    cam = camera()

    require "assets.classes.boss"
    boss = Boss()

    require "assets/classes.hero"
    hero = Hero()

    require "assets.classes.puzzles"
    puzzles = Puzzles()

    require "assets/classes.inimigo01"
    enemy01 = Enemy01()

    require "assets/classes.inimigo02"
    enemy02 = Enemy02()

    require "assets.classes.npc"
    npc = NPC()

    require "assets.classes.cenas"
    cenas = Cenas()

end

function love.update(dt)
    cenas:update(dt)
end

function love.draw()
    love.graphics.setFont(my_font)
    cenas:draw()
end

function circleRectInterno(cx, cy, radius, rx, ry, rw, rh)

    if (cx + radius > rx and rx + rw > cx + radius) and (cy + radius > ry and ry + rh > cy + radius) then
        return true
    end
    return false
end

function RangeVisao(a, Va, Vb)
    local DistVetores = math.sqrt((Va.x - Vb.x) ^ 2 + (Va.y - Vb.y) ^ 2)
    if a >= DistVetores then
        return true
    else
        return false
    end
end

function MouseSelection(a, b, x, y)
    local mx, my = love.mouse.getPosition()
    if mx >= x and mx <= x + a and my >= y and my <= y + b then
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

function TriangleCircle(ax, ay, bx, by, cx, cy, dx, dy, r)
    local cx, cy, r = dx, dy, r

    local ax, ay = ax, ay
    local bx, by = bx, by
    local cx, cy = cx, cy

    if pointInTriangle(dx, dy, ax, ay, bx, by, cx, cy) then
        return true
    end

    if lineCircleIntersection(ax, ay, bx, by, cx, cy, dx, dy, r) then
        return true
    end
    if lineCircleIntersection(bx, by, cx, cy, ax, ay, dx, dy, r) then
        return true
    end
    if lineCircleIntersection(cx, cy, ax, ay, bx, by, dx, dy, r) then
        return true
    end

    return false
end

function pointInTriangle(dx, dy, ax, ay, bx, by, cx, cy)
    local u = ((cx - bx) * (dy - by) - (cy - by) * (dx - bx)) / ((cy - by) * (ax - bx) - (cx - bx) * (ay - by))
    local v = ((ax - cx) * (dy - cy) - (ay - cy) * (dx - cx)) / ((by - cy) * (ax - cx) - (ay - cy) * (bx - cx))
    local w = 1 - u - v

    if u >= 0 and v >= 0 and w >= 0 then
        return true
    end
    return false
end

function lineCircleIntersection(ax, ay, bx, by, cx, cy, dx, dy, r)
    local dist = math.abs((dy - cy) * (bx - ax) - (dx - cx) * (by - ay)) / math.sqrt((by - ay) ^ 2 + (bx - ax) ^ 2)

    if dist < r then
        return true
    end
    return false
end
-- 

-- linha circulo
function lineCircle(x1, y1, x2, y2, cx, cy, r)

    local inside1 = pointCircle(x1, y1, cx, cy, r)
    local inside2 = pointCircle(x2, y2, cx, cy, r)
    if inside1 or inside2 then
        return true
    end

    local distX = x1 - x2
    local distY = y1 - y2
    local len = math.sqrt((distX * distX) + (distY * distY))

    local dot = (((cx - x1) * (x2 - x1)) + ((cy - y1) * (y2 - y1))) / math.pow(len, 2)

    local closestX = x1 + (dot * (x2 - x1))
    local closestY = y1 + (dot * (y2 - y1))

    local onSegment = linePoint(x1, y1, x2, y2, closestX, closestY)
    if not onSegment then
        return false
    end

    distX = closestX - cx
    distY = closestY - cy
    local distance = math.sqrt((distX * distX) + (distY * distY))

    if distance <= r then
        return true
    end
    return false
end

function pointCircle(px, py, cx, cy, r)

    local distX = px - cx
    local distY = py - cy
    local distance = math.sqrt((distX * distX) + (distY * distY))

    if distance <= r then
        return true
    end
    return false
end

function linePoint(x1, y1, x2, y2, px, py)
    local d1 = dist(px, py, x1, y1)
    local d2 = dist(px, py, x2, y2)

    local lineLen = dist(x1, y1, x2, y2)

    local buffer = 0.1

    if d1 + d2 >= lineLen - buffer and d1 + d2 <= lineLen + buffer then
        return true
    end
    return false
end

function dist(x1, y1, x2, y2)
    local distX = x2 - x1
    local distY = y2 - y1
    return math.sqrt((distX * distX) + (distY * distY))
end
