Cenario = Classe:extend()

function Cenario:new()

    self.Mapa1 = love.graphics.newImage("assets/imagens/Map/MapAllBlock.png")
    self.Mapa2 = love.graphics.newImage("assets/imagens/Map/MapFireBlock.png")
    self.Mapa3 = love.graphics.newImage("assets/imagens/Map/MapSwordBlock.png")
    self.Mapa4 = love.graphics.newImage("assets/imagens/Map/MapUnlocked.png")

    -- salas
    -- caixa Boss
    self.CaixaBoss = {
        x = 538 * 1.5,
        y = 106 * 1.5,
        width = 710 * 1.5,
        heigth = 475 * 1.5
    }
    -- caixa Dog
    self.CaixaDog = {
        x = 1360 * 1.5,
        y = 1020 * 1.5,
        width = 340 * 1.5,
        heigth = 380 * 1.5
    }
    -- caixa Men
    self.CaixaMen = {
        x = 70 * 1.5,
        y = 1020 * 1.5,
        width = 360 * 1.5,
        heigth = 380 * 1.5
    }
    -- caixas puzzles
    self.CaixaPuzzle = {
        caixa1 = {
            x = 60 * 1.5,
            y = 422 * 1.5,
            width = 360 * 1.5,
            heigth = 380 * 1.5
        },
        caixa2 = {
            x = 1354 * 1.5,
            y = 426 * 1.5,
            width = 360 * 1.5,
            heigth = 320 * 1.5
        },
        tesouro1 = {
            x = 150 * 1.5,
            y = 120 * 1.5,
            width = 190 * 1.5,
            heigth = 150 * 1.5
        },
        tesouro2 = {
            x = 1444 * 1.5,
            y = 106 * 1.5,
            width = 160 * 1.5,
            heigth = 150 * 1.5
        }
    }
    self.SalaSpawn = {
        x = 815 * 1.5,
        y = 1500 * 1.5,
        width = 190 * 1.5,
        heigth = 176 * 1.5
    }
    self.SalaNpc = {
        x = 769 * 1.5,
        y = 1102 * 1.5,
        width = 280 * 1.5,
        heigth = 200 * 1.5
    }
    self.SalaPreBos = {
        x = 820 * 1.5,
        y = 701 * 1.5,
        width = 170 * 1.5,
        heigth = 150 * 1.5
    }
    -- corredores
    self.CorredorSpawnNPC = {
        x = 885 * 1.5,
        y = 1289 * 1.5,
        width = 43 * 1.5,
        heigth = 244 * 1.5
    }
    self.CorredorNPCMen = {
        x = 413 * 1.5,
        y = 1171 * 1.5,
        width = 380 * 1.5,
        heigth = 74 * 1.5        
    }
    self.CorredorNPCDog = {
        x = 1020 * 1.5,
        y = 1169 * 1.5,
        width = 340 * 1.5,
        heigth = 70 * 1.5
    }
    self.CorredorMenT1 = {
        x = 219 * 1.5,
        y = 739 * 1.5,
        width = 75 * 1.5,
        heigth = 400 * 1.5
    }
    self.CorredorDogT2 = {
        x = 1505 * 1.5,
        y = 772 * 1.5,
        width = 59 * 1.5,
        heigth = 268 * 1.5
    }
    self.CorredorT1Skill = {
        x = 219 * 1.5,
        y = 266 * 1.5,
        width = 50 * 1.5,
        heigth = 190 * 1.5
    }
    self.CorredorT2Skill = {
        x = 1498 * 1.5,
        y = 234 * 1.5,
        width = 54 * 1.5,
        heigth = 215 * 1.5
    }
    self.CorredorNPCpboss = {
        x = 875 * 1.5,
        y = 935 * 1.5,
        width = 65 * 1.5,
        heigth = 186 * 1.5
    }
    self.CorredorpbossBoss = {
        x = 885 * 1.5,
        y = 572 * 1.5,
        width = 45 * 1.5,
        heigth = 160 * 1.5
    }
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

    love.graphics.rectangle("fill", self.CaixaDog.x, self.CaixaDog.y, self.CaixaDog.width, self.CaixaDog.heigth)
    love.graphics.rectangle("fill", self.CaixaMen.x, self.CaixaMen.y, self.CaixaMen.width, self.CaixaMen.heigth)

end
