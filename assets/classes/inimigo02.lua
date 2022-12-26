Enemy02 = Classe:extend()

function Enemy02:new()

    -- atributos

    self.width = 50
    self.height = 50
    self.x = 600 -- love.graphics.getWidth() / 2 - self.width / 2
    self.y = 200 -- love.graphics.getHeight() / 2 - self.height / 2
    self.raioDeteccao = 300
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false

    self.posicao = Vetor(self.x, self.y)
    self.velocidade = Vetor(20, 20)
    self.vel_desejada = Vetor()
    self.forca_direcao = Vetor()
    self.massa = 5

    self.parada = love.graphics.newImage("assets/imagens/inimigo02/parado.png")
    local grid = anim.newGrid(32, 32, self.parada:getWidth(), self.parada:getHeight())
    aniMenStop = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/inimigo02/andando.png")
    local grid = anim.newGrid(32, 32, self.andando:getWidth(), self.andando:getHeight())
    aniMenRun = anim.newAnimation(grid('1-2', 1, '1-2', 2), 0.1)

    -- controladores

    self.tempo = 0
    self.aux = 1

end

function Enemy02:update(dt)

    self.tempo = self.tempo + dt
    self:move(dt)

end

function Enemy02:draw()
    if self.movimento == true then
        aniMenRun:draw(self.andando, self.posicao.x, self.posicao.y, 0, self.direcaoMen, 1, 16, 0)
    else
        love.graphics.draw(self.parada, self.posicao.x, self.posicao.y, 0, self.direcaoMen, 1, 16, 0)
    end
end

function Enemy02:move(dt)

    if RangeInimigo(self.raioDeteccao, self.posicao, hero.posicao) then
        if self.posicao.x > hero.posicao.x then
            self.direcao = -1
            self.direcaoMen = self.direcao
        end
        if self.posicao.x < hero.posicao.x then
            self.direcao = 1
            self.direcaoMen = self.direcao

        end

        aniMenRun:update(dt)
        self.movimento = true
        
        self.vel_desejada = hero.posicao - self.posicao
        self.vel_desejada = self.vel_desejada * 1.2
        self.forca_direcao = self.vel_desejada - self.velocidade
        self.velocidade = self.velocidade + self.forca_direcao / self.massa
        self.direcao = self.posicao + self.velocidade
        self.velocidade = self.velocidade
        self.posicao = self.posicao + self.velocidade * dt

    else
        self.movimento = false
    end
end
