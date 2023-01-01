Enemy02 = Classe:extend()

function Enemy02:new()

    -- tabela inimigos

    self.inimigos02 = {}

    -- sprites de repouso, andar e atacar

    self.parada = love.graphics.newImage("assets/imagens/inimigo02/parado.png")
    local grid = anim.newGrid(32, 32, self.parada:getWidth(), self.parada:getHeight())
    self.aniMenStop = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/inimigo02/andando.png")
    local grid = anim.newGrid(32, 32, self.andando:getWidth(), self.andando:getHeight())
    self.aniMenRun = anim.newAnimation(grid('1-2', 1, '1-2', 2), 0.2)

    self.cortar = love.graphics.newImage("assets/imagens/inimigo02/ataqueMen.png")
    local grid = anim.newGrid(64, 64, self.cortar:getWidth(), self.cortar:getHeight())
    self.aniMenAttack = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.2)

    -- preechendo a tabela

    for i = 1, 15 do

        local x = love.math.random(70, 430) * 1.5
        local y = love.math.random(1077, 1400) * 1.5
        self.inimigos02[i] = {
            Iwidth = 32,
            Iheight = 32,
            IContato = 32,
            Ix = x,
            Iy = y,
            IraioDeteccao = 200,
            Idirecao = 1,
            Imovimento = false,
            Iatacando = false,
            IdirecaoMen = 1,
        
            Iposicao = Vetor(x, y),
            Ivelocidade = Vetor(1, 1),
            Ivel_desejada = Vetor(),
            Iforca_direcao = Vetor(),
            Imassa = 10,
            IHp = 400,
            Iaux = 1,
            IaniMenStop = self.aniMenStop,
            IaniMenRun = self.aniMenRun,
            IaniMenAttack = self.aniMenAttack
    
        }
        
    end

    self.tempo = 0
end

function Enemy02:update(dt)

    for i = 1, 15 do
        if self.inimigos02[i].IHp > 0 and hero.visivel then
            self.tempo = self.tempo + dt
            self:move(dt)
            if hero.visivel then
                self:Attack(dt)
            end
        end
    end

end

function Enemy02:draw()
    for i = 1, 15 do
        if self.inimigos02[i].IHp > 0 then
            -- Status
    
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle("fill", self.inimigos02[i].Iposicao.x - self.inimigos02[i].IHp / 2,self.inimigos02[i].Iposicao.y - 12,self.inimigos02[i].IHp, 6)
            love.graphics.setColor(1, 1, 1)
    
            -- animaçoes
    
            if self.inimigos02[i].Imovimento == true and self.inimigos02[i].Iatacando == false then
                self.inimigos02[i].IaniMenRun:draw(self.andando, self.inimigos02[i].Iposicao.x, self.inimigos02[i].Iposicao.y, 0,self.inimigos02[i].IdirecaoMen * 2, 2, 16, 0)
            else
                self.inimigos02[i].IaniMenStop:draw(self.parada, self.inimigos02[i].Iposicao.x, self.inimigos02[i].Iposicao.y, 0, self.inimigos02[i].IdirecaoMen * 2, 2, 16, 0)
            end
    
            if self.inimigos02[i].Iatacando == true then
                self.inimigos02[i].IaniMenAttack:draw(self.cortar, self.inimigos02[i].Iposicao.x, self.inimigos02[i].Iposicao.y, 0, self.inimigos02[i].IdirecaoMen * 2, 2, 32, 16)
            end
    
        end
    end
end

function Enemy02:Attack(dt)
    for i = 1, 15 do
        if RangeAttack(hero.Contato, self.inimigos02[i].IContato, hero.posicao, self.inimigos02[i].Iposicao) and self.inimigos02[i].Iatacando == false then
            self.inimigos02[i].Iaux = self.tempo
            self.inimigos02[i].Iatacando = true
            hero.Hp = hero.Hp - 20
            self.aniMenAttack:resume()
        end
    
        if self.inimigos02[i].Iatacando == true then
            self.aniMenAttack:update(dt)
            if self.tempo > self.inimigos02[i].Iaux + 1 then
                self.aniMenAttack:pauseAtStart()
            end
            if self.tempo > self.inimigos02[i].Iaux + 2 then
                self.inimigos02[i].Iatacando = false
            end
        end
    end
end

function Enemy02:move(dt)
    for i = 1, 15 do
        if RangeVisao(self.inimigos02[i].IraioDeteccao, self.inimigos02[i].Iposicao, hero.posicao) then
            if self.inimigos02[i].Iposicao.x > hero.posicao.x then
                self.inimigos02[i].Idirecao = -1
                self.inimigos02[i].IdirecaoMen = self.inimigos02[i].Idirecao
            end
            if self.inimigos02[i].Iposicao.x < hero.posicao.x then
                self.inimigos02[i].Idirecao = 1
                self.inimigos02[i].IdirecaoMen = self.inimigos02[i].Idirecao
    
            end
    
            self.aniMenRun:update(dt)
            self.inimigos02[i].Imovimento = true
    
            self.inimigos02[i].Ivel_desejada = (hero.posicao - self.inimigos02[i].Iposicao)/8
            self.inimigos02[i].Iforca_direcao = self.inimigos02[i].Ivel_desejada - self.inimigos02[i].Ivelocidade
            self.inimigos02[i].Ivelocidade = self.inimigos02[i].Ivelocidade + self.inimigos02[i].Iforca_direcao / self.inimigos02[i].Imassa
            self.inimigos02[i].Idirecao = self.inimigos02[i].Iposicao + self.inimigos02[i].Ivelocidade
            self.inimigos02[i].Ivelocidade = self.inimigos02[i].Ivelocidade
            self.inimigos02[i].Iposicao = self.inimigos02[i].Iposicao + self.inimigos02[i].Ivelocidade * dt
    
        else
            self.inimigos02[i].Imovimento = false
        end
    end
end
