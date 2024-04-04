fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."



client_scripts {
	"config.lua",
	--"client/raio.lua",
	"client/cure.lua",
	"client/events.js",
	--"client/portal.lua",
	--"client/moon.lua",
	"client/fire.lua",
	"client/ice.lua",
	--"client/guarma.lua",
	--"client/eagle.lua",
	--"client/transform.lua",
	--"client/ghost.lua",
	--"client/marker.lua",
	--"client/wolf.lua",
	--"client/fireSpell.lua",
	"client/scale.lua",
	"client.lua"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	"server/scale.lua",
	--"server/fireSpell.lua",
	--"server/guarma.lua",
	"server/fire.lua",
	--"server/portal.lua",
	"server/cure.lua",
	--"server/transform.lua",
	--"server/moon.lua",
	--"server/raio.lua",
	--"server/wolf.lua",
	--"server/wolf.lua"
	'server.lua',
}
