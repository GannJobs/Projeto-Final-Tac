Enemy01 = Classe:extend()

function Enemy01:new()

    -- tabela inimigos 

    self.inimigos01 = {}

    -- sprites de repouso, correr e morder

    self.parada = love.graphics.newImage("assets/imagens/inimigo01/repouso.png")
    local grid = anim.newGrid(64, 64, self.parada:getWidth(), self.parada:getHeight())
    self.aniDogStop = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/inimigo01/andando.png")
    local grid = anim.newGrid(64, 64, self.andando:getWidth(), self.andando:getHeight())
    self.aniDogRun = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-2', 3), 0.1)

    self.mordida = love.graphics.newImage("assets/imagens/inimigo01/ataqueDog.png")
    local grid = anim.newGrid(64, 64, self.mordida:getWidth(), self.mordida:getHeight())
    self.aniMordida = anim.newAnimation(grid('1-2', 1, '1-2', 2, '1-2', 3), 0.1)


for i = 1, 3 do
    local x = love.math.random(1360, 1700) * 1.5
    local y = love.math.random(1085, 1400) * 1.5

    self.inimigos01[i] = {
        width = 32,
        height = 32,
        Contato = 32,
        Dx = x ,
        Dy = y,
        raioDeteccao = 250,
        direcao = 1 ,
        movimento = false,
        atacando = false,
        direcaoDog = 1,
        Hp = 160,
        tempoaux = 1,
    
        posicao = Vetor(x, y),
        velocidade = Vetor(10, 10),
        vel_desejada = Vetor(),
        forca_direcao = Vetor(),
        massa = 1,
        aniDogStop = self.aniDogStop,
        aniDogRun = self.aniDogRun,
        aniMordida = self.aniMordida
    }
end

    self.tempo = 0

end

function Enemy01:update(dt)

    for i = 1, 3 do
        if self.inimigos01[i].Hp > 0 and hero.visivel then
            self.tempo = self.tempo + dt
            self:move(dt)
            if hero.visivel then
                self:Attack(dt)
            end
        end
    end
end

function Enemy01:draw()

    for i=1 , 3 do
        if self.inimigos01[i].Hp > 0 then

            -- Status
    
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", self.inimigos01[i].posicao.x - self.inimigos01[i].Hp / 2, self.inimigos01[i].posicao.y - 12, self.inimigos01[i].Hp, 6)
            love.graphics.setColor(1, 1, 1)
    
            -- animaçoes
    
            if self.inimigos01[i].movimento == true and self.inimigos01[i].atacando == false then
                self.inimigos01[i].aniDogRun:draw(self.andando, self.inimigos01[i].posicao.x, self.inimigos01[i].posicao.y, 0, self.inimigos01[i].direcaoDog * 2, 2, 32, 16)
            else
                self.inimigos01[i].aniDogStop:draw(self.parada, self.inimigos01[i].posicao.x, self.inimigos01[i].posicao.y, 0, self.inimigos01[i].direcaoDog * 2, 2, 32, 16)
            end
    
            if self.inimigos01[i].atacando == true then
                self.inimigos01[i].aniMordida:draw(self.mordida, self.inimigos01[i].posicao.x, self.inimigos01[i].posicao.y, 0, self.inimigos01[i].direcaoDog * 2, 2, 32, 16)
            end
        end
    end
end

function Enemy01:Attack(dt)

    for i=1, 3 do
        if RangeAttack(hero.Contato,self.inimigos01[i].Contato, hero.posicao,self.inimigos01[i].posicao) and self.inimigos01[i].atacando == false then
           self.inimigos01[i].tempoaux = self.tempo
           self.inimigos01[i].atacando = true
            hero.Hp = hero.Hp - 20
           self.inimigos01[i].aniMordida:resume()
        end
    
        if self.inimigos01[i].atacando == true then
           self.inimigos01[i].aniMordida:update(dt)
            if self.tempo >self.inimigos01[i].tempoaux + 0.5 then
               self.inimigos01[i].aniMordida:pauseAtStart()
            end
            if (self.tempo >self.inimigos01[i].tempoaux + 3) then
               self.inimigos01[i].atacando = false
            end
        end
    end
end

function Enemy01:move(dt)

    for i=1, 3 do
        if RangeVisao(self.inimigos01[i].raioDeteccao, self.inimigos01[i].posicao, hero.posicao) then
            if self.inimigos01[i].posicao.x > hero.posicao.x then
                self.inimigos01[i].direcao = -1
                self.inimigos01[i].direcaoDog = self.inimigos01[i].direcao
            end
            if self.inimigos01[i].posicao.x < hero.posicao.x then
                self.inimigos01[i].direcao = 1
                self.inimigos01[i].direcaoDog = self.inimigos01[i].direcao
    
            end
    
            self.inimigos01[i].aniDogRun:update(dt)
            self.inimigos01[i].movimento = true
    
            self.inimigos01[i].vel_desejada = (hero.posicao - self.inimigos01[i].posicao)/3
            self.inimigos01[i].vel_desejada = self.inimigos01[i].vel_desejada * 1.3
            self.inimigos01[i].forca_direcao = self.inimigos01[i].vel_desejada - self.inimigos01[i].velocidade
            self.inimigos01[i].velocidade = self.inimigos01[i].velocidade + self.inimigos01[i].forca_direcao / self.inimigos01[i].massa
            self.inimigos01[i].direcao = self.inimigos01[i].posicao + self.inimigos01[i].velocidade
            self.inimigos01[i].velocidade = self.inimigos01[i].velocidade
            self.inimigos01[i].posicao = self.inimigos01[i].posicao + self.inimigos01[i].velocidade * dt
    
        else
            self.inimigos01[i].movimento = false
        end
    end
end
