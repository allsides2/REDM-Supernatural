fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."



client_scripts {
	"config.lua",
	--"client/raio.lua",
	"client/cure.lua",
	"client/events.js",
	--client/portal.lua",
	--"client/moon.lua",
	"client/fire.lua",
	"client/poison.lua",
	--"client/boss.lua",
	--"client/guarma.lua",
	--"client/eagle.lua",
	--"client/transform.lua",
	--"client/ghost.lua",
	--"client/marker.lua",
	--"client/wolf.lua",
	--"client/fireSpell.lua",
	--"client/mobs.lua",
	--"client/karma.lua",
	"client/scale.lua",
	--"client/vampire.lua",
	"client.lua"
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	"server/scale.lua",
	--"server/fireSpell.lua",
	--"server/guarma.lua",
	--"server/karma.lua",
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


ui_page 'html/index.html'

files {
	'html/index.html',
	'html/css.css',
	'html/js.js',

}