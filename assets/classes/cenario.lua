Cenario = Classe:extend()

function Cenario:new()

    self.Mapa1 = love.graphics.newImage("assets/imagens/Map/MapAllBlock.png")
    self.Mapa2 = love.graphics.newImage("assets/imagens/Map/MapFireBlock.png")
    self.Mapa3 = love.graphics.newImage("assets/imagens/Map/MapSwordBlock.png")
    self.Mapa4 = love.graphics.newImage("assets/imagens/Map/MapUnlocked.png")

end

function Cenario:update(dt)

end

function Cenario:draw()
    if puzzles.Gate1Open and puzzles.Gate2Open then
        love.graphics.draw(self.Mapa4, 0, 0, 0, 1.5, 1.5)
    else
        love.graphics.draw(self.Mapa1, 0, 0, 0, 1.5, 1.5)
        if puzzles.Gate1Open then
            love.graphics.draw(self.Mapa2, 0, 0, 0, 1.5, 1.5)
        end
        if puzzles.Gate2Open then
            love.graphics.draw(self.Mapa3, 0, 0, 0, 1.5, 1.5)
        end
    end
end
