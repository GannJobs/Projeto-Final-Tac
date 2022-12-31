Cenario = Classe:extend()

function Cenario:new()

    self.image = love.graphics.newImage("assets/imagens/Map/New Piskel.png")
    
end

function Cenario:update(dt)

end

function Cenario:draw()
    love.graphics.draw(self.image, 0, 0, 0, 1.5, 1,5)
    love.graphics.rectangle("fill", -2 , 930, 530, 400) -- quadrados soldados
    love.graphics.rectangle("fill", 1850 , 930, 530, 400) -- quadrados cachorros
end