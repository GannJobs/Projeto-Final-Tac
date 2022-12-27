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

function distance_to_line(point, line)
    local A, B, C = line[1], line[2], point
    local d = math.abs((A.x - C.x) * (B.y - C.y) - (A.y - C.y) * (B.x - C.x)) /
      math.sqrt((B.y - C.y) ^ 2 + (B.x - C.x) ^ 2)
    return d
  end
  
  -- função para detectar a colisão entre um triângulo e um círculo
  function triangle_circle_collision(triangle, circle)
    -- verifica se o centro do círculo está dentro do triângulo
    if point_in_triangle(circle.center, triangle) then
      return true
    end
  
    -- verifica se algum lado do triângulo atravessa o círculo
    for i = 1, 3 do
      local j = (i % 3) + 1
      local side = {triangle[i], triangle[j]}
      local d = distance_to_line(circle.center, side)
      if d < circle.radius then
        return true
      end
    end
  
    return false
  end
  
-- 
