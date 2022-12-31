Puzzles = Classe:extend()

function Puzzles:new()

    -- 1 Puzzle

    self.Acertos = 0
    self.Gate1Open = false
    self.atlares = {
        posicao1 = Vetor(300, 430),
        posicao2 = Vetor(130, 430),
        posicao3 = Vetor(50, 500),
        posicao4 = Vetor(380, 500),
        posicao5 = Vetor(300, 580),
        posicao6 = Vetor(130, 580),
        r = 10
    }

    -- sprites

    self.Botao = love.graphics.newImage("assets/imagens/Recursos/botao.png")
    local grid = anim.newGrid(32, 32, self.Botao:getWidth(), self.Botao:getHeight())
    self.Opcao = anim.newAnimation(grid('1-2', 1, '1-2', 2), 0.2)

    -- 2 Puzzle

    

end

function Puzzles:update(dt)
    print(self.Acertos)
    self.Opcao:update(dt)
    if self.Acertos == 0 and RangeAttack(10, hero.Contato, self.atlares.posicao1, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 1
    end
    if self.Acertos == 1 and RangeAttack(10, hero.Contato, self.atlares.posicao2, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 2
    end
    if self.Acertos == 2 and RangeAttack(10, hero.Contato, self.atlares.posicao3, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 3
    end
    if self.Acertos == 3 and RangeAttack(10, hero.Contato, self.atlares.posicao4, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 4
    end
    if self.Acertos == 4 and RangeAttack(10, hero.Contato, self.atlares.posicao5, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 5
    end
    if self.Acertos == 5 and RangeAttack(10, hero.Contato, self.atlares.posicao6, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 6
        self.Gate1Open = true
    end
end

function Puzzles:draw()
    if RangeAttack(10, hero.Contato, self.atlares.posicao1, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao1.x - 16, self.atlares.posicao1.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.atlares.posicao2, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao2.x - 16, self.atlares.posicao2.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.atlares.posicao3, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao3.x - 16, self.atlares.posicao3.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.atlares.posicao4, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao4.x - 16, self.atlares.posicao4.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.atlares.posicao5, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao5.x - 16, self.atlares.posicao5.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.atlares.posicao6, hero.posicao) then
        self.Opcao:draw(self.Botao, self.atlares.posicao6.x - 16, self.atlares.posicao6.y - 64)
    end

    -- love.graphics.rectangle("fill", -2 , 320, 470, 370) -- quadrados altares
    love.graphics.setColor(255, 255, 0)

    love.graphics.circle("fill", self.atlares1.x, self.atlares1.y, self.atlares.r)
    love.graphics.circle("fill", self.atlares2.x, self.atlares2.y, self.atlares.r)
    love.graphics.circle("fill", self.atlares3.x, self.atlares3.y, self.atlares.r)
    love.graphics.circle("fill", self.atlares4.x, self.atlares4.y, self.atlares.r)
    love.graphics.circle("fill", self.atlares5.x, self.atlares5.y, self.atlares.r)
    love.graphics.circle("fill", self.atlares6.x, self.atlares6.y, self.atlares.r)

    if self.Acertos >= 2 then
        love.graphics.line(self.atlares.x1, self.atlares.y1, self.atlares.x2, self.atlares.y2)

        if self.Acertos >= 3 then
            love.graphics.line(self.atlares.x2, self.atlares.y2, self.atlares.x3, self.atlares.y3)

            if self.Acertos >= 4 then
                love.graphics.line(self.atlares.x3, self.atlares.y3, self.atlares.x4, self.atlares.y4)

                if self.Acertos >= 5 then
                    love.graphics.line(self.atlares.x4, self.atlares.y4, self.atlares.x5, self.atlares.y5)

                    if self.Acertos >= 6 then
                        love.graphics.line(self.atlares.x5, self.atlares.y5, self.atlares.x6, self.atlares.y6)
                    end
                end
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
    -- love.graphics.rectangle("fill", 1850 , 930, 530, 400) -- quadrados cachoros
end
