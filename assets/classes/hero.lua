Hero = Classe:extend()

function Hero:new()

    self.width = 32
    self.height = 32
    self.Contato = 32
    self.x = 905 * 1.5
    self.y = 1607 * 1.5
    self.posicao = Vetor(self.x, self.y)
    self.speed = 200
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false
    self.visivel = false
    self.Has_Skil1 = false
    self.Has_Skil2 = false
    self.lvl = 1

    -- atributos

    self.Hp = 800
    self.Mana = 480

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
    self:Skills(dt)
    self:Attack(dt)
    print(self.visivel)

    self.posicao.x = self.x
    self.posicao.y = self.y

    if self.Has_Skil1 and self.Has_Skil2 then
        if self.Hp > 0 and self.Hp < 800 then
            self.Hp = self.Hp + 0.1 -- regenera??ao de vida buffada
        end
        if self.Mana > 0 and self.Mana < 350 then
            self.Mana = self.Mana + 0.3 -- regenera??ao de mana buffada
        end
    else
        if self.Has_Skil1 or self.Has_Skil2 then
            if self.Mana > 0 and self.Mana < 350 then
                self.Mana = self.Mana + 0.1 -- regenera??ao de mana base
            end
        end
        if self.Hp > 0 and self.Hp < 400 then
            self.Hp = self.Hp + 0.01 -- regenera??ao de vida base
        end
    end
end

function Hero:draw()
    if self.Hp > 0 then

        -- anima??oes

        if self.Skill1 == true then
            self.aniSkill01:draw(self.Skill01, x1 - 64, y1, 0, 4, 4, 16, 26)
        end

        if self.Skill2 == true then
            self.aniSkill02:draw(self.Skill02, x2, y2, 0, 5, 5, 32, 28)
        end

        if self.movimento == true and self.atacando == false then
            self.aniHeroMove:draw(self.andando, self.x, self.y, 0, self.direcao * 2, 2, 16, 16)
        else
            if self.atacando == false then
                love.graphics.draw(self.parada, self.x, self.y, 0, self.direcao * 2, 2, 16, 16)
            end
        end

        if self.atacando == true then
            self.aniAtaque:draw(self.ataque, self.x, self.y - 86, 0, self.direcao * 2, 2, 16, 0)
        end

    end
end

function Hero:Attack(dt)

    if love.keyboard.isDown("j") and self.atacando == false then
        print("atacando")
        self.tempoaux0 = self.tempo
        self.atacando = true
        self.aniAtaque:resume()
        if self.direcao == 1 then
            Corte = {
                x = self.x + 16,
                y = self.y - 90,
                whidt = 64,
                heigt = 128
            }
        else
            Corte = {
                x = self.x - 80,
                y = self.y - 90,
                whidt = 64,
                heigt = 128
            }
        end
        if circleRect(puzzles.AreaFogueira.x, puzzles.AreaFogueira.y, puzzles.AreaFogueira.r, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
            puzzles.fagulha = puzzles.fagulha + 1
        end   
        for i = 1, 15 do
            if enemy02.inimigos02[i].IHp > 0  then
                if circleRect(enemy02.inimigos02[i].Iposicao.x , enemy02.inimigos02[i].Iposicao.y, enemy02.inimigos02[i].IContato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
                    enemy02.inimigos02[i].IHp = enemy02.inimigos02[i].IHp - 15
                end
            end
            if enemy01.inimigos01[i].Hp > 0 then
                if circleRect(enemy01.inimigos01[i].posicao.x, enemy01.inimigos01[i].posicao.y, enemy01.inimigos01[i].Contato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
                    enemy01.inimigos01[i].Hp = enemy01.inimigos01[i].Hp - 20
                end
            end
        end
        if boss.Hp > 0 then
            if circleRect(boss.posicao.x, boss.posicao.y, boss.Contato, Corte.x, Corte.y, Corte.whidt, Corte.heigt) then
                boss.Hp = boss.Hp - 20
            end
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

    if love.keyboard.isDown("k") and self.Skill1 == false and self.Mana - 120 > 0 and self.Cd.skill1 < 0 and self.Has_Skil1 == true then
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
        for i = 1, 15 do
            if enemy01.inimigos01[i].Hp > 0  then
                if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
                    EspadaDeEnergia.x3, EspadaDeEnergia.y3, enemy01.inimigos01[i].posicao.x, enemy01.inimigos01[i].posicao.y, enemy01.inimigos01[i].Contato) then
                    enemy01.inimigos01[i].Hp = enemy01.inimigos01[i].Hp - 40
                end
            end
            if enemy02.inimigos02[i].IHp > 0  then
                if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
                    EspadaDeEnergia.x3, EspadaDeEnergia.y3, enemy02.inimigos02[i].Iposicao.x, enemy02.inimigos02[i].Iposicao.y, enemy02.inimigos02[i].IContato) then
                    enemy02.inimigos02[i].IHp = enemy02.inimigos02[i].IHp - 60
                end
            end
        end
        if boss.Hp > 0 then
            if TriangleCircle(EspadaDeEnergia.x1, EspadaDeEnergia.y1, EspadaDeEnergia.x2, EspadaDeEnergia.y2,
            EspadaDeEnergia.x3, EspadaDeEnergia.y3, boss.posicao.x, boss.posicao.y, boss.Contato) then
                boss.Hp = boss.Hp - 60
            end 
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

    if love.keyboard.isDown("l") and self.Skill2 == false and self.Mana - 140 > 0 and self.Cd.skill2 < 0 and self.Has_Skil2 == true then
        self.Cd.skill2 = 8
        self.Mana = self.Mana - 140
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
        for i=1, 15 do
            if enemy01.inimigos01[i].Hp > 0  then
                if RangeAttack(TempestadeDeChamas.raio, enemy01.inimigos01[i].Contato, TempestadeDeChamas.posicao, enemy01.inimigos01[i].posicao) then
                    enemy01.inimigos01[i].Hp = enemy01.inimigos01[i].Hp - 2
                end
            end
            if enemy02.inimigos02[i].IHp > 0  then
                if RangeAttack(TempestadeDeChamas.raio, enemy02.inimigos02[i].IContato, TempestadeDeChamas.posicao, enemy02.inimigos02[i].Iposicao) then
                    enemy02.inimigos02[i].IHp = enemy02.inimigos02[i].IHp - 1
                end
            end
        end
        if boss.Hp > 0 then
            if RangeAttack(TempestadeDeChamas.raio, boss.Contato, TempestadeDeChamas.posicao, boss.posicao) then
                boss.Hp = boss.Hp - 1
            end
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
