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
    local Corredor1 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorSpawnNPC.x, self.CorredorSpawnNPC.y, self.CorredorSpawnNPC.width, self.CorredorSpawnNPC.heigth)
    -- local Corredor2 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorNPCMen.x, self.CorredorNPCMen.y, self.CorredorNPCMen.width, self.CorredorNPCMen.heigth)
    -- local Corredor3 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorMenT1.x, self.CorredorMenT1.y, self.CorredorMenT1.width, self.CorredorMenT1.heigth)
    -- local Corredor4 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorT1Skill.x, self.CorredorT1Skill.y, self.CorredorT1Skill.width, self.CorredorT1Skill.heigth)
    -- local Corredor5 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorNPCDog.x, self.CorredorNPCDog.y, self.CorredorNPCDog.width, self.CorredorNPCDog.heigth)
    -- local Corredor6 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorDogT2.x, self.CorredorDogT2.y, self.CorredorDogT2.width, self.CorredorDogT2.heigth)
    -- local Corredor7 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorT2Skill.x, self.CorredorT2Skill.y, self.CorredorT2Skill.width, self.CorredorT2Skill.heigth)
    -- local Corredor8 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorNPCpboss.x, self.CorredorNPCpboss.y, self.CorredorNPCpboss.width, self.CorredorNPCpboss.heigth)
    -- local Corredor9 = circleRectInterno(hero.x, hero.y, hero.Contato, self.CorredorpbossBoss.x, self.CorredorpbossBoss.y, self.CorredorpbossBoss.width, self.CorredorpbossBoss.heigth)

    -- corredores
    if Corredor1 then
    print("No Corredor 1")
        if hero.x + hero.Contato < self.CorredorSpawnNPC.x then
            print("Não sai pela esquerda")
            hero.x = self.CorredorSpawnNPC.x
        end
        if hero.x + hero.Contato > self.CorredorSpawnNPC.x + self.CorredorSpawnNPC.width then
            print("Não sai pela direita")
            hero.x = self.CorredorSpawnNPC.x + self.CorredorSpawnNPC.width 
        end
    end
    -- if Corredor2 then
    --     if hero.y - hero.Contato == self.CorredorNPCMen.y then
    --         hero.y = hero.y - 0
    --     end
    --     if hero.y + hero.Contato == self.CorredorNPCMen.y + self.CorredorNPCMen.heigth then
    --         hero.y = hero.x - 0
    --     end
    -- end
    -- if Corredor3 then
    --     if hero.x - hero.Contato == self.CorredorMenT1.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorMenT1.x + self.CorredorMenT1.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    -- if Corredor4 and puzzles.Gate1Open then
    --     if hero.x - hero.Contato == self.CorredorT1Skill.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorT1Skill.x + self.CorredorT1Skill.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    -- if Corredor5 then
    --     if hero.y - hero.Contato == self.CorredorNPCDog.y then
    --         hero.y = hero.y - 0
    --     end
    --     if hero.y + hero.Contato == self.CorredorNPCDog.y + self.CorredorNPCDog.heigth then
    --         hero.y = hero.x - 0
    --     end
    -- end
    -- if Corredor6 then
    --     if hero.x - hero.Contato == self.CorredorDogT2.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorDogT2.x + self.CorredorDogT2.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    -- if Corredor7 and puzzles.Gate2Open then
    --     if hero.x - hero.Contato == self.CorredorT2Skill.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorT2Skill.x + self.CorredorT2Skill.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    -- -- Corredor Boss
    -- if Corredor8 and hero.Has_Skil1 and hero.Has_Skil2 then
    --     if hero.x - hero.Contato == self.CorredorNPCpboss.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorNPCpboss.x + self.CorredorNPCpboss.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    -- if Corredor9 and hero.Has_Skil1 and hero.Has_Skil2 and boss.On == false then
    --     if hero.x - hero.Contato == self.CorredorpbossBoss.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CorredorpbossBoss.x + self.CorredorpbossBoss.width then
    --         hero.x = hero.x + 0
    --     end
    -- end
    
    -- Outras Partes do Mapa1

    -- SalaSpawn
    if circleRectInterno(hero.x, hero.y, hero.Contato, self.SalaSpawn.x, self.SalaSpawn.y, self.SalaSpawn.width, self.SalaSpawn.heigth) then
        print("dentro do spawn")
        hero.visivel = false
        if hero.x - hero.Contato == self.SalaSpawn.x then
            hero.x = hero.x - 0
        end
        if hero.x + hero.Contato == self.SalaSpawn.x + self.SalaSpawn.width then
            hero.x = hero.x + 0
        end
        if hero.y - hero.Contato == self.SalaSpawn.y then
            if not Corredor1 then
                hero.y = hero.y - 0
            end
        end
        if hero.y + hero.Contato == self.SalaSpawn.y + self.SalaSpawn.heigth then
            hero.y = hero.x - 0
        end
    end
    -- SalaNpc
    if circleRectInterno(hero.x, hero.y, hero.Contato, self.SalaNpc.x, self.SalaNpc.y, self.SalaNpc.width, self.SalaNpc.heigth) then
        hero.visivel = false
        if hero.x - hero.Contato == self.SalaNpc.x then
            --if not Corredor2 then
                hero.x = hero.x - 0
            --end
        end
        if hero.x + hero.Contato == self.SalaNpc.x + self.SalaNpc.width then
            --if not Corredor5 then
                hero.x = hero.x + 0
            --end
        end
        if hero.y - hero.Contato == self.SalaNpc.y then
            --if not Corredor8 then
                hero.y = hero.y - 0 
            --end
        end
        if hero.y + hero.Contato == self.SalaNpc.y + self.SalaNpc.heigth then
            if not Corredor1 then
                hero.y = hero.y + 0
            end
        end
    end
    -- -- SalaPuzzle 1
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaPuzzle.caixa1.x, self.CaixaPuzzle.caixa1.y, self.CaixaPuzzle.caixa1.width, self.CaixaPuzzle.caixa1.heigth) then
    --     hero.visivel = false
    --     if hero.x - hero.Contato == self.CaixaPuzzle.caixa1.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaPuzzle.caixa1.x + self.CaixaPuzzle.caixa1.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaPuzzle.caixa1.y then
    --         if not Corredor4 then
    --             hero.y = hero.y - 0
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaPuzzle.caixa1.y + self.CaixaPuzzle.caixa1.heigth then
    --         if not Corredor3 then
    --             hero.y = hero.y + 0
    --         end
    --     end
    -- end
    -- -- SalaPuzzle 2
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaPuzzle.caixa2.x, self.CaixaPuzzle.caixa2.y, self.CaixaPuzzle.caixa2.width, self.CaixaPuzzle.caixa2.heigth) then
    --     hero.visivel = false
    --     if hero.x - hero.Contato == self.CaixaPuzzle.caixa2.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaPuzzle.caixa2.x + self.CaixaPuzzle.caixa2.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaPuzzle.caixa2.y then
    --         if not Corredor7 then
    --             hero.y = hero.y - 0
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaPuzzle.caixa2.y + self.CaixaPuzzle.caixa2.heigth then
    --         if not Corredor6 then
    --             hero.y = hero.y + 0
    --         end
    --     end
    -- end
    -- -- SalaSkill 1
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaPuzzle.tesouro1.x, self.CaixaPuzzle.tesouro1.y, self.CaixaPuzzle.tesouro1.width, self.CaixaPuzzle.tesouro1.heigth) then
    --     hero.visivel = false
    --     if hero.x - hero.Contato == self.CaixaPuzzle.tesouro1.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaPuzzle.tesouro1.x + self.CaixaPuzzle.tesouro1.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaPuzzle.tesouro1.y then
    --         if not Corredor4 then
    --             hero.y = hero.y - 0   
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaPuzzle.tesouro1.y + self.CaixaPuzzle.tesouro1.heigth then
    --         if not Corredor4 then
    --             hero.y = hero.y + 0   
    --         end
    --     end
    -- end
    -- -- SalaSkill 2
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaPuzzle.tesouro2.x, self.CaixaPuzzle.tesouro2.y, self.CaixaPuzzle.tesouro2.width, self.CaixaPuzzle.tesouro2.heigth) then
    --     hero.visivel = false
    --     if hero.x - hero.Contato == self.CaixaPuzzle.tesouro2.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaPuzzle.tesouro2.x + self.CaixaPuzzle.tesouro2.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaPuzzle.tesouro2.y then
    --         if not Corredor4 then
    --             hero.y = hero.y - 0   
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaPuzzle.tesouro2.y + self.CaixaPuzzle.tesouro2.heigth then
    --         if not Corredor4 then
    --             hero.y = hero.y + 0   
    --         end
    --     end
    -- end
    -- -- Sala Pre Boss
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.SalaPreBos.x, self.SalaPreBos.y, self.SalaPreBos.width, self.SalaPreBos.heigth) then
    --     hero.visivel = false
    --     if hero.x - hero.Contato == self.SalaPreBos.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.SalaPreBos.x + self.SalaPreBos.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.SalaPreBos.y then
    --         if not Corredor9 then
    --             hero.y = hero.y - 0 
    --         end
    --     end
    --     if hero.y + hero.Contato == self.SalaPreBos.y + self.SalaPreBos.heigth then
    --         if not Corredor8 then
    --             hero.y = hero.x + 0
    --         end
    --     end
    -- end
    -- -- lugares de combate

    -- -- Local do Boss
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaBoss.x, self.CaixaBoss.y, self.CaixaBoss.width, self.CaixaBoss.heigth) then
    --     hero.visivel = true
    --     boss.On = true
    --     if hero.x - hero.Contato == self.CaixaBoss.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaBoss.x + self.CaixaBoss.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaBoss.y then
    --         hero.y = hero.y - 0
    --     end
    --     if hero.y + hero.Contato == self.CaixaBoss.y + self.CaixaBoss.heigth then
    --         hero.y = hero.x - 0
    --     end
    -- end

    -- -- Local Guerreiros
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaMen.x, self.CaixaMen.y, self.CaixaMen.width, self.CaixaMen.heigth) then
    --     hero.visivel = true
    --     if hero.x - hero.Contato == self.CaixaMen.x then
    --         hero.x = hero.x - 0
    --     end
    --     if hero.x + hero.Contato == self.CaixaMen.x + self.CaixaMen.width then
    --         if not Corredor2 then
    --             hero.x = hero.x + 0
    --         end
    --     end
    --     if hero.y - hero.Contato == self.CaixaMen.y then
    --         if not Corredor3 then
    --             hero.y = hero.y - 0
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaMen.y + self.CaixaMen.heigth then
    --         hero.y = hero.x - 0
    --     end

    -- end

    -- -- Local Dogs
    -- if circleRectInterno(hero.x, hero.y, hero.Contato, self.CaixaDog.x, self.CaixaDog.y, self.CaixaDog.width, self.CaixaDog.heigth) then
    --     hero.visivel = true
    --     if hero.x - hero.Contato == self.CaixaDog.x then
    --         if not Corredor5 then
    --             hero.x = hero.x - 0
    --         end
    --     end
    --     if hero.x + hero.Contato == self.CaixaDog.x + self.CaixaDog.width then
    --         hero.x = hero.x + 0
    --     end
    --     if hero.y - hero.Contato == self.CaixaDog.y then
    --         if not Corredor2 then
    --             hero.y = hero.y - 0
    --         end
    --     end
    --     if hero.y + hero.Contato == self.CaixaDog.y + self.CaixaDog.heigth then
    --         hero.y = hero.x - 0
    --     end
    -- end


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
    
    love.graphics.rectangle("fill", self.SalaSpawn.x, self.SalaSpawn.y, self.SalaSpawn.width, self.SalaSpawn.heigth)
    love.graphics.rectangle("fill", self.CorredorSpawnNPC.x, self.CorredorSpawnNPC.y, self.CorredorSpawnNPC.width, self.CorredorSpawnNPC.heigth)

end
