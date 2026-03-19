function createPlayer(character_name, category)
	category = category:lower()
	local bonus = {
		health  = 0,
		damage  = 0
	}
	if category == "knight" then
		bonus.health    = 20
		bonus.damage    = 5
	elseif category == "mage" then
		bonus.health    = 5
		bonus.damage    = 20
	elseif category == "rogue" then
		bonus.health    = 10
		bonus.damage    = 10
	end
	return {
		name            = character_name,
		health          = 100 + bonus.health,
		c_damage        = 5 + bonus.damage,
		category        = category,
		attack = function(self, target)
			local damage = self.c_damage + math.random(5, 15)
			target.health = target.health - damage
			print(self.name .. " attacks " .. target.name .. " for " .. damage .. " damage!")
		end,
		status = function(self)
		    local hp = math.max(0, self.health)
		    print(self.name .. " has " .. hp .. " HP")
		end
	}
end

function createEnemy(enemy_name)
	return {
		name     = enemy_name,
		health   = 50 + math.random(10, 50),
		c_damage = math.random(1, 5),
		attack = function(self, target)
			local damage = self.c_damage + math.random(5, 10)
			target.health = target.health - damage
			print(self.name .. " attacks " .. target.name .. " for " .. damage .. " damage!")
		end,
	status = function(self)
	    local hp = math.max(0, self.health)
	    print(self.name .. " has " .. hp .. " HP")
	end
	}
end

math.randomseed(os.time())

local Player = createPlayer('david', 'knight')
local Enemy  = createEnemy('goblin')

print("--- battle start ---")

while Enemy.health > 0 and Player.health > 0 do
	Player:attack(Enemy)
	Enemy:attack(Player)
end

print("--- battle over ---")

if Enemy.health <= 0 and Player.health > 0 then
	print("Battle Won! " .. Player.name .. " defeated " .. Enemy.name .. "!")
elseif Player.health <= 0 and Enemy.health > 0 then
	print("Battle Lost! " .. Enemy.name .. " killed " .. Player.name .. "!")
elseif Player.health <= 0 and Enemy.health <= 0 then
	print("LOL Both Died!")
end

Player:status()
Enemy:status()
