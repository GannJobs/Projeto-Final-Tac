Cenario = Classe:extend()

function Cenario:new()

    self.image = love.graphics.newImage("assets/imagens/Map/New Piskel.png")
    
end

function Cenario:update(dt)

end

function Cenario:draw()
    love.graphics.draw(self.image, 0, 0, 0, 1.5, 1,5)
end