Boss = Classe:extend()

function Boss:new()

    self.width = 128
    self.height = 128
    self.Contato = 128
    self.x = 902 * 1.5
    self.y = 250 * 1.5
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false
    self.On = false

    self.direcaoBoss = 2
    self.posicao = Vetor(self.x, self.y)
    self.velocidade = Vetor(10, 10)
    self.vel_desejada = Vetor()
    self.forca_direcao = Vetor()
    self.massa = 5
    self.dash = true

    -- atributos

    self.Hp = 5000

    -- sprites

    -- movimentacao

    self.Parado = love.graphics.newImage("assets/imagens/chefe/boss.png")

    -- self.andando = love.graphics.newImage("assets/imagens/personagem/Andar.png")
    -- local grid = anim.newGrid(128, 128, self.andando:getWidth(), self.andando:getHeight())
    -- self.aniBossRun = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.1)

    -- ataques

    self.atacando = false

    self.ataque1 = love.graphics.newImage("assets/imagens/chefe/ataque01.png")
    local grid = anim.newGrid(128, 128, self.ataque1:getWidth(), self.ataque1:getHeight())
    self.aniAtaque1 = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-1', 3), 0.1)

    self.ataque2 = love.graphics.newImage("assets/imagens/chefe/ataque03.png")
    local grid = anim.newGrid(128, 128, self.ataque2:getWidth(), self.ataque2:getHeight())
    self.aniAtaque2 = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.1)

    self.ataque3 = love.graphics.newImage("assets/imagens/chefe/ataque02.png")
    local grid = anim.newGrid(128, 128, self.ataque3:getWidth(), self.ataque3:getHeight())
    self.aniAtaque3 = anim.newAnimation(grid('1-2', 1, '1-2', 2, '1-1', 3), 0.1)

    -- controladores

    self.tempo = 0
    self.tempoaux0 = 0
    self.tempoaux1 = 0
    self.tempoaux2 = 0

    self.Cd = {
        Atq1 = 0,
        Atq2 = 0,
        Atq3 = 0,
        Range1 = 90,
        Range2 = 200,
        Range3 = 300
    }

end

function Boss:update(dt)

    if self.Hp > 0 and hero.visivel then
        self.tempo = self.tempo + dt
        self:Move(dt)
        if self.On then
            self:Attack(dt)
        end
    end
end

function Boss:draw()

    if self.Hp > 0 then

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.posicao.x - 250, self.posicao.y - 110, self.Hp / 10, 30)
        love.graphics.setColor(1, 1, 1)

        if self.movimento == false then
            -- self.aniBossRun:draw()
            love.graphics.draw(self.Parado, self.posicao.x, self.posicao.y, 0, self.direcaoBoss, 2, 64, 64)

        else
            if self.atacando == false then
                love.graphics.draw(self.Parado, self.posicao.x, self.posicao.y, 0, self.direcaoBoss, 2, 64, 64)
            else
                if self.Cd.Atq1 > 0 then
                    self.aniAtaque1:draw(self.ataque1, self.posicao.x, self.posicao.y, 0, self.direcaoBoss, 2, 64, 64)
                    -- love.graphics.rectangle("fill", self.AreaAtaque1.x, self.AreaAtaque1.y, self.AreaAtaque1.width, self.AreaAtaque1.height)
                else
                    if self.Cd.Atq2 > 0 then
                        self.aniAtaque2:draw(self.ataque2, self.posicao.x, self.posicao.y, 0, self.direcaoBoss, 2, 64,
                            64)
                        -- love.graphics.circle("fill", self.AreaAtaque2.x, self.AreaAtaque2.y, self.AreaAtaque2.raio)
                    else
                        if self.Cd.Atq3 > 0 then
                            self.aniAtaque3:draw(self.ataque3, self.posicao.x, self.posicao.y, 0, self.direcaoBoss, 2,
                                64, 64)
                        end
                    end
                end
            end
        end
    end

    -- range 1
    -- love.graphics.circle("line", self.posicao.x, self.posicao.y, self.Cd.Range1)
    -- range 2
    -- love.graphics.circle("line", self.posicao.x, self.posicao.y, self.Cd.Range2)
    -- range 3
    -- love.graphics.circle("line", self.posicao.x, self.posicao.y, self.Cd.Range3)

end

function Boss:Attack(dt)

    if self.atacando == true then
        if self.Cd.Atq1 > 0 then
            self.aniAtaque1:update(dt)
            if self.tempoaux0 + 1 < self.tempo then
                self.aniAtaque1:pauseAtStart()
            end
            if self.tempoaux0 + 3 < self.tempo then
                self.Cd.Atq1 = 0
                self.atacando = false
                self.tempoaux0 = 0
            end
        end
        if self.Cd.Atq2 > 0 then
            self.aniAtaque2:update(dt)
            if self.tempoaux1 + 1 < self.tempo then
                self.aniAtaque2:pauseAtStart()
            end
            if self.tempoaux1 + 3 < self.tempo then
                self.Cd.Atq2 = 0
                self.atacando = false
                self.tempoaux1 = 0
            end
        end
        if self.Cd.Atq3 > 0 then
            self.dash = false
            self.aniAtaque3:update(dt)
            if self.tempoaux2 + 1 < self.tempo then
                self.aniAtaque3:pauseAtStart()
            end
            if self.tempoaux2 + 8 < self.tempo then
                self.Cd.Atq3 = 0
                self.atacando = false
                self.tempoaux2 = 0
            end
        end
    end

    -- ataque 1, Corte
    if self.Cd.Atq1 <= 0 and RangeAttack(self.Cd.Range1, hero.Contato, self.posicao, hero.posicao) and self.atacando ==
        false then
        self.Cd.Atq1 = 1
        self.tempoaux0 = self.tempo
        self.atacando = true
        self.aniAtaque1:resume()
        if self.direcaoBoss > 1 then
            self.AreaAtaque1 = {
                x = self.posicao.x - 64,
                y = self.posicao.y - 64,
                width = 64,
                height = 128
            }
            if circleRect(hero.posicao.x, hero.posicao.y, hero.Contato, self.AreaAtaque1.x, self.AreaAtaque1.y,
                self.AreaAtaque1.width, self.AreaAtaque1.height) then
                hero.Hp = hero.Hp - 70
            end
        else
            self.AreaAtaque1 = {
                x = self.posicao.x,
                y = self.posicao.y - 64,
                width = 64,
                height = 128
            }
            if circleRect(hero.posicao.x, hero.posicao.y, hero.Contato, self.AreaAtaque1.x, self.AreaAtaque1.y,
                self.AreaAtaque1.width, self.AreaAtaque1.height) then
                hero.Hp = hero.Hp - 70
            end
        end
    end
    -- ataque 2, Mordida
    if self.Cd.Atq2 <= 0 and RangeAttack(self.Cd.Range2, hero.Contato, self.posicao, hero.posicao) and self.atacando ==
        false then
        self.Cd.Atq2 = 1
        self.tempoaux1 = self.tempo
        self.atacando = true
        self.aniAtaque2:resume()
        if self.direcaoBoss > 1 then
            self.AreaAtaque2 = {
                x = self.posicao.x - 128,
                y = self.posicao.y,
                raio = 60
            }
            if RangeAttack(hero.Contato, self.AreaAtaque2.raio, self.AreaAtaque2, hero.posicao) then
                hero.Hp = hero.Hp - 100
            end
        else
            self.AreaAtaque2 = {
                x = self.posicao.x + 128,
                y = self.posicao.y,
                raio = 60
            }
            if RangeAttack(hero.Contato, self.AreaAtaque2.raio, self.AreaAtaque2, hero.posicao) then
                hero.Hp = hero.Hp - 100
            end
        end
    end
    -- ataque 3, estocada
    if self.Cd.Atq3 <= 0 and RangeAttack(self.Cd.Range3, hero.Contato, self.posicao, hero.posicao) and self.atacando ==
        false then
        self.Cd.Atq3 = 1
        self.tempoaux2 = self.tempo
        self.atacando = true
        self.aniAtaque3:resume()
        self.dash = true
        if self.direcaoBoss > 1 then
            print(hero.Hp)
            self.AreaAtaque3 = {
                xB = self.posicao.x,
                yB = self.posicao.y,
                xH = hero.posicao.x,
                yH = hero.posicao.y,
                RH = hero.Contato
            }
            if lineCircle(self.AreaAtaque3.xB, self.AreaAtaque3.yB, self.AreaAtaque3.xH, self.AreaAtaque3.yH,
                self.AreaAtaque3.xH, self.AreaAtaque3.yH, self.AreaAtaque3.RH) then
                hero.Hp = hero.Hp - 50
            end
        end
    end

end

function Boss:Move(dt)
    if RangeVisao(1000, self.posicao, hero.posicao) then
        if self.posicao.x > hero.posicao.x then
            self.direcao = 2
            self.direcaoBoss = self.direcao
        end
        if self.posicao.x < hero.posicao.x then
            self.direcao = -2
            self.direcaoBoss = self.direcao

        end

        -- self.aniBossRun:update(dt)
        self.movimento = true

        self.vel_desejada = hero.posicao - self.posicao

        if self.Cd.Atq3 > 0 and self.dash then -- dash da habilidade
            print("DASH!!!")
            self.dash = false
            self.vel_desejada = self.vel_desejada * 60
        end

        self.forca_direcao = self.vel_desejada - self.velocidade
        self.velocidade = self.velocidade + self.forca_direcao / self.massa
        self.direcao = self.posicao + self.velocidade
        self.velocidade = self.velocidade
        self.posicao = self.posicao + self.velocidade * dt

    else
        self.movimento = false
    end
end

