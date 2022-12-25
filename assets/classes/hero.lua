Hero = Classe:extend()

function Hero:new()

    -- atributos

    self.width = 50
    self.height = 50
    self.x = 200 -- love.graphics.getWidth() / 2 - self.width / 2
    self.y = 200 -- love.graphics.getHeight() / 2 - self.height / 2
    self.posicao = Vetor(self.x, self.y)
    self.speed = 200
    self.direcao = 1 -- 1 direita / -2 esquerda
    self.movimento = false

    self.parada = love.graphics.newImage("assets/imagens/personagem/Parada.png")
    local grid = anim.newGrid(32, 32, self.parada:getWidth(), self.parada:getHeight())
    animationP = anim.newAnimation(grid('1-1', 1), 0.1)

    self.andando = love.graphics.newImage("assets/imagens/personagem/Andar.png")
    local grid = anim.newGrid(32, 32, self.andando:getWidth(), self.andando:getHeight())
    aniHeroMove = anim.newAnimation(grid('1-3', 1, '1-3', 2, '1-3', 3, '1-1', 4), 0.1)

    -- controladores

    self.tempo = 0
    self.aux = 1

end

function Hero:update(dt)

    self.tempo = self.tempo + dt
    self:mov(dt)

    self.posicao.x = self.x
    self.posicao.y = self.y

end

function Hero:draw()
    if self.movimento == true then
        aniHeroMove:draw(self.andando, self.x, self.y, 0, self.direcao, 1, 16, 0)
    else
        love.graphics.draw(self.parada, self.x, self.y, 0, self.direcao, 1, 16, 0)
    end
end

function Hero:mov(dt)
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
        self.y = self.y - self.speed * dt
        self.x = self.x + self.speed * dt
        self.movimento = true
        self.direcao = 1
        aniHeroMove:update(dt)
    else
        if love.keyboard.isDown("w") and love.keyboard.isDown("a") then
            self.y = self.y - self.speed * dt
            self.x = self.x - self.speed * dt
            self.movimento = true
            self.direcao = -1
            aniHeroMove:update(dt)
        else
            if love.keyboard.isDown("w") then
                self.y = self.y - self.speed * dt
                self.movimento = true
                aniHeroMove:update(dt)
            else
                if love.keyboard.isDown("s") and love.keyboard.isDown("a") then
                    self.y = self.y + self.speed * dt
                    self.x = self.x - self.speed * dt
                    self.movimento = true
                    self.direcao = -1
                    aniHeroMove:update(dt)
                else
                    if love.keyboard.isDown("s") and love.keyboard.isDown("d") then
                        self.y = self.y + self.speed * dt
                        self.x = self.x + self.speed * dt
                        self.movimento = true
                        self.direcao = 1
                        aniHeroMove:update(dt)
                    else
                        if love.keyboard.isDown("s") then
                            self.y = self.y + self.speed * dt
                            self.movimento = true
                            aniHeroMove:update(dt)
                        else
                            if love.keyboard.isDown("a") then
                                self.x = self.x - self.speed * dt
                                self.direcao = -1
                                self.movimento = true
                                aniHeroMove:update(dt)
                            else
                                if love.keyboard.isDown("d") then
                                    self.x = self.x + self.speed * dt
                                    self.direcao = 1
                                    self.movimento = true
                                    aniHeroMove:update(dt)
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
