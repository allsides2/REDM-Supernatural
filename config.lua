Config = {}


Config.skills = {
    -- SKILLS DE CURA
    ["HEAL_AREA"] = {name = "HEAL_AREA", id=0, duration=10,cd=10, heal=5, animation="", particules={group="", particule=""}},
    ["FIRE_AREA"] = {name = "FIRE_AREA", id=0, duration=10,cd=10, heal=5, animation="", particules={group="", particule=""}},
    
}




Config.role = {
    vampire = {
        ["2"] = Config.skills["HEAL_AREA"],
        ["3"] = Config.skills["FIRE_AREA"],
        ["4"] = Config.skills["HEAL_AREA"],
        ["F1"]= Config.skills["HEAL_AREA"],
    },
    
}



Config.moon = {
    [1] = {
        name = "Lua de Sangue",
        constellation="Lucerna",
        buffedRole = Config.role.vampire,
    },
    [2] = {
        name = "Lua Cheia",
        constellation="Pelotrio",
        buffedRole = Config.role.wolfman,
    },
    [3] = {
        name = "Lua do Caos",
        constellation="Armara",
        buffedRole = Config.role.viking,
    },
    [4] = {
        name = "Lua Nova",
        constellation="Aevitas",
        buffedRole = Config.role.druid,
    },
    [5] = {
        name = "Lua das Sombras",
        constellation="Horologium",
        buffedRole = Config.role.witch,
    },
    [6] = {
        name = "Lua Oculta",
        constellation="Vorux",
        buffedRole = Config.role.demon,
    },
    [7] = {
        name = "Lua da sorte",
        constellation="Aevitas",
        buffedRole = false,
        buff={luck = 10}
    },
}



Config.randomLocale = {
    ["GUARMA"] = {
        [1] = {100,100,100}, -- nome do lugar
        [2] = {100,100,100}, -- nome do lugar
        [3] = {100,100,100}, -- nome do lugar
        [4] = {100,100,100}, -- nome do lugar
        [5] = {100,100,100}, -- nome do lugar
    },
    ["GUARMA_SUL"] = {
        [1] = {100,100,100}, -- nome do lugar
        [2] = {100,100,100}, -- nome do lugar
        [3] = {100,100,100}, -- nome do lugar
        [4] = {100,100,100}, -- nome do lugar
        [5] = {100,100,100}, -- nome do lugar
    },
    ["GUARMA_NORTE"] = {
        [1] = {100,100,100}, -- nome do lugar
        [2] = {100,100,100}, -- nome do lugar
        [3] = {100,100,100}, -- nome do lugar
        [4] = {100,100,100}, -- nome do lugar
        [5] = {100,100,100}, -- nome do lugar
    },
    ["GUARMA_LESTE"] = {
        [1] = {100,100,100}, -- nome do lugar
        [2] = {100,100,100}, -- nome do lugar
        [3] = {100,100,100}, -- nome do lugar
        [4] = {100,100,100}, -- nome do lugar
        [5] = {100,100,100}, -- nome do lugar
    },
    ["GUARMA_OESTE"] = {
        [1] = {100,100,100}, -- nome do lugar
        [2] = {100,100,100}, -- nome do lugar
        [3] = {100,100,100}, -- nome do lugar
        [4] = {100,100,100}, -- nome do lugar
        [5] = {100,100,100}, -- nome do lugar
    },


}


Config.bossGuarma = {
    [1] = {ped="A_C_Bear_01",heal=25000,size=1.5,locale=Config.randomLocale["GUARMA_NORTE"],buff={}},
    [2] = {ped="A_C_Alligator_01",heal=10000,size=1.2,locale=Config.randomLocale["GUARMA_SUL"],buff={}},
    [3] = {ped="A_C_Fox_01",heal=6000,size=1.2,locale=Config.randomLocale["GUARMA_LESTE"],buff={}},
    [4] = {ped="A_C_Goat_01",heal=4000,size=1.2,locale=Config.randomLocale["GUARMA_OESTE"],buff={}},
}









-- SPELL CONFIG
Config.Cooldown = 3000
Config.MaxDistance = 1000.0
-- SCALE CONFIG
Config.MaxScale = 5.1
Config.MinScale = 0.5
-- PORTAL CONFIG
Config.PortalDuration = 60000
-- FIRE CONFIG
Config.fireDuration = 60000
-- GHOST CONFIG
Config.isInGhostMode = false
Config.originalAlpha = 255
Config.originalGodMode = false
Config.originalPosition = vector3(0, 0, 0)
Config.isPlayerFrozen = false
Config.godModeEnabled = true






Config.defaultlang = 'en_lang'
-----------------------------------------------------

Config.keys = {
    buy    = 0xC7B5340A, --[Enter]
    travel = 0x760A9C6F  --[G]
}
-----------------------------------------------------

Config.shops = {
    stdenis = {
        shop = {
            name     = 'Saint Denis Port',                  -- Used while Traveling and in Closed Shop Message
            prompt   = 'Saint Denis to Guarma',             -- Text Below the Menu Prompt Button
            distance = 2.0,                                 -- Distance Between Player and Shop to Show Menu Prompt
            jobs     = {},                                  -- Insert Job to Limit Access - ex. jobs = {{name = 'police', grade = 1},{name = 'doctor', grade = 3}}
            hours    = {
                active = false,                             -- Shop uses Open and Closed Hours
                open   = 7,                                 -- Shop Open Time / 24 Hour Clock
                close  = 21                                 -- Shop Close Time / 24 Hour Clock
            }
        },
        blip = {
            name   = 'Saint Denis Port',                    -- Name of Blip on Map
            sprite = 2033397166,                            -- Default: 2033397166
            show   = {
                open   = true,                              -- Show Blip On Map when Open
                closed = true,                              -- Show Blip On Map when Closed
            },
            color  = {
                open   = 'WHITE',                           -- Shop Open - Default: White - Blip Colors Shown Below
                closed = 'RED',                             -- Shop Closed - Deafault: Red - Blip Colors Shown Below
                job    = 'YELLOW_ORANGE'                    -- Shop Job Locked - Default: Yellow - Blip Colors Shown Below
            }
        },
        npc = {
            active   = true,                                -- Turns NPC On / Off
            model    = 's_m_m_sdticketseller_01',           -- Model Used for NPC
            coords   = vector3(2662.75, -1542.85, 44.92),   -- NPC and Shop Blip Positions
            heading  = 246.19,                              -- NPC Heading
            distance = 100                                  -- Distance Between Player and Shop for NPC to Spawn
        },
        player = {
            coords  = vector3(2664.32, -1544.26, 45.92),    -- Player Teleport Position
            heading = 269.93                                -- Player Heading
        },
        travel = {
            location = 'guarma',                            -- DO NOT CHANGE LOCATION
            buyPrice = 25,                                  -- Price for Ticket (Cash)
            time = 15                                       -- Travel Time in Seconds
            }
    },
    -----------------------------------------------------

    guarma = {
        shop = {
            name     = 'Guarma Port',
            prompt   = 'Guarma to Saint Denis',
            distance = 2.0,
            jobs     = {},
            hours    = {
                active = false,
                open   = 7,
                close  = 21
            }
        },
        blip = {
            name   = 'Guarma Port',
            sprite = 2033397166,
            show   = {
                open   = true,                            -- Show Blip On Map when Open
                closed = true,                            -- Show Blip On Map when Closed
            },
            color  = {
                open   = 'WHITE',
                closed = 'RED',
                job    = 'YELLOW_ORANGE'
            }
        },
        npc = {
            active   = true,
            model    = 's_m_m_sdticketseller_01',
            coords   = vector3(1266.51, -6852.67, 42.27),
            heading  = 236.72,
            distance = 100
        },
        player = {
            coords  = vector3(1268.36, -6853.66, 43.27),
            heading = 243.09
        },
        travel = {
            location = 'stdenis',                          -- DO NOT CHANGE LOCATION
            buyPrice = 25,
            time = 15
        }
    }
}
-----------------------------------------------------

Config.BlipColors = {
    LIGHT_BLUE    = 'BLIP_MODIFIER_MP_COLOR_1',
    DARK_RED      = 'BLIP_MODIFIER_MP_COLOR_2',
    PURPLE        = 'BLIP_MODIFIER_MP_COLOR_3',
    ORANGE        = 'BLIP_MODIFIER_MP_COLOR_4',
    TEAL          = 'BLIP_MODIFIER_MP_COLOR_5',
    LIGHT_YELLOW  = 'BLIP_MODIFIER_MP_COLOR_6',
    PINK          = 'BLIP_MODIFIER_MP_COLOR_7',
    GREEN         = 'BLIP_MODIFIER_MP_COLOR_8',
    DARK_TEAL     = 'BLIP_MODIFIER_MP_COLOR_9',
    RED           = 'BLIP_MODIFIER_MP_COLOR_10',
    LIGHT_GREEN   = 'BLIP_MODIFIER_MP_COLOR_11',
    TEAL2         = 'BLIP_MODIFIER_MP_COLOR_12',
    BLUE          = 'BLIP_MODIFIER_MP_COLOR_13',
    DARK_PUPLE    = 'BLIP_MODIFIER_MP_COLOR_14',
    DARK_PINK     = 'BLIP_MODIFIER_MP_COLOR_15',
    DARK_DARK_RED = 'BLIP_MODIFIER_MP_COLOR_16',
    GRAY          = 'BLIP_MODIFIER_MP_COLOR_17',
    PINKISH       = 'BLIP_MODIFIER_MP_COLOR_18',
    YELLOW_GREEN  = 'BLIP_MODIFIER_MP_COLOR_19',
    DARK_GREEN    = 'BLIP_MODIFIER_MP_COLOR_20',
    BRIGHT_BLUE   = 'BLIP_MODIFIER_MP_COLOR_21',
    BRIGHT_PURPLE = 'BLIP_MODIFIER_MP_COLOR_22',
    YELLOW_ORANGE = 'BLIP_MODIFIER_MP_COLOR_23',
    BLUE2         = 'BLIP_MODIFIER_MP_COLOR_24',
    TEAL3         = 'BLIP_MODIFIER_MP_COLOR_25',
    TAN           = 'BLIP_MODIFIER_MP_COLOR_26',
    OFF_WHITE     = 'BLIP_MODIFIER_MP_COLOR_27',
    LIGHT_YELLOW2 = 'BLIP_MODIFIER_MP_COLOR_28',
    LIGHT_PINK    = 'BLIP_MODIFIER_MP_COLOR_29',
    LIGHT_RED     = 'BLIP_MODIFIER_MP_COLOR_30',
    LIGHT_YELLOW3 = 'BLIP_MODIFIER_MP_COLOR_31',
    WHITE         = 'BLIP_MODIFIER_MP_COLOR_32'
}