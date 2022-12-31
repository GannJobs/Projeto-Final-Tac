Enemy01 = Classe:extend()

function Enemy01:new()

    self.width = 32
    self.height = 32
    self.Contato = 32
    self.x = 500 -- love.graphics.getWidth() / 2 - self.width / 2
    self.y = 200 -- love.graphics.getHeight() / 2 - self.height / 2
    self.raioDeteccao = 200
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false
    self.atacando = false
    self.direcaoDog = 1

    self.posicao = Vetor(self.x, self.y)
    self.velocidade = Vetor(10, 10)
    self.vel_desejada = Vetor()
    self.forca_direcao = Vetor()
    self.massa = 1

    -- atributos

    self.Hp = 160

    -- sprites

    self.parada = love.graphics.newImage("assets/imagens/inimigo01/repouso.png")
    local grid = anim.newGrid(64, 64, self.parada:getWidth(), self.parada:getHeight())
    self.aniDogStop = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/inimigo01/andando.png")
    local grid = anim.newGrid(64, 64, self.andando:getWidth(), self.andando:getHeight())
    self.aniDogRun = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-2', 3), 0.1)

    self.mordida = love.graphics.newImage("assets/imagens/inimigo01/ataqueDog.png")
    local grid = anim.newGrid(64, 64, self.mordida:getWidth(), self.mordida:getHeight())
    self.aniMordida = anim.newAnimation(grid('1-2', 1, '1-2', 2, '1-2', 3), 0.1)

    -- controladores

    self.tempo = 0
    self.tempoaux = 0

end

function Enemy01:update(dt)

    if self.Hp > 0 and hero.visivel then
        self.tempo = self.tempo + dt
        self:move(dt)
        if hero.visivel then
            self:Attack(dt)
        end

    end

end

function Enemy01:draw()

    if self.Hp > 0 then

        -- love.graphics.circle("fill", self.posicao.x, self.posicao.y + self.Contato, self.Contato)

        -- Status

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.posicao.x - self.Hp / 2, self.posicao.y - 12, self.Hp, 6)
        love.graphics.setColor(1, 1, 1)

        -- animaçoes

        if self.movimento == true and self.atacando == false then
            self.aniDogRun:draw(self.andando, self.posicao.x, self.posicao.y, 0, self.direcaoDog * 2, 2, 32, 16)
        else
            love.graphics.draw(self.parada, self.posicao.x, self.posicao.y, 0, self.direcaoDog * 2, 2, 32, 16)
        end

        if self.atacando == true then
            self.aniMordida:draw(self.mordida, self.posicao.x, self.posicao.y, 0, self.direcaoDog * 2, 2, 32, 16)
        end
    end
end

function Enemy01:Attack(dt)

    if RangeAttack(hero.Contato, self.Contato, hero.posicao, self.posicao) and self.atacando == false then
        self.tempoaux = self.tempo
        self.atacando = true
        hero.Hp = hero.Hp - 20
        self.aniMordida:resume()
    end

    if self.atacando == true then
        self.aniMordida:update(dt)
        if self.tempo > self.tempoaux + 0.5 then
            self.aniMordida:pauseAtStart()
        end
        if (self.tempo > self.tempoaux + 3) then
            self.atacando = false
        end
    end

end

function Enemy01:move(dt)

    if RangeVisao(self.raioDeteccao, self.posicao, hero.posicao) then
        if self.posicao.x > hero.posicao.x then
            self.direcao = -1
            self.direcaoDog = self.direcao
        end
        if self.posicao.x < hero.posicao.x then
            self.direcao = 1
            self.direcaoDog = self.direcao

        end

        self.aniDogRun:update(dt)
        self.movimento = true

        self.vel_desejada = hero.posicao - self.posicao
        self.vel_desejada = self.vel_desejada * 1.3
        self.forca_direcao = self.vel_desejada - self.velocidade
        self.velocidade = self.velocidade + self.forca_direcao / self.massa
        self.direcao = self.posicao + self.velocidade
        self.velocidade = self.velocidade
        self.posicao = self.posicao + self.velocidade * dt

    else
        self.movimento = false
    end
end
