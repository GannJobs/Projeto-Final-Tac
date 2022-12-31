NPC = Classe:extend()

function NPC:new()

    self.RaioDeChat = 64
    self.x = 910 * 1.5
    self.y = 1200 * 1.5
    self.posicao = Vetor(self.x, self.y)

    self.direcao = hero.direcao -- 1 direita / -1 esquerda
    self.visivel = false
    self.RangeMenu = false
    self.chat = false
    self.chats = 1

    self.botao = {
        posicao = Vetor(0, 0),
        raio = 0
    }

    -- sprites 

    self.parado = love.graphics.newImage("assets/imagens/npc/NPC.png")
    local grid = anim.newGrid(32, 32, self.parado:getWidth(), self.parado:getHeight())
    self.Descanso = anim.newAnimation(grid('1-2', 1, '1-2', 2, '1-2', 3), 0.1)

    self.Botao = love.graphics.newImage("assets/imagens/Recursos/botao.png")
    local grid = anim.newGrid(32, 32, self.Botao:getWidth(), self.Botao:getHeight())
    self.Opcao = anim.newAnimation(grid('1-2', 1, '1-2', 2), 0.2)

end

function NPC:update(dt)

    self.direcao = hero.direcao * -1
    self.Descanso:update(dt)

    if RangeAttack(self.RaioDeChat, hero.Contato, self.posicao, hero.posicao) then

        self.RangeMenu = true
        self.botao = {
            posicao = Vetor(self.posicao.x, self.posicao.y - 32),
            raio = 10
        }

        self.Opcao:update(dt)
        if love.keyboard.isDown("e") then
            self.chat = true
            if love.keyboard.isDown("e") and self.chats == 1 then
                self.chats = 2
            else
                if love.keyboard.isDown("e")then
                    self.chats = 1
                end
            end
            print(self.chats)
        end

    else
        self.chat = false
        self.RangeMenu = false
    end

end

function NPC:draw()
    self.Descanso:draw(self.parado, self.posicao.x, self.posicao.y, 0, self.direcao * 2.5, 2.5, 16, 0)

    if self.RangeMenu then

        -- love.graphics.circle("line", self.botao.posicao.x, self.botao.posicao.y + self.RaioDeChat, self.RaioDeChat)
        self.Opcao:draw(self.Botao, self.botao.posicao.x, self.botao.posicao.y, 0, 1, 1, 16, 0)
    end
    if self.chat then
        love.graphics.setColor(0.5, 0.5, 0.5)
        love.graphics.rectangle("fill", self.x - 210, self.y - 190, 430, 150)
        love.graphics.setColor(1, 1, 1)
        if self.chats == 1 then
            love.graphics.print("Olá caçador, vejo que enfim chegou ao seu destino, logo mais a" ..
                                    "\nfrente encontrará o esconderijo do lobisomen que você caça a anos." ..
                                    "\nEstou aqui para prevenir que consiga fazer o seu trabalho" ..
                                    "\na ordem tem grande apreço por você, por isso preciso que faça algo" ..
                                    "\nantes para nos, e para você também, deste jeito nunca derrotará" ..
                                    "\no seu inimigo, está fraco, mas em seu lar, existem 2 reliquias" ..
                                    "\nque possuem poderes sagrados, a espada da punição, e o fogo do" ..
                                    "\ninferno, recupere ambas, use-as em seu favor, mate a fera, e as" ..
                                    "\ndevolva para nos, e isto não é uma opção...(siga em frente)", self.x - 200,
                self.y - 180)
        else
            love.graphics.print("A esquerda se encontra a reliquia da espada sagrada, a direita o" ..
                                    "\nfogo do inferno, os corredores são zonas neutras e seguras." ..
                                    "\nO portão da sala do seu inimigo jurado só se abrirá quando tiver" ..
                                    "\npoder suficiente, então recupere as relíquias primeiro", self.x - 200,
                self.y - 180)
        end

    end
end

