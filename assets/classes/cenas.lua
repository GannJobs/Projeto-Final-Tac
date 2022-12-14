Cenas = Classe:extend()

function Cenas:new()
    -- tela inicial
    self.Fundo = love.graphics.newImage("assets/imagens/Recursos/fundo.png")
    -- menu inicial
    self.Menu = true
    self.Jogar = false
    self.BotaoJogar = {
        x = 250,
        y = 400,
        width = 300,
        height = 80
    }
    self.Controles = false
    self.ImgControles = love.graphics.newImage("assets/imagens/Recursos/Controles.png")
    self.BotaoControles = {
        x = 250,
        y = 500,
        width = 300,
        height = 80
    }
    self.BotaoVoltarControles = {
        x = 50,
        y = 50,
        width = 90,
        height = 50
    }
    self.BotaoSairDoJogo = {
        x = 250,
        y = 600,
        width = 300,
        height = 80
    }
    -- pause
    self.Pause = false

    self.BotaoResumeFase = {
        x = 250,
        y = 400,
        width = 300,
        height = 80
    }

    -- vencer jogo 

    -- perder jogo

end

function Cenas:update(dt)
    if self.Menu then
        if MouseSelection(self.BotaoJogar.width, self.BotaoJogar.height, self.BotaoJogar.x, self.BotaoJogar.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Jogar = true
                self.Menu = false
            end
        end
        if MouseSelection(self.BotaoControles.width, self.BotaoControles.height, self.BotaoControles.x,
            self.BotaoControles.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Controles = true
            end
        end
        if self.Controles and
            MouseSelection(self.BotaoVoltarControles.width, self.BotaoVoltarControles.height,
                self.BotaoVoltarControles.x, self.BotaoVoltarControles.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Controles = false
            end
        end
        if MouseSelection(self.BotaoSairDoJogo.width, self.BotaoSairDoJogo.height, self.BotaoSairDoJogo.x,
            self.BotaoSairDoJogo.y) then
            if love.mouse.isDown(1, 2, 3) then
                love.event.quit(exitstatus)
            end
        end
    else

    end

    if self.Jogar then
        puzzles:update(dt)
        boss:update(dt)
        hero:update(dt)
        enemy01:update(dt)
        enemy02:update(dt)
        npc:update(dt)
        cenario:update(dt)

        cam:lookAt(hero.x, hero.y)
        if love.keyboard.isDown("p") then
            self.Pause = true
        end
    end

    if self.Pause == true then
        hero.visivel = false
        if MouseSelection(self.BotaoResumeFase.width, self.BotaoResumeFase.height, self.BotaoResumeFase.x,
            self.BotaoResumeFase.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Pause = false
            end
        end
        if MouseSelection(self.BotaoControles.width, self.BotaoControles.height, self.BotaoControles.x,
            self.BotaoControles.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Controles = true
            end
        end
        if self.Controles and
            MouseSelection(self.BotaoVoltarControles.width, self.BotaoVoltarControles.height,
                self.BotaoVoltarControles.x, self.BotaoVoltarControles.y) then
            if love.mouse.isDown(1, 2, 3) then
                self.Controles = false
            end
        end
        if MouseSelection(self.BotaoSairDoJogo.width, self.BotaoSairDoJogo.height, self.BotaoSairDoJogo.x,
            self.BotaoSairDoJogo.y) then
            if love.mouse.isDown(1, 2, 3) then
                love.event.quit(exitstatus)
            end
        end
    end

    if boss.Hp <= 0 then
        if MouseSelection(self.BotaoSairDoJogo.width, self.BotaoSairDoJogo.height, self.BotaoSairDoJogo.x,
            self.BotaoSairDoJogo.y) then
            if love.mouse.isDown(1, 2, 3) then
                love.event.quit(exitstatus)
            end
        end
    end

    if hero.Hp <= 0 then
        if MouseSelection(self.BotaoSairDoJogo.width, self.BotaoSairDoJogo.height, self.BotaoSairDoJogo.x,
            self.BotaoSairDoJogo.y) then
            if love.mouse.isDown(1, 2, 3) then
                love.event.quit( "restart" )
            end
        end
    end
end

function Cenas:draw()
    if self.Menu and self.Controles == false then
        love.graphics.draw(self.Fundo, 0, 0)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.BotaoJogar.x, self.BotaoJogar.y, self.BotaoJogar.width,
            self.BotaoJogar.height)
        love.graphics.rectangle("fill", self.BotaoControles.x, self.BotaoControles.y, self.BotaoControles.width,
            self.BotaoControles.height)
        love.graphics.rectangle("fill", self.BotaoSairDoJogo.x, self.BotaoSairDoJogo.y, self.BotaoSairDoJogo.width,
            self.BotaoSairDoJogo.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Jogar", self.BotaoJogar.x + 95, self.BotaoJogar.y + 20, 0, 4, 4)
        love.graphics.print("Controles", self.BotaoControles.x + 45, self.BotaoControles.y + 20, 0, 4, 4)
        love.graphics.print("Sair", self.BotaoSairDoJogo.x + 105, self.BotaoSairDoJogo.y + 20, 0, 4, 4)

    end

    if self.Controles then
        love.graphics.draw(self.Fundo, 0, 0)
        love.graphics.draw(self.ImgControles, 0, 0)
        love.graphics.print("Direcionais", 100, 140, 0, 3, 3)
        love.graphics.print("Ataque", 100, 230, 0, 3, 3)
        love.graphics.print("1 Habilidade", 100, 320, 0, 3, 3)
        love.graphics.print("2 Habilidade", 100, 420, 0, 3, 3)
        love.graphics.print("Interagir", 100, 515, 0, 3, 3)
        love.graphics.print("Pausar", 100, 620, 0, 3, 3)

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.BotaoVoltarControles.x, self.BotaoVoltarControles.y,
            self.BotaoVoltarControles.width, self.BotaoVoltarControles.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Voltar", self.BotaoVoltarControles.x + 10, self.BotaoVoltarControles.y + 15, 0, 2, 2)
    end

    if self.Jogar and self.Pause == false and boss.Hp > 0 and hero.Hp > 0 then
        cam:attach()
        cenario:draw()
        puzzles:draw()
        npc:draw()
        boss:draw()
        hero:draw()
        enemy01:draw()
        enemy02:draw()
        cam:detach()

        -- Status

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", 10, 10, hero.Hp, 10) -- hp
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("fill", 10, 30, hero.Mana, 10) -- mana
        love.graphics.setColor(1, 1, 1)
    else
        if self.Pause then
            love.graphics.draw(self.Fundo, 0, 0)
            if self.Controles then
                love.graphics.draw(self.ImgControles, 0, 0)
                love.graphics.print("Direcionais", 100, 140, 0, 3, 3)
                love.graphics.print("Ataque", 100, 230, 0, 3, 3)
                love.graphics.print("1 Habilidade", 100, 320, 0, 3, 3)
                love.graphics.print("2 Habilidade", 100, 420, 0, 3, 3)
                love.graphics.print("Interagir", 100, 515, 0, 3, 3)
                love.graphics.print("Pausar", 100, 620, 0, 3, 3)

                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", self.BotaoVoltarControles.x, self.BotaoVoltarControles.y,
                    self.BotaoVoltarControles.width, self.BotaoVoltarControles.height)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Voltar", self.BotaoVoltarControles.x + 10, self.BotaoVoltarControles.y + 15, 0, 2,
                    2)
            else
                love.graphics.setColor(1, 0, 0)
                love.graphics.rectangle("fill", self.BotaoResumeFase.x, self.BotaoResumeFase.y,
                    self.BotaoResumeFase.width, self.BotaoResumeFase.height)
                love.graphics.rectangle("fill", self.BotaoControles.x, self.BotaoControles.y, self.BotaoControles.width,
                    self.BotaoControles.height)
                love.graphics.rectangle("fill", self.BotaoSairDoJogo.x, self.BotaoSairDoJogo.y,
                    self.BotaoSairDoJogo.width, self.BotaoSairDoJogo.height)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print("Resumir", self.BotaoResumeFase.x + 65, self.BotaoResumeFase.y + 20, 0, 4, 4)
                love.graphics.print("Controles", self.BotaoControles.x + 45, self.BotaoControles.y + 20, 0, 4, 4)
                love.graphics.print("Sair", self.BotaoSairDoJogo.x + 105, self.BotaoSairDoJogo.y + 20, 0, 4, 4)
            end
        end
    end

    if boss.Hp <= 0 and hero.Hp > 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.BotaoSairDoJogo.x, self.BotaoSairDoJogo.y, self.BotaoSairDoJogo.width,
            self.BotaoSairDoJogo.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Voce finalmente conseguiu cumprir sua ".."\nvinganca conta seu inimigo jurado" ..
                                "\naquele que dizimou sua casa, agora que".."\n sua vinganca est?? concluida, sua missao" ..
                                "\napenas comecou, existem muitas criaturas ".."\nda noite para serem cacadas, esta" ..
                                "\nfoi a primeira de muitas ...", 10, 10, 0, 3, 3)
        love.graphics.print("Sair", self.BotaoSairDoJogo.x + 105, self.BotaoSairDoJogo.y + 20, 0, 4, 4)
    end

    if hero.Hp <= 0 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.BotaoSairDoJogo.x, self.BotaoSairDoJogo.y, self.BotaoSairDoJogo.width,
            self.BotaoSairDoJogo.height)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Voce Falhou", 240, 10, 0, 4, 4)
        love.graphics.print("Reiniciar", self.BotaoSairDoJogo.x + 45, self.BotaoSairDoJogo.y + 20, 0, 4, 4)
    end
end
