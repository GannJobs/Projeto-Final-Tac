Hero = Classe:extend()

function Hero:new()

    self.width = 32
    self.height = 32
    self.x = 200
    self.y = 200
    self.posicao = Vetor(self.x, self.y)
    self.speed = 200
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false

    -- atributos

    self.Hp = 500
    self.Mana = 350

    -- sprites

    -- movimentacao

    self.parada = love.graphics.newImage("assets/imagens/personagem/Parada.png")
    local grid = anim.newGrid(32, 32, self.parada:getWidth(), self.parada:getHeight())
    self.animationP = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/personagem/Andar.png")
    local grid = anim.newGrid(32, 32, self.andando:getWidth(), self.andando:getHeight())
    self.aniHeroMove = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.1)

    -- ataques

    self.atacando = false
    self.ataque = love.graphics.newImage("assets/imagens/personagem/Ataque01.png")
    local grid = anim.newGrid(64, 64, self.ataque:getWidth(), self.ataque:getHeight())
    self.aniAtaque = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-2', 4), 0.03)

    -- poderes
    self.Skill1 = false
    self.Skill01 = love.graphics.newImage("assets/imagens/personagem/Skill 01.png")
    local grid = anim.newGrid(64, 64, self.Skill01:getWidth(), self.Skill01:getHeight())
    self.aniSkill01 = anim.newAnimation(grid('1-5', 1, '1-5', 2, '1-5', 3, '1-5', 4, '1-5', 5, '1-3', 6), 0.1)

    self.Skill2 = false
    self.Skill02 = love.graphics.newImage("assets/imagens/personagem/Skill 02.png")
    local grid = anim.newGrid(64, 64, self.Skill02:getWidth(), self.Skill02:getHeight())
    self.aniSkill02 = anim.newAnimation(grid('1-6', 1, '1-6', 2, '1-6', 3, '1-6', 4, '1-6', 5, '1-6', 6, '1-4', 7), 0.1)

    -- controladores

    self.tempo = 0
    self.tempoaux0 = 0
    self.tempoaux1 = 0
    self.tempoaux2 = 0

end

function Hero:update(dt)
    self.tempo = self.tempo + dt
    self:mov(dt)
    self:Skills(dt)
    self:Attack(dt)

    self.posicao.x = self.x
    self.posicao.y = self.y

end

function Hero:draw()

    if self.Hp > 0 then

        -- Status

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", 10, 10, self.Hp, 10) -- hp
        love.graphics.setColor(1, 1, 1)

        love.graphics.setColor(0, 0, 1)
        love.graphics.rectangle("fill", 10, 30, self.Mana, 10) -- mana
        love.graphics.setColor(1, 1, 1)

        -- animaçoes

        if self.movimento == true and self.atacando == false then
            self.aniHeroMove:draw(self.andando, self.x, self.y, 0, self.direcao, 1, 16, 0)
        else
            if self.atacando == false then
                love.graphics.draw(self.parada, self.x, self.y, 0, self.direcao, 1, 16, 0)
            end
        end

        if self.atacando == true then
            self.aniAtaque:draw(self.ataque, self.x, self.y, 0, self.direcao, 1, 16, 26)
        end

        if self.Skill1 == true then
            self.aniSkill01:draw(self.Skill01, x1, y1, 0, 3, 3, 32, 28)
        end

        if self.Skill2 == true then
            self.aniSkill02:draw(self.Skill02, x2, y2, 0, 3, 3, 32, 28)
        end
    end
end

function Hero:Attack(dt)

    if love.keyboard.isDown("j") and self.atacando == false then
        self.tempoaux0 = self.tempo
        self.atacando = true
        self.aniAtaque:resume()
    end

    if self.atacando == true then
        self.aniAtaque:update(dt)
        if (self.tempo > self.tempoaux0 + 0.35) then
            self.aniAtaque:pauseAtStart()
            self.tempoaux0 = 0
            self.atacando = false
        end
    end

end

function Hero:Skills(dt)

    if love.keyboard.isDown("k") and self.Skill1 == false then
        x1 = self.x
        y1 = self.y
        self.tempoaux1 = self.tempo
        self.Skill1 = true
        self.aniSkill01:resume()
    end

    if self.Skill1 == true then
        self.aniSkill01:update(dt)
        if (self.tempo > self.tempoaux1 + 2.7) then
            self.aniSkill01:pauseAtStart()
            self.tempoaux1 = 0
            self.Skill1 = false
        end
    end

    if love.keyboard.isDown("l") and self.Skill2 == false then
        x2 = self.x
        y2 = self.y
        self.tempoaux2 = self.tempo
        self.Skill2 = true
        self.aniSkill02:resume()
    end

    if self.Skill2 == true then
        self.aniSkill02:update(dt)
        if (self.tempo > self.tempoaux2 + 3.4) then
            self.aniSkill02:pauseAtStart()
            self.tempoaux2 = 0
            self.Skill2 = false
        end
    end

end

function Hero:mov(dt)
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
        self.y = self.y - self.speed * dt
        self.x = self.x + self.speed * dt
        self.movimento = true
        self.direcao = 1
        self.aniHeroMove:update(dt)
    else
        if love.keyboard.isDown("w") and love.keyboard.isDown("a") then
            self.y = self.y - self.speed * dt
            self.x = self.x - self.speed * dt
            self.movimento = true
            self.direcao = -1
            self.aniHeroMove:update(dt)
        else
            if love.keyboard.isDown("w") then
                self.y = self.y - self.speed * dt
                self.movimento = true
                self.aniHeroMove:update(dt)
            else
                if love.keyboard.isDown("s") and love.keyboard.isDown("a") then
                    self.y = self.y + self.speed * dt
                    self.x = self.x - self.speed * dt
                    self.movimento = true
                    self.direcao = -1
                    self.aniHeroMove:update(dt)
                else
                    if love.keyboard.isDown("s") and love.keyboard.isDown("d") then
                        self.y = self.y + self.speed * dt
                        self.x = self.x + self.speed * dt
                        self.movimento = true
                        self.direcao = 1
                        self.aniHeroMove:update(dt)
                    else
                        if love.keyboard.isDown("s") then
                            self.y = self.y + self.speed * dt
                            self.movimento = true
                            self.aniHeroMove:update(dt)
                        else
                            if love.keyboard.isDown("a") then
                                self.x = self.x - self.speed * dt
                                self.direcao = -1
                                self.movimento = true
                                self.aniHeroMove:update(dt)
                            else
                                if love.keyboard.isDown("d") then
                                    self.x = self.x + self.speed * dt
                                    self.direcao = 1
                                    self.movimento = true
                                    self.aniHeroMove:update(dt)
                                else
                                    self.movimento = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
