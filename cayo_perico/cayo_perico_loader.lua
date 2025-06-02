local blip
local islandCenter = vector3(4840.571, -5174.425, 2.0) -- Poloha stredu ostrova Cayo Perico
local nearIsland = false -- Kontrola, či je hráč blízko ostrova
local iplsLoaded = false -- Premenná sledujúca, či už boli IPL načítané
local isIslandMapEnabled = false -- Sledovanie, či je mapa ostrova zapnutá

local function requestIPLs()
    if iplsLoaded then return end

    local ipls = {
-- Hlavné prvky ostrova
"h4_islandairstrip", -- Letisko na Cayo Perico
"h4_islandairstrip_props", -- Rekvizity a objekty okolo letiska
"h4_islandx_mansion", -- Hlavné sídlo (mansion)
"h4_islandx_mansion_props", -- Dekoratívne rekvizity a objekty v sídle
"h4_islandx_props", -- Všeobecné rekvizity na ostrove
"h4_islandxdock", -- Hlavný dok ostrova
"h4_islandxdock_props", -- Rekvizity a objekty okolo hlavného doku
"h4_islandxdock_props_2", -- Ďalšie rekvizity hlavného doku
"h4_islandxtower", -- Strážna veža na ostrove
"h4_islandx_maindock", -- Hlavný prístavný dok
"h4_islandx_maindock_props", -- Rekvizity a objekty okolo prístavu
"h4_islandx_maindock_props_2", -- Ďalšie prístavné rekvizity
"h4_IslandX_Mansion_Vault", -- Trezor v sídle
"h4_islandairstrip_propsb", -- Dodatočné rekvizity letiska

-- Plážové oblasti
"h4_beach", -- Pláž
"h4_beach_props", -- Rekvizity na pláži
"h4_beach_bar_props", -- Rekvizity plážového baru
"h4_islandx_barrack_props", -- Rekvizity kasární
"h4_islandx_checkpoint", -- Kontrolný bod
"h4_islandx_checkpoint_props", -- Rekvizity kontrolného bodu
"h4_islandx_Mansion_Office", -- Kancelária v sídle
"h4_islandx_Mansion_LockUp_01", -- Sklad v sídle 01
"h4_islandx_Mansion_LockUp_02", -- Sklad v sídle 02
"h4_islandx_Mansion_LockUp_03", -- Sklad v sídle 03
"h4_islandairstrip_hangar_props", -- Rekvizity hangáru na letisku
"h4_IslandX_Mansion_B", -- Vedľajšie budovy sídla
"h4_islandairstrip_doorsclosed", -- Zavreté dvere na letisku
"h4_Underwater_Gate_Closed", -- Zavretá podvodná brána
"h4_mansion_gate_closed", -- Zavretá brána sídla

-- Ochranné a bezpečnostné prvky
"h4_aa_guns", -- Protitankové zbrane
"h4_IslandX_Mansion_GuardFence", -- Oplotenie strážcov sídla
"h4_IslandX_Mansion_Entrance_Fence", -- Vstupné oplotenie sídla
"h4_IslandX_Mansion_B_Side_Fence", -- Bočné oplotenie sídla
"h4_IslandX_Mansion_Lights", -- Osvetlenie sídla
"h4_islandxcanal_props", -- Rekvizity kanálov
"h4_beach_props_party", -- Rekvizity pre plážovú párty

-- Prírodné rekvizity a vegetácia
"h4_islandX_Terrain_props_06_a", -- Prírodné rekvizity, časť 06_a
"h4_islandX_Terrain_props_06_b", -- Prírodné rekvizity, časť 06_b
"h4_islandX_Terrain_props_06_c", -- Prírodné rekvizity, časť 06_c
--"h4_islandX_Terrain_props_05_a", -- Prírodné rekvizity, časť 05_a  Marihuana-Kokain
--"h4_islandX_Terrain_props_05_b", -- Prírodné rekvizity, časť 05_b  Marihuana-Kokain
--"h4_islandX_Terrain_props_05_c", -- Prírodné rekvizity, časť 05_c  Marihuana-Kokain
--"h4_islandX_Terrain_props_05_d", -- Prírodné rekvizity, časť 05_d  Marihuana-Kokain
"h4_islandX_Terrain_props_05_e", -- Prírodné rekvizity, časť 05_e
"h4_islandX_Terrain_props_05_f", -- Prírodné rekvizity, časť 05_f

-- Terénne prvky ostrova
"H4_islandx_terrain_01", -- Terén ostrova, časť 01
"H4_islandx_terrain_02", -- Terén ostrova, časť 02
"H4_islandx_terrain_03", -- Terén ostrova, časť 03
"H4_islandx_terrain_04", -- Terén ostrova, časť 04
"H4_islandx_terrain_05", -- Terén ostrova, časť 05
"H4_islandx_terrain_06", -- Terén ostrova, časť 06

-- Severná oblasť ostrova
"h4_ne_ipl_00", -- Severovýchodná časť 00
"h4_ne_ipl_01", -- Severovýchodná časť 01
"h4_ne_ipl_02", -- Severovýchodná časť 02
"h4_ne_ipl_03", -- Severovýchodná časť 03
"h4_ne_ipl_04", -- Severovýchodná časť 04
"h4_ne_ipl_05", -- Severovýchodná časť 05
"h4_ne_ipl_06", -- Severovýchodná časť 06
"h4_ne_ipl_07", -- Severovýchodná časť 07
"h4_ne_ipl_08", -- Severovýchodná časť 08
"h4_ne_ipl_09", -- Severovýchodná časť 09

-- Severozápadná oblasť ostrova
"h4_nw_ipl_00", -- Severozápadná časť 00
"h4_nw_ipl_01", -- Severozápadná časť 01
"h4_nw_ipl_02", -- Severozápadná časť 02
"h4_nw_ipl_03", -- Severozápadná časť 03
"h4_nw_ipl_04", -- Severozápadná časť 04
"h4_nw_ipl_05", -- Severozápadná časť 05
"h4_nw_ipl_06", -- Severozápadná časť 06
"h4_nw_ipl_07", -- Severozápadná časť 07
"h4_nw_ipl_08", -- Severozápadná časť 08
"h4_nw_ipl_09", -- Severozápadná časť 09

-- Juhovýchodná oblasť ostrova
"h4_se_ipl_00", -- Juhovýchodná časť 00
"h4_se_ipl_01", -- Juhovýchodná časť 01
"h4_se_ipl_02", -- Juhovýchodná časť 02
"h4_se_ipl_03", -- Juhovýchodná časť 03
"h4_se_ipl_04", -- Juhovýchodná časť 04
"h4_se_ipl_05", -- Juhovýchodná časť 05
"h4_se_ipl_06", -- Juhovýchodná časť 06
"h4_se_ipl_07", -- Juhovýchodná časť 07
"h4_se_ipl_08", -- Juhovýchodná časť 08
"h4_se_ipl_09", -- Juhovýchodná časť 09

-- Juhozápadná oblasť ostrova
"h4_sw_ipl_00", -- Juhozápadná časť 00
"h4_sw_ipl_01", -- Juhozápadná časť 01
"h4_sw_ipl_02", -- Juhozápadná časť 02
"h4_sw_ipl_03", -- Juhozápadná časť 03
"h4_sw_ipl_04", -- Juhozápadná časť 04
"h4_sw_ipl_05", -- Juhozápadná časť 05
"h4_sw_ipl_06", -- Juhozápadná časť 06
"h4_sw_ipl_07", -- Juhozápadná časť 07
"h4_sw_ipl_08", -- Juhozápadná časť 08
"h4_sw_ipl_09", -- Juhozápadná časť 09

-- Ďalšie špecifické prvky ostrova
"h4_islandx_mansion", -- Hlavné sídlo
"h4_islandxtower_veg", -- Vegetácia okolo veže
"h4_islandx_sea_mines", -- Námorné míny okolo ostrova
"h4_islandx", -- Celkový ostrov
"h4_islandx_barrack_hatch", -- Poklop v kasárňach
"h4_islandxdock_water_hatch", -- Vodný poklop doku
"h4_beach_party", -- Plážová párty
"h4_mph4_terrain_01_grass_0", -- Terénne prvky, tráva 0
"h4_mph4_terrain_01_grass_1", -- Terénne prvky, tráva 1
"h4_mph4_terrain_02_grass_0", -- Terénne prvky, tráva 0
"h4_mph4_terrain_02_grass_1", -- Terénne prvky, tráva 1
"h4_mph4_terrain_02_grass_2", -- Terénne prvky, tráva 2
"h4_mph4_terrain_02_grass_3", -- Terénne prvky, tráva 3
"h4_mph4_terrain_04_grass_0", -- Terénne prvky, tráva 0
"h4_mph4_terrain_04_grass_1", -- Terénne prvky, tráva 1
"h4_mph4_terrain_04_grass_2", -- Terénne prvky, tráva 2
"h4_mph4_terrain_04_grass_3", -- Terénne prvky, tráva 3
"h4_mph4_terrain_05_grass_0", -- Terénne prvky, tráva 0
"h4_mph4_terrain_06_grass_0", -- Terénne prvky, tráva 0
"h4_mph4_airstrip_interior_0_airstrip_hanger" -- Interiér hangáru na letisku
    }

    for _, ipl in ipairs(ipls) do
        RequestIpl(ipl)
    end

    iplsLoaded = true
end

AddEventHandler('playerSpawned', function()
    requestIPLs()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        requestIPLs()
        blip = AddBlipForCoord(5943.5679611650485, -6272.114833599767, 2) -- Blip pre ostrov (neviditeľný)
        SetBlipAlpha(blip, 0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Kontroluje vzdialenosť hráča od ostrova

        local playerPed = PlayerPedId()
        local playerPos = GetEntityCoords(playerPed)
        local distance = #(playerPos - islandCenter)
        local isNearIslandNow = distance < 2000

        if isNearIslandNow ~= nearIsland then
            nearIsland = isNearIslandNow

            if nearIsland then
                SetUseIslandMap(true)
                isIslandMapEnabled = true
                SetRadarAsInteriorThisFrame(GetHashKey("h4_fake_islandx"), 4700.0, -5145.0, 0.0, 0.0)
                SetScenarioGroupEnabled("Heist_Island_Peds", true)
                SetAudioFlag("PlayerOnDLCHeist4Island", true)
                SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", true, true)
                SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones", false, true)
                SetDeepOceanScaler(0.0)
                SetZoneEnabled(GetZoneFromNameId("PrLog"), false)
            else
                SetUseIslandMap(false)
                isIslandMapEnabled = false
                SetRadarAsInteriorThisFrame(0, 0.0, 0.0, 0.0, 0.0)
                SetScenarioGroupEnabled("Heist_Island_Peds", false)
                SetAudioFlag("PlayerOnDLCHeist4Island", false)
                SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Zones", false, false)
                SetAmbientZoneListStatePersistent("AZL_DLC_Hei4_Island_Disabled_Zones", false, false)
                ResetDeepOceanScaler()
                SetZoneEnabled(GetZoneFromNameId("PrLog"), true)
            end
        end
    end
end)