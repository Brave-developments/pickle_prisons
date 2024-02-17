Config = {}

Config.Debug = true

Config.Language = "en" -- Language to use.

Config.RenderDistance = 20.0 -- Model Display Radius.

Config.InteractDistance = 2.0 -- Interact Radius

Config.UseTarget = true -- When set to true, it'll use targeting instead of key-presses to interact.

Config.NoModelTargeting = true -- When set to true and using Target, it'll spawn a small invisible prop so you can third-eye when no entity is defined.

Config.Marker = { -- This will only be used if enabled, not using target, and no model is defined in the interaction.
    enabled = true,
    id = 2,
    scale = 0.25, 
    color = {255, 255, 255, 127}
}

Config.NavigationDisplay = true -- This will only be used if enabled, this is used to help the user find the activity point.

Config.ServeTimeOffline = false -- When set to true, players can serve their time offline, lowering the time by how long they were gone.

Config.EnableSneakout = false -- When set to true, anytime the player is outside the prison without being part of a breakout, they are freed instead of being brought back.

Config.XPEnabled = false -- When set to true, this will enable Pickle's XP compatibility, and enable xp rewards.

Config.XPCategories = { -- Registered XP Types for Pickle's XP.
    ["strength"] = {
        label = "Strength", 
        xpStart = 1000, 
        xpFactor = 0.2, 
        maxLevel = 100
    },
    ["cooking"] = {
        label = "Cooking", 
        xpStart = 1000, 
        xpFactor = 0.2, 
        maxLevel = 100
    },
}

Config.Default = {
    permissions = { -- Permissions settings for jailing, unjailing, and other things.
        jail = {
            jobs = {["police"] = 0, ["corrections"] = 0}, -- ["job_name"] = rank_number, ["job_name2"] = rank_number2,
            groups = {"admin", "god"} -- "group1", "group2"
        },
        unjail = {
            jobs = {["police"] = 2, ["corrections"] = 2},
            groups = {"admin", "god"}
        },
        alert = {
            jobs = {["police"] = 0, ["corrections"] = 0},
            groups = {"admin", "god"}
        },
    },
    outfit = { -- Prisoner outfits to set when in jail. Please change this according to your server's clothing numbers.
        male = {
            ['arms'] = 0,
            ['tshirt_1'] = 15, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 86, 
            ['torso_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['pants_1'] = 10, 
            ['pants_2'] = 2,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 14, 
            ['helmet_2'] = 0,
        },
        female = {
            ['arms'] = 0,
            ['tshirt_1'] = 15, 
            ['tshirt_2'] = 0,
            ['torso_1'] = 86, 
            ['torso_2'] = 0,
            ['bproof_1'] = 0,
            ['bproof_2'] = 0,
            ['decals_1'] = 0, 
            ['decals_2'] = 0,
            ['chain_1'] = 0,
            ['chain_2'] = 0,
            ['pants_1'] = 10, 
            ['pants_2'] = 2,
            ['shoes_1'] = 56, 
            ['shoes_2'] = 0,
            ['helmet_1'] = 14, 
            ['helmet_2'] = 0,
        }
    }
}

Config.Activities = {
    ["workout"] = {
        label = "Workout", -- Will have Start / Stop in front of interaction.
        sections = { -- Sections for this activity.
            ["lift"] = {
                label = "Lift Weights",
                rewards = { -- Rewards for completing the section.
                    {type = "xp", name = "strength", amount = 1000},
                },
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1.0)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "amb@world_human_muscle_free_weights@male@barbell@base", "base", -8.0, 8.0, -1, 1, 1.0)
                    local prop = CreateProp(`prop_curl_bar_01`, data.coords.x, data.coords.y, data.coords.z + 1.0, true, true, false)
                    local off, rot = vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)
                    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false, false, true, 2, true)
                    local result
                    for i=1, 3 do 
                        result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                        if not result then
                            break
                        end
                        Wait(1000)
                    end
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    DeleteEntity(prop)
                    return result 
                end
            },
            ["situp"] = {
                label = "Sit-Ups",
                rewards = { -- Rewards for completing the section.
                    {type = "xp", name = "strength", amount = 1000},
                },
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1.0)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "amb@world_human_sit_ups@male@idle_a", "idle_a", -8.0, 8.0, -1, 1, 1.0)
                    local result
                    for i=1, 3 do 
                        result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                        if not result then
                            break
                        end
                        Wait(1000)
                    end
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return result 
                end
            },
            ["pushup"] = {
                label = "Pushups",
                rewards = { -- Rewards for completing the section.
                    {type = "xp", name = "strength", amount = 1000},
                },
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1.0)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "amb@world_human_push_ups@male@idle_a", "idle_d", -8.0, 8.0, -1, 1, 1.0)
                    local result
                    for i=1, 3 do 
                        result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                        if not result then
                            break
                        end
                        Wait(1000)
                    end
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return result 
                end
            },
            ["pullup"] = {
                label = "Pull-ups",
                rewards = { -- Rewards for completing the section.
                    {type = "xp", name = "strength", amount = 1000},
                },
                process = function(data) -- Section function.
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1.0)
                    SetEntityHeading(ped, data.heading)
                    TaskStartScenarioInPlace(ped, "prop_human_muscle_chin_ups", 0, -1)
                    Wait(3000)
                    local result
                    for i=1, 3 do 
                        result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                        if not result then
                            break
                        end
                        Wait(1000)
                    end
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return result 
                end
            },
        }
    },
    ["clean"] = {
        label = "Cleaning Prison", -- Will have Start / Stop in front of interaction.
        sections = { -- Sections for this activity.
            ["sweep"] = {
                label = "Sweep Floor",
                rewards = { -- Rewards for completing the section.
                    {type = "cash", amount = 50},
                },
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "anim@amb@drug_field_workers@rake@male_a@base", "base", -8.0, 8.0, -1, 1, 1.0)
                    local prop = CreateProp(`prop_tool_broom`, data.coords.x, data.coords.y, data.coords.z, true, true, false)
                    local off, rot = vector3(-0.01, 0.04, -0.03), vector3(0.0, 0.0, 0.0)
                    AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false, false, true, 2, true)
                    Wait(3000)
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    DeleteEntity(prop)
                    return true
                end
            },
        }
    },
    ["kitchen"] = {
        label = "Kitchen Job", -- Will have Start / Stop in front of interaction.
        sections = { -- Sections for this activity.
            ["stock"] = {
                label = "Collect Ingredients",
                rewards = nil, -- Rewards for completing the section.
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "amb@world_human_stand_fire@male@idle_a", "idle_a", -8.0, 8.0, -1, 1, 1.0)
                    Wait(5000)
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return true
                end
            },
            ["cook"] = {
                label = "Cook Food",
                rewards = nil, -- Rewards for completing the section.
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityHeading(ped, data.heading)
                    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BBQ", 0, 1)
                    local result
                    for i=1, 3 do 
                        result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
                        if not result then
                            break
                        end
                        Wait(1000)
                    end
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return result 
                end
            },
            ["toppings"] = {
                label = "Add Toppings",
                rewards = nil, -- Rewards for completing the section.
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    FreezeEntityPosition(ped, true)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "amb@world_human_stand_fire@male@idle_a", "idle_a", -8.0, 8.0, -1, 1, 1.0)
                    Wait(5000)
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    return true
                end
            },
            ["delivery"] = {
                label = "Deliver Food",
                rewards = {-- Rewards for completing the section.
                    {type = "cash", amount = 200},
                    {type = "xp", name = "cooking", amount = 1000},  
                },
                process = function(data) -- Section function. 
                    local ped = PlayerPedId()
                    local prop = GetActivityEntity("tray")
                    if not object then 
                        prop = CreateProp(`prop_food_tray_03`, data.coords.x, data.coords.y, data.coords.z + 1.0, true, true, false)
                        AddActivityEntity("tray", prop)
                        local off, rot = vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)
                        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false, false, true, 2, true)
                    end
                    FreezeEntityPosition(ped, true)
                    SetEntityHeading(ped, data.heading)
                    PlayAnim(ped, "mini@repair", "fixing_a_ped", -8.0, 8.0, -1, 1, 1.0)
                    Wait(500)
                    DetachEntity(prop, true, true)
                    FreezeEntityPosition(prop, true)
                    PlaceObjectOnGroundProperly(prop)
                    SetEntityHeading(prop, data.heading)
                    Wait(1000)
                    FreezeEntityPosition(ped, false)
                    ClearPedTasks(ped)
                    DeleteActivityEntity("tray")
                    return true
                end
            },
        }
    },
}

Config.UnrevokedItems = { -- Items to skip when confiscating the player's inventory.
    "burger",
    "water",
    "cash",
    "money",
}

Config.Breakout = {
    alert = true, -- This will start the siren, and notify all law enforcement with permission.
    time = 60, -- In seconds, at the end of this time, the tunnel will close for other people to climb into.
    model = {modelType = "prop", hash = `prop_rock_1_i`, offset = vector3(0.0, 0.0, -0.2)},
    required = {
        {type = "item", name = "shovel", amount = 1},
    }, 
    process = function(data)
        local ped = PlayerPedId()
        FreezeEntityPosition(ped, true)
        SetEntityCoords(ped, data.coords.x, data.coords.y, data.coords.z - 1.0)
        SetEntityHeading(ped, data.heading)
        PlayAnim(ped, "random@burial", "a_burial", -8.0, 8.0, -1, 1, 1.0)
        local prop = CreateProp(`prop_tool_shovel`, data.coords.x, data.coords.y, data.coords.z + 1.0, true, true, false)
        local off, rot = vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0)
        AttachEntityToEntity(prop, ped, GetPedBoneIndex(ped, 28422), off.x, off.y, off.z, rot.x, rot.y, rot.z, false, false, false, true, 2, true)
        local result
        for i=1, 3 do 
            result = lib.skillCheck({'easy', 'medium', 'easy'}, {'e'})
            if not result then
                break
            end
            Wait(1000)
        end
        FreezeEntityPosition(ped, false)
        ClearPedTasks(ped)
        DeleteEntity(prop)
        return result 
    end
}   

Config.Alerts = function(index, disabled)
    local prison = Config.Prisons[index]
    if (not disabled) then
        ShowNotification("The prison siren has been activated at " .. prison.label .. "!")
    else
        ShowNotification("The prison siren has been turned-off at " .. prison.label .. ".")
    end
end

Config.Prisons = {
    ["default"] = { -- Default is used as the prison location for players when not defined otherwise.
        label = "Boilingbroke Penitentiary", -- Prison label for notifications & texts.
        coords = vector3(1691.8187, 2604.5383, 45.5648), -- Location of the prison.
        radius = 250.0, -- This is the radius that prisoners will be freed at when exceeding this number. 
        permissions = nil, -- When nil, defaults to Config.Default.permissions.  
        outfit = nil, -- When nil, defaults to Config.Default.outfit.  
        blip = {
            label = "Boilingbroke Penitentiary",
            coords = vector3(1691.8187, 2604.5383, 45.5648),
            id = 188,
            color = 44,
            scale = 0.85,
        },
        hospital = {
            coords = vector3(1768.1461, 2570.0391, 45.7299),
            heading = 310.6851
        },
        release = {
            coords = vector3(1837.1382, 2591.4004, 45.0144),
            heading = 175.6774
        },
        breakout = {
            start = {
                coords = vector3(1761.71, 2512.18, 49.22),
                heading = 211.9629
            }, 
            enter = {
                coords = vector3(-472.8028, 2089.3516, 120.0673),
                heading = 195.9083
            },
            leave = {
                coords = vector3(-595.8946, 2088.1353, 131.3309),
                heading = 43.9493
            },
            finish = {
                coords = vector3(1947.4604, 2683.6985, 42.7468),
                heading = 33.8545
            },
        },
        activities = {
            {
                name = "workout",
                model = {hash = `u_m_y_prisoner_01`},
                coords = vector3(1735.02, 2489.01, 45.83),
                heading = 27.7556,
                randomSection = true, -- Chooses random section when true, or top-to-bottom when false.
                sections = {
                    {
                        name = "lift",
                        coords = vector3(1737.82, 2491.7, 46.12),
                        heading = 202.0358
                    },
                    {
                        name = "situp",
                        coords = vector3(1728.62, 2497.98, 45.84),
                        heading = 123.3956
                    },
                    {
                        name = "pushup",
                        coords = vector3(1733.32, 2499.72, 45.85),
                        heading = 119.1793
                    },
                    {
                        name = "pullup",
                        coords = vector3(1727.35, 2497.18, 45.84),
                        heading = 118.0926
                    },
                }
            },
            {
                name = "clean",
                model = {hash = `u_m_y_prisoner_01`},
                coords =vector3(1782.29, 2502.29, 45.85),
                heading = 111.6702,
                randomSection = true, -- Chooses random section when true, or top-to-bottom when false.
                sections = {
                    {
                        name = "sweep",
                        coords =vector3(1772.42, 2498.78, 45.85), -- Location of the cell.
                        heading = 224.72, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "sweep",
                        coords = vector3(1774.48, 2496.0, 45.85), -- Location of the cell.
                        heading = 207.8018, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "sweep",
                        coords = vector3(1768.32, 2490.26, 45.85), -- Location of the cell.
                        heading = 207.8018, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "sweep",
                        coords = vector3(1768.32, 2490.26, 45.85), -- Location of the cell.
                        heading = 96.14, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "sweep",
                        coords = vector3(1768.32, 2490.26, 45.85), -- Location of the cell.
                        heading = 54.77, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "sweep",
                        coords = vector3(1768.32, 2490.26, 45.85), -- Location of the cell.
                        heading = 53.33 , -- Direction to face the player upon spawn.
                    },
                }
            },
            {
                name = "kitchen",
                model = {hash = `s_m_y_chef_01`},
                coords = vector3(1789.08, 2566.01, 45.62),
                heading = 111.6702,
                randomSection = false, -- Chooses random section when true, or top-to-bottom when false.
                sections = {
                    {
                        name = "stock",
                        coords = vector3(1776.89, 2562.76, 45.62), -- Location of the cell.
                        heading = 97.08, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "cook",
                        coords = vector3(1782.5, 2566.55, 45.62), -- Location of the cell.
                        heading = 173.79, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "toppings",
                        coords = vector3(1782.7, 2561.16, 45.62), -- Location of the cell.
                        heading = 179.1711, -- Direction to face the player upon spawn.
                    },
                    {
                        name = "delivery",
                        coords = vector3(1787.87, 2546.2, 45.62), -- Location of the cell.
                        heading = 140.89, -- Direction to face the player upon spawn.
                    },
                }
            },
        },
        cells = {
            {
                coords = vector3(1772.76, 2497.03, 45.85), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
            {
                coords = vector3(1767.49, 2499.96, 45.86), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
            {
                coords = vector3(1771.74, 2503.37, 45.85), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
            {
                coords = vector3(1751.47, 2491.03, 45.84), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
            {
                coords = vector3(1758.47, 2499.32,44.85), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
            {
                coords = vector3(1769.47, 2482.49, 44.85), -- Location of the cell.
                heading = 207.8018, -- Direction to face the player upon spawn.
                size = 1.5, -- Size to check to see if any players are inside the cell.
            },
        },
        stores = {
            {
                label = "Prison Commissary",
                coords = vector3(1778.19, 2557.54, 45.62),
                heading = 173.8729,
                model = {hash = `s_m_y_chef_01`},
                catalog = {
                   
                    {
                        name = "water",
                        description = "Refreshing sink water that'll quench your thirst.",
                        amount = 1,
                        required = {
                            {type = "cash", amount = 100},
                        }
                    },
                }
            },
            {
                label = "Prison Plug",
                coords = vector3(1598.1722, 2550.0127, 45.5649),
                heading = 287.9169,
                model = {hash = `s_m_y_prisoner_01`},
                catalog = {
                    -- {
                    --     name = "WEAPON_SWITCHBLADE",
                    --     description = "A great tool to take out your enemies.",
                    --     amount = 1,
                    --     required = {
                    --         {type = "item", name = "wood", amount = 1},
                    --         {type = "item", name = "metal", amount = 1},
                    --     }
                    -- },
                    {
                        name = "shovel",
                        description = "Maybe I could use this to escape...",
                        amount = 1,
                        required = {
                            {type = "item", name = "wood", amount = 1},
                            {type = "item", name = "metal", amount = 1},
                            {type = "item", name = "rope", amount = 1},
                        }
                    },
                }
            },
            
        },
        lootables = {
            {
                label = "Wood", -- Lootable Label.
                coords = vector3(1627.9252, 2539.87, 45.7227),
                heading = 277.6246,
                model = {modelType = "prop", hash = `prop_cons_plank`},
                regenTime = 5, -- Time after redemption it can be redeemed again.
                rewards = { -- Rewards for redeeming the lootable.
                    {type = "item", name = "wood", amount = 1},
                },
            },
            {
                label = "Metal",
                coords = vector3(1776.5386, 2563.7231, 45.57),
                heading = 1.5599,
                model = {modelType = "prop", hash = `prop_ladel`, offset = vector3(0.0, 0.0, 1.0)},
                regenTime = 5, -- Time after redemption it can be redeemed again.
                rewards = { -- Rewards for redeeming the lootable.
                    {type = "item", name = "metal", amount = 1},
                },
            },
            {
                label = "Rope",
                coords = vector3(1689.0037, 2548.8884, 45.5604),
                heading = 35.3041,
                model = {modelType = "prop", hash = `prop_rope_family_3`},
                regenTime = 5, -- Time after redemption it can be redeemed again.
                rewards = { -- Rewards for redeeming the lootable.
                    {type = "item", name = "rope", amount = 1},
                },
            },
        }
    }
}
