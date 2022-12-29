Boss = Classe:extend()

function Boss:new()

    self.width = 128
    self.height = 128
    self.Contato = 128
    self.x = 200
    self.y = 200
    self.posicao = Vetor(self.x, self.y)
    self.speed = 400
    self.direcao = 1 -- 1 direita / -1 esquerda
    self.movimento = false

    -- atributos

    self.Hp = 5000

    -- sprites

    -- movimentacao

    self.parado = love.graphics.newImage("assets/imagens/personagem/parado.png")
    local grid = anim.newGrid(128, 128, self.parado:getWidth(), self.parado:getHeight())
    self.animationP = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/personagem/Andar.png")
    local grid = anim.newGrid(128, 128, self.andando:getWidth(), self.andando:getHeight())
    self.aniBossMove = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.1)

    -- ataques

    self.atacando = false
    self.ataque1 = love.graphics.newImage("assets/imagens/personagem/Ataque01.png")
    local grid = anim.newGrid(128, 128, self.ataque1:getWidth(), self.ataque1:getHeight())
    self.aniAtaque1 = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-2', 4), 0.03)

    self.ataque2 = love.graphics.newImage("assets/imagens/personagem/Ataque02.png")
    local grid = anim.newGrid(128, 128, self.ataque2:getWidth(), self.ataque2:getHeight())
    self.aniAtaque2 = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-2', 4), 0.03)

    self.ataque3 = love.graphics.newImage("assets/imagens/personagem/Ataque03.png")
    local grid = anim.newGrid(128, 128, self.ataque3:getWidth(), self.ataque3:getHeight())
    self.aniAtaque3 = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-2', 4), 0.03)

    -- controladores

    self.tempo = 0
    self.tempoaux0 = 0
    self.tempoaux1 = 0
    self.tempoaux2 = 0

    self.Cd = {
        Atq1 = 0,
        Atq2 = 0,
        Atq3 = 0
    }

end

function Boss:update(dt)

end

function Boss:draw()

end


function Boss:Attack(dt)
    
end

function Boss:Move(dt)
    
end

