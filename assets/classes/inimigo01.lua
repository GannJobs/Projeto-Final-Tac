Enemy01 = Classe:extend()

function Enemy01:new()

    -- atributos

    self.width = 32
    self.height = 32
    self.x = 500 -- love.graphics.getWidth() / 2 - self.width / 2
    self.y = 200 -- love.graphics.getHeight() / 2 - self.height / 2
    self.raioDeteccao = 200
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false

    self.posicao = Vetor(self.x, self.y)
    self.velocidade = Vetor(10, 10)
    self.vel_desejada = Vetor()
    self.forca_direcao = Vetor()
    self.massa = 1

    self.parada = love.graphics.newImage("assets/imagens/inimigo01/repouso.png")
    local grid = anim.newGrid(64, 64, self.parada:getWidth(), self.parada:getHeight())
    self.aniDogStop = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/inimigo01/andando.png")
    local grid = anim.newGrid(64, 64, self.andando:getWidth(), self.andando:getHeight())
    self.aniDogRun = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-2', 3), 0.1)

    -- controladores

    self.tempo = 0
    self.aux = 1

end

function Enemy01:update(dt)

    self.tempo = self.tempo + dt
    self:move(dt)

end

function Enemy01:draw()
    if self.movimento == true then
        self.aniDogRun:draw(self.andando, self.posicao.x, self.posicao.y, 0, self.direcaoDog, 1, 32, 0)
    else
            love.graphics.draw(self.parada, self.posicao.x, self.posicao.y, 0, self.direcaoDog, 1, 32, 0)
    end
end

function Enemy01:move(dt)

    if RangeInimigo(self.raioDeteccao, self.posicao, hero.posicao) then
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
