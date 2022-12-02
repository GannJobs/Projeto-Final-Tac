function love.load()
    Classe = require "assets/Recursos/classic"
    Vetor = require "assets/Recursos/vector"
    
    require "assets/classes.hero"
    hero = Hero()

    -- require "Classes.Map"
    -- map = Map()

    -- require "Classes.Enemy"
    -- enemy = Enemy()

end

function love.update(dt)
    hero:update(dt)
end

function love.draw()
    hero:draw()
end

function Range(a, b, Va, Vb)
    local DistVetores = math.sqrt((Va.x-Vb.x)^2 + (Va.y-Vb.y)^2)
    if a + b >= DistVetores then
        return true
    else 
        return false
    end
end