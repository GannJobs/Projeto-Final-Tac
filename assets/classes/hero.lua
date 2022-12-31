Hero = Classe:extend()

function Hero:new()

    self.width = 32
    self.height = 32
    self.Contato = 32
    self.x = 1200
    self.y = 1500
    self.posicao = Vetor(self.x, self.y)
    self.speed = 500
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false
    self.visivel = false

    -- atributos

    self.Hp = 1000
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
    self.aniSkill01 = anim.newAnimation(grid('1-5', 1, '1-5', 2, '1-5', 3, '1-5', 4, '1-5', 5, '1-3', 6), 0.05)

    self.Skill2 = false
    self.Skill02 = love.graphics.newImage("assets/imagens/personagem/Skill 02.png")
    local grid = anim.newGrid(64, 64, self.Skill02:getWidth(), self.Skill02:getHeight())
    self.aniSkill02 = anim.newAnimation(grid('1-6', 1, '1-6', 2, '1-6', 3, '1-6', 4, '1-6', 5, '1-6', 6, '1-4', 7), 0.1)

    -- controladores

    self.tempo = 0
    self.tempoaux0 = 0
    self.tempoaux1 = 0
    self.tempoaux2 = 0

    self.Cd = {
        skill1 = 0,
        skill2 = 0
    }

end

function Hero:update(dt)

    cam:lookAt(hero.x, hero.y)

    self.tempo = self.tempo + dt
    self:mov(dt)

    if self.visivel then
        self:Skills(dt)
        self:Attack(dt)
    end

    self.posicao.x = self.x
    self.posicao.y = self.y

    if self.Hp > 0 and self.Hp < 500 then
        self.Hp = self.Hp + 0.1 -- regeneraçao de vida
    end

    if self.Mana > 0 and self.Mana < 350 then
        self.Mana = self.Mana + 0.3 -- regeneraçao de mana
    end

    if self.Hp < 0 then
        self.visivel = false
    end

end

function Hero:draw()
    if self.Hp > 0 then

        -- love.graphics.circle("fill", self.x, self.y + self.Contato, self.Contato)

        -- animaçoes

        if self.Skill1 == true then
            self.aniSkill01:draw(self.Skill01, x1, y1, 0, 4, 4, 32, 26)
            -- love.graphics.polygon("fill", EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2,EspadaDeEnergia.y2, EspadaDeEnergia.x3, EspadaDeEnergia.y3)
        end

        if self.Skill2 == true then
            self.aniSkill02:draw(self.Skill02, x2, y2, 0, 5, 5, 32, 28)
            -- love.graphics.circle("fill", x2, y2, TempestadeDeChamas.raio)
        end

        if self.movimento == true and self.atacando == false then
            self.aniHeroMove:draw(self.andando, self.x, self.y, 0, self.direcao * 2, 2, 16, 0)
        else
            if self.atacando == false then
                love.graphics.draw(self.parada, self.x, self.y, 0, self.direcao * 2, 2, 16, 0)
            end
        end

        if self.atacando == true then
            self.aniAtaque:draw(self.ataque, self.x, self.y, 0, self.direcao * 2, 2, 16, 26)
            -- love.graphics.rectangle("fill", Corte.x, Corte.y, Corte.whidt, Corte.heigt)
        end

    end

    love.graphics.setColor(0, 1, 0)
    love.graphics.points(self.x, self.y) -- referencial de posicao
    love.graphics.setColor(1, 1, 1)
end

function Hero:Attack(dt)

    if love.keyboard.isDown("j") and self.atacando == false then
        self.tempoaux0 = self.tempo
        self.atacando = true
        self.aniAtaque:resume()
        if self.direcao == 1 then
            Corte = {
                x = self.x + 16,
                y = self.y - 64,
                whidt = 64,
                heigt = 128
            }
        else
            Corte = {
                x = self.x - 80,
                y = self.y - 64,
                whidt = 64,
                heigt = 128
            }
        end
        if circleRect(enemy01.posicao.x, enemy01.posicao.y, enemy01.Contato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
            enemy01.Hp = enemy01.Hp - 15
        end
        if circleRect(enemy02.posicao.x, enemy02.posicao.y, enemy02.Contato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
            enemy02.Hp = enemy02.Hp - 20
        end
        if circleRect(boss.posicao.x, boss.posicao.y, boss.Contato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
            boss.Hp = boss.Hp - 20
        end
    end

    if self.atacando == true then
        self.aniAtaque:update(dt)
        if (self.tempo > self.tempoaux0 + 0.35) then
            Corte = 0
            self.aniAtaque:pauseAtStart()
            self.tempoaux0 = 0
            self.atacando = false
        end
    end

end

function Hero:Skills(dt)

    if love.keyboard.isDown("k") and self.Skill1 == false and self.Mana - 120 > 0 and self.Cd.skill1 < 0 then
        self.Cd.skill1 = 5
        self.Mana = self.Mana - 120
        x1 = self.x
        y1 = self.y
        self.tempoaux1 = self.tempo
        self.Skill1 = true
        self.aniSkill01:resume()
        EspadaDeEnergia = {
            x1 = x1 - 2,
            y1 = y1 - 80,
            x2 = x1 - 35,
            y2 = y1 + 35,
            x3 = x1 + 35,
            y3 = y1 + 35
        }
        if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
            EspadaDeEnergia.x3, EspadaDeEnergia.y3, enemy01.posicao.x, enemy01.posicao.y, enemy01.Contato) then
            enemy01.Hp = enemy01.Hp - 40
        end
        if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
            EspadaDeEnergia.x3, EspadaDeEnergia.y3, enemy02.posicao.x, enemy02.posicao.y, enemy02.Contato) then
            enemy02.Hp = enemy02.Hp - 60
        end
        if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
            EspadaDeEnergia.x3, EspadaDeEnergia.y3, boss.posicao.x, boss.posicao.y, boss.Contato) then
            boss.Hp = boss.Hp - 60
        end
    end

    if self.Cd.skill1 >= 0 then
        self.Cd.skill1 = self.Cd.skill1 - dt
    end

    if self.Skill1 == true then
        self.aniSkill01:update(dt)
        if (self.tempo > self.tempoaux1 + 1.35) then
            EspadaDeEnergia = 0
            self.aniSkill01:pauseAtStart()
            self.tempoaux1 = 0
            self.Skill1 = false
        end
    end

    if love.keyboard.isDown("l") and self.Skill2 == false and self.Mana - 180 > 0 and self.Cd.skill2 < 0 then
        self.Cd.skill2 = 8
        self.Mana = self.Mana - 180
        x2 = self.x
        y2 = self.y
        self.tempoaux2 = self.tempo
        self.Skill2 = true
        self.aniSkill02:resume()
        TempestadeDeChamas = {
            posicao = Vetor(x2, y2),
            raio = 140
        }
    end

    if self.Cd.skill2 >= 0 then
        self.Cd.skill2 = self.Cd.skill2 - dt
    end

    if self.Skill2 == true then
        if RangeAttack(TempestadeDeChamas.raio, enemy01.Contato, TempestadeDeChamas.posicao, enemy01.posicao) then
            enemy01.Hp = enemy01.Hp - 2
        end
        if RangeAttack(TempestadeDeChamas.raio, enemy02.Contato, TempestadeDeChamas.posicao, enemy02.posicao) then
            enemy02.Hp = enemy02.Hp - 1
        end
        if RangeAttack(TempestadeDeChamas.raio, boss.Contato, TempestadeDeChamas.posicao, boss.posicao) then
            boss.Hp = boss.Hp - 1
        end
        self.aniSkill02:update(dt)
        if (self.tempo > self.tempoaux2 + 3.7) then
            TempestadeDeChamas = 0
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
