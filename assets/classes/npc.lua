NPC = Classe:extend()

function NPC:new()

    self.RaioDeChat = 64
    self.x = 200
    self.y = 400
    self.width = 32
    self.height = 32
    self.posicao = Vetor(self.x, self.y)

    self.direcao = hero.direcao -- 1 direita / -1 esquerda
    self.aberto = false
    self.visivel = false
    self.RangeMenu = false
    self.selecao = false

    self.botao = {
        posicao = Vetor(0, 0),
        raio = 0
    }

    -- movimentacao

    self.parado = love.graphics.newImage("assets/imagens/npc/NPC.png")
    local grid = anim.newGrid(32, 32, self.parado:getWidth(), self.parado:getHeight())
    self.Descanso = anim.newAnimation(grid('1-2', 1, '1-2', 2, '1-2', 3), 0.1)

    -- auxiliar

    self.timer = 0
    self.timeraux = 0

end

function NPC:update(dt)

    self.timer = self.timer + dt
    self.Descanso:update(dt)

    if RangeAttack(self.RaioDeChat, hero.Contato, self.posicao, hero.posicao) then

        self.RangeMenu = true
        self.botao = {
            posicao = Vetor(self.posicao.x, self.posicao.y - 32),
            raio = 10
        }

    else
        self.RangeMenu = false
    end

    if MouseSelection(self.slots[i].Swidth, self.slots[i].Sheight, self.slots[i].Sx, self.slots[i].Sy)then
        if love.mouse.isDown(1, 2, 3) then
            self.selecao = true
            self.escolha = i
            if self.opcoes[self.escolha].criada and self.opcoes[self.escolha].level == 2 then
                self.selecao = false
                self.escolha = 0
            end
        end
    end

end

function NPC:draw()
    self.Descanso:draw(self.parado, self.posicao.x, self.posicao.y, 0, self.direcao * 2, 2, 16, 0)
    
    if self.RangeMenu then

        love.graphics.circle("line", self.botao.posicao.x, self.botao.posicao.y + self.RaioDeChat, self.RaioDeChat)
        love.graphics.setColor(0, 0, 1)
        love.graphics.circle("fill", self.botao.posicao.x, self.botao.posicao.y, self.botao.raio)
        love.graphics.setColor(1, 1, 1)

    end
end

