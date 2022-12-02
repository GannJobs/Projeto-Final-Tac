Hero = Classe:extend()

function Hero:new()

    --sprites

    self.sprites_repouso = {"assets/imagens/personagem/Repouso/Ddireita.png",
                            "assets/imagens/personagem/Repouso/Desquerda.png"}

    self.sprites_andar_esquerda = {"assets/imagens/personagem/Esquerda/sprites12.png",
                                    "assets/imagens/personagem/Esquerda/sprites13.png",
                                    "assets/imagens/personagem/Esquerda/sprites14.png",
                                    "assets/imagens/personagem/Esquerda/sprites15.png",
                                    "assets/imagens/personagem/Esquerda/sprites16.png",
                                    "assets/imagens/personagem/Esquerda/sprites17.png",
                                    "assets/imagens/personagem/Esquerda/sprites18.png",
                                    "assets/imagens/personagem/Esquerda/sprites19.png",
                                    "assets/imagens/personagem/Esquerda/sprites20.png",
                                    "assets/imagens/personagem/Esquerda/sprites21.png"}

    self.sprites_andar_direita = {"assets/imagens/personagem/Direita/sprites02.png",
                                    "assets/imagens/personagem/Direita/sprites03.png",
                                    "assets/imagens/personagem/Direita/sprites04.png",
                                    "assets/imagens/personagem/Direita/sprites05.png",
                                    "assets/imagens/personagem/Direita/sprites06.png",
                                    "assets/imagens/personagem/Direita/sprites07.png",
                                    "assets/imagens/personagem/Direita/sprites08.png",
                                    "assets/imagens/personagem/Direita/sprites09.png",
                                    "assets/imagens/personagem/Direita/sprites10.png",
                                    "assets/imagens/personagem/Direita/sprites11.png"}

    -- atributos

    self.width = 50
    self.height = 50
    self.x = 200 --love.graphics.getWidth() / 2 - self.width / 2
    self.y = 200 --love.graphics.getHeight() / 2 - self.height / 2
    self.speed = 200
    self.direcao = 1  -- 1 direita / 2 esquerda
    self.movimento = false

    self.imagem = love.graphics.newImage(self.sprites_repouso[self.direcao])

    -- controladores
    
    self.tempo = 0
    self.aux = 1

end

function Hero:update(dt)
    self.tempo = self.tempo + dt

    self:mov(dt)
    self:Animation()
   
    if self.movimento == 0 then 
        self.imagem = love.graphics.newImage(self.sprites_repouso[self.direcao])
    end
end

function Hero:draw()
    love.graphics.draw(self.imagem, self.x, self.y)
end

function Hero:Animation()
    if self.movimento then 
        if self.direcao == 1 then
            self.imagem = love.graphics.newImage(self.sprites_andar_direita[1])
            self.aux = self.aux + 1
            if self.aux == 10 then
                self.aux = 1
            end
        else
            self.imagem = love.graphics.newImage(self.sprites_andar_esquerda[1])
            self.aux = self.aux + 1
            if self.aux == 10 then
                self.aux = 1
            end
        end
    end
    self.aux = 1
end

function Hero:mov(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
        self.movimento = true
        self.imagem = love.graphics.newImage(self.sprites_repouso[self.direcao])
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
        self.movimento = true
        self.imagem = love.graphics.newImage(self.sprites_repouso[self.direcao])
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
        self.direcao = 2
        self.movimento = true
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
        self.direcao = 1
        self.movimento = true
    end
    self.movimento = false
end