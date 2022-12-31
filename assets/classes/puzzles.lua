Puzzles = Classe:extend()

function Puzzles:new()

    -- 1 Puzzle

    self.Acertos = 0
    self.Gate1Open = false
    self.altares = {
        posicao1 = Vetor(300 * 1.5, 550 * 1.5),
        posicao2 = Vetor(185 * 1.5, 550 * 1.5),
        posicao3 = Vetor(110 * 1.5, 620 * 1.5),
        posicao4 = Vetor(380 * 1.5, 620 * 1.5),
        posicao5 = Vetor(300 * 1.5, 680 * 1.5),
        posicao6 = Vetor(185 * 1.5, 680 * 1.5),
        r = 10
    }

    -- sprites

    self.Botao = love.graphics.newImage("assets/imagens/Recursos/botao.png")
    local grid = anim.newGrid(32, 32, self.Botao:getWidth(), self.Botao:getHeight())
    self.Opcao = anim.newAnimation(grid('1-2', 1, '1-2', 2), 0.2)

    -- 2 Puzzle

    self.Gate2Open = false

end

function Puzzles:update(dt)
    -- 1 Puzzle

    self.Opcao:update(dt)
    if self.Acertos == 0 and RangeAttack(10, hero.Contato, self.altares.posicao1, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 1
    end
    if self.Acertos == 1 and RangeAttack(10, hero.Contato, self.altares.posicao2, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 2
    end
    if self.Acertos == 2 and RangeAttack(10, hero.Contato, self.altares.posicao3, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 3
    end
    if self.Acertos == 3 and RangeAttack(10, hero.Contato, self.altares.posicao4, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 4
    end
    if self.Acertos == 4 and RangeAttack(10, hero.Contato, self.altares.posicao5, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 5
    end
    if self.Acertos == 5 and RangeAttack(10, hero.Contato, self.altares.posicao6, hero.posicao) and love.keyboard.isDown("e") then
        self.Acertos = 6
        self.Gate1Open = true
    end

    -- 2 Puzzle

    --

end

function Puzzles:draw()
    -- 1 Puzzle
    if RangeAttack(10, hero.Contato, self.altares.posicao1, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao1.x - 16, self.altares.posicao1.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.altares.posicao2, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao2.x - 16, self.altares.posicao2.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.altares.posicao3, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao3.x - 16, self.altares.posicao3.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.altares.posicao4, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao4.x - 16, self.altares.posicao4.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.altares.posicao5, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao5.x - 16, self.altares.posicao5.y - 64)
    end
    if RangeAttack(10, hero.Contato, self.altares.posicao6, hero.posicao) then
        self.Opcao:draw(self.Botao, self.altares.posicao6.x - 16, self.altares.posicao6.y - 64)
    end

    love.graphics.setColor(255, 255, 0)

    love.graphics.circle("fill", self.altares.posicao1.x, self.altares.posicao1.y, self.altares.r)
    love.graphics.circle("fill", self.altares.posicao2.x, self.altares.posicao2.y, self.altares.r)
    love.graphics.circle("fill", self.altares.posicao3.x, self.altares.posicao3.y, self.altares.r)
    love.graphics.circle("fill", self.altares.posicao4.x, self.altares.posicao4.y, self.altares.r)
    love.graphics.circle("fill", self.altares.posicao5.x, self.altares.posicao5.y, self.altares.r)
    love.graphics.circle("fill", self.altares.posicao6.x, self.altares.posicao6.y, self.altares.r)

    if self.Acertos >= 2 then
        love.graphics.line(self.altares.posicao1.x, self.altares.posicao1.y, self.altares.posicao2.x, self.altares.posicao2.y)

        if self.Acertos >= 3 then
            love.graphics.line(self.altares.posicao2.x, self.altares.posicao2.y, self.altares.posicao3.x, self.altares.posicao3.y)

            if self.Acertos >= 4 then
                love.graphics.line(self.altares.posicao3.x, self.altares.posicao3.y, self.altares.posicao4.x, self.altares.posicao4.y)

                if self.Acertos >= 5 then
                    love.graphics.line(self.altares.posicao4.x, self.altares.posicao4.y, self.altares.posicao5.x, self.altares.posicao5.y)

                    if self.Acertos >= 6 then
                        love.graphics.line(self.altares.posicao5.x, self.altares.posicao5.y, self.altares.posicao6.x, self.altares.posicao6.y)

                    end
                end
            end
        end
    end
    love.graphics.setColor(1, 1, 1)

    -- 2 Puzzle

    --

    -- love.graphics.rectangle("fill", 1850 , 930, 530, 400) -- quadrados cachoros
end
