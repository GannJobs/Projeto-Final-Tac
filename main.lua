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
