local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_banco")


sRP = Tunnel.getInterface("vrp_banco")


local giveCashAnywhere = false 
local withdraWAnywhere = false 
local depositAnywhere = false 
local displayBankBlips = true 
local enableBankingGui = true 

local banks = {
  {name="Banco", id=108, x=150.266, y=-1040.203, z=29.374},
  {name="Banco", id=108, x=-1212.980, y=-330.841, z=37.787},
  {name="Banco", id=108, x=-2962.582, y=482.627, z=15.703},
  {name="Banco", id=108, x=-112.202, y=6469.295, z=31.626},
  {name="Banco", id=108, x=314.187, y=-278.621, z=54.170},
  {name="Banco", id=108, x=-351.534, y=-49.529, z=49.042},
  {name="Banco", id=108, x=237.44, y=217.82, z=106.28},
  {name="Banco", id=108, x=1370.93, y=-763.53, z=67.39}, --helipa
  {name="ATM", id=277, x=-386.733, y=6045.953, z=31.501},
  {name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
  {name="ATM", id=277, x=-284.037, y=6224.385, z=31.187},
  {name="ATM", id=277, x=-135.165, y=6365.738, z=31.101},
  {name="ATM", id=277, x=-110.753, y=6467.703, z=31.784},
  {name="ATM", id=277, x=-94.9690, y=6455.301, z=31.784},
  {name="ATM", id=277, x=155.4300, y=6641.991, z=31.784},
  {name="ATM", id=277, x=174.6720, y=6637.218, z=31.784},
  {name="ATM", id=277, x=1701.36, y=6426.65, z=32.77},
  {name="ATM", id=277, x=1735.114, y=6411.035, z=35.164},
  {name="ATM", id=277, x=1702.842, y=4933.593, z=42.051},
  {name="ATM", id=277, x=1967.333, y=3744.293, z=32.272},
  {name="ATM", id=277, x=1821.917, y=3683.483, z=34.244},
  {name="ATM", id=277, x=1174.532, y=2705.278, z=38.027},
  {name="ATM", id=277, x=540.0420, y=2671.007, z=42.177},
  {name="ATM", id=277, x=2564.399, y=2585.100, z=38.016},
  {name="ATM", id=277, x=2558.683, y=349.6010, z=108.050},
  {name="ATM", id=277, x=2558.051, y=389.4817, z=108.660},
  {name="ATM", id=277, x=1077.692, y=-775.796, z=58.218},
  {name="ATM", id=277, x=-577.08, y=-194.76, z=38.21},
  {name="ATM", id=277, x= 947.79, y=-965.18, z=39.76},
  {name="ATM", id=277, x= 1123.24, y=-653.7, z=56.75},
  {name="ATM", id=277, x= 417.78, y= 6471.53, z= 28.82},
  {name="ATM", id=277, x= 38.44, y=6544, z=31.55},
  {name="ATM", id=277, x= 645.7, y=-3014.66, z=6.24},
  {name="ATM", id=277, x= -425.75, y=-2788.2, z=38.21},
  {name="ATM", id=277, x= 324.97, y=-224.34, z=54.08},
  {name="ATM", id=277, x= -200.11, y=-1309.44, z=31.3},
  {name="ATM", id=277, x= -425.51, y= -2787.94, z= 6.01},
  

 -- {name="ATM", id=277, x=1139.018, y=-469.886, z=66.789},
 -- {name="ATM", id=277, x=1168.975, y=-457.241, z=66.641}, 
  {name="ATM", id=277, x=1153.884, y=-326.540, z=69.245},
  {name="ATM", id=277, x=-1074.31, y=-827.41, z=27.03}, -- dp
  {name="ATM", id=277, x=-1073.90, y=-827.74, z=19.03}, -- dp
  {name="ATM", id=277, x=-1110.88, y=-836.32, z=19.00}, -- dp
  {name="ATM", id=277, x=129.66, y=-1291.97, z=29.26}, -- vanilla
  {name='ATM', id=277, x=1152.46, y=-1535.01, z=35.39}, -- hospital
  --{name="ATM", id=277, x=-1810.58, y=-1208.23, z=14.30}, -- pier 
  {name="ATM", id=277, x=381.2827, y=323.2518, z=103.270},
  --{name="ATM", id=277, x=236.4638, y=217.4718, z=106.840},
  {name="ATM", id=277, x=265.0043, y=212.1717, z=106.780},
  {name="ATM", id=277, x=285.2029, y=143.5690, z=104.970},
  {name="ATM", id=277, x=157.7698, y=233.5450, z=106.450},
  {name="ATM", id=277, x=-164.568, y=233.5066, z=94.919},
  {name="ATM", id=277, x=-1827.04, y=785.5159, z=138.020},
  {name="ATM", id=277, x=-1409.39, y=-99.2603, z=52.473},
  {name="ATM", id=277, x=-1205.35, y=-325.579, z=37.870},
  --{name="ATM", id=277, x=-2072.41, y=-316.959, z=13.345},
  {name="ATM", id=277, x=-2975.72, y=379.7737, z=14.992},
  ---
  {name="ATM", id=277, x=-3044.22, y=595.2429, z=7.595},
  {name="ATM", id=277, x=-3144.13, y=1127.415, z=20.868},
  {name="ATM", id=277, x=-3241.10, y=996.6881, z=12.500},
  {name="ATM", id=277, x=-3241.11, y=1009.152, z=12.877},
  {name="ATM", id=277, x=-1305.40, y=-706.240, z=25.352},
  {name="ATM", id=277, x=-538.225, y=-854.423, z=29.234},
  {name="ATM", id=277, x=-711.156, y=-818.958, z=23.768},
  {name="ATM", id=277, x=-717.614, y=-915.880, z=19.268},
  {name="ATM", id=277, x=-526.566, y=-1222.90, z=18.434},
  {name="ATM", id=277, x=-256.831, y=-719.646, z=33.444},
 -- {name="ATM", id=277, x=-203.548, y=-861.588, z=30.205},
  {name="ATM", id=277, x=112.4102, y=-776.162, z=31.427},
  {name="ATM", id=277, x=112.9290, y=-818.710, z=31.386},
  {name="ATM", id=277, x=119.9000, y=-883.826, z=31.191},
  --{name="ATM", id=277, x=-846.304, y=-340.402, z=38.687},
  {name="ATM", id=277, x=-56.1935, y=-1752.53, z=29.452},
  {name="ATM", id=277, x=-261.692, y=-2012.64, z=30.121},
  {name="ATM", id=277, x=-273.001, y=-2025.60, z=30.197},
  {name="ATM", id=277, x=314.187, y=-278.621, z=54.170},
  {name="ATM", id=277, x=-351.534, y=-49.529, z=49.042},
  {name="ATM", id=277, x=24.589, y=-946.056, z=29.357},
  {name="ATM", id=277, x=-254.112, y=-692.483, z=33.616},
  {name="ATM", id=277, x=-1570.197, y=-546.651, z=34.955},
  {name="ATM", id=277, x=-1415.909, y=-211.825, z=46.500},
  {name="ATM", id=277, x=-1430.112, y=-211.014, z=46.500},
  {name="ATM", id=277, x=33.232, y=-1347.849, z=29.497}, 
  --{name="ATM", id=277, x=129.216, y=-1292.347, z=29.269},
  {name="ATM", id=277, x=287.645, y=-1282.646, z=29.659},
  {name="ATM", id=277, x=289.012, y=-1256.545, z=29.440},
  {name="ATM", id=277, x=295.839, y=-895.640, z=29.217},
  {name="ATM", id=277, x=1686.753, y=4815.809, z=42.008},
  --{name="ATM", id=277, x=-302.408, y=-829.945, z=32.417},
  {name="ATM", id=277, x=5.134, y=-919.949, z=29.557},
  {name="ATM", id=277, x=419.07, y=-986.37, z=29.38},
  --[[ {name="ATM", id=277, x=-31.548, y=-1121.443, z=26.547}, ]]
  --{name="ATM", id=277, x=296.125, y=-591.370, z=43.275},
  {name="ATM", id=277, x=-1391.021, y=-590.427, z=30.319},
  {name="ATM", id=277, x=2683.11, y=3286.63, z=55.24},
  {name="ATM", id=277, x=1881.96, y=6388.87, z=66.16},
  {name='ATM', id=277, x=315.18, y=-593.72, z=43.29},
  {name='ATM', id=277, x=-37.8, y=-1115.2, z=26.44},
  {name='ATM', id=277, x=-875.68, y=-1458.58, z=7.53},
  {name='ATM', id=277, x=1116.08, y=219.78, z=-49.43},
  {name='ATM', id=277, x=1393.1, y=1134.6, z=114.34}, --lavagem fazenda
  {name='ATM', id=277, x=-1830.13, y=-1212.8, z=13.02},  --pier

}

--[[Citizen.CreateThread(function()
  if displayBankBlips then
    for k,v in ipairs(banks)do
      if v.name ~= "ATM" then 
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, v.id)
        SetBlipScale(blip, 0.4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING");
        AddTextComponentString(tostring(v.name))
        EndTextCommandSetBlipName(blip)
      end
    end
  end
end)]]

local atBank = false
local bankOpen = false

RegisterNetEvent('send:banco')
AddEventHandler('send:banco', function(banco,carteira,nome,salario)
  TransitionToBlurred(1000)
  SetNuiFocus(true, true)
  SendNUIMessage({
    openBank = true,
    bank = banco,
    cart = carteira,
    identidade = nome,
    multas = sRP.returnMultas(),
    salario = salario,
  })
end)

function closeGui()
  TransitionFromBlurred(1000)
  SetNuiFocus(false)
  SendNUIMessage({openBank = false})
  bankOpen = false
  atmOpen = false
end

Citizen.CreateThread(function()
  while true do
    local oInfinity = 1000
    local pos = GetEntityCoords(PlayerPedId(), true)
    for k, j in pairs(banks) do
        if(Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 3.0) then
          oInfinity = 5
          if j.name == "ATM" then 
            DrawText3D(j.x,j.y,j.z+0.2,"~b~E~w~ - ATM")
          else
            DrawText3D(j.x,j.y,j.z+0.2,"~b~E~w~ - BANCO")
          end
           if IsControlJustPressed(0, 38) and Vdist(pos.x, pos.y, pos.z, j.x, j.y, j.z) < 2.0  then 
            if(IsNearBank()) then
              sRP.enableBanking()
              bankOpen = true
            end
           end
        end
      end
    Citizen.Wait(oInfinity)
  end
end)

Citizen.CreateThread(function()
  while true do
    local oInfinity = 1000
    if bankOpen then
      local oInfinity = 4
      local ply = PlayerPedId()
      local active = true
      DisableControlAction(0, 1, active) 
      DisableControlAction(0, 2, active) 
      DisableControlAction(0, 24, active) 
      DisablePlayerFiring(ply, true) 
      DisableControlAction(0, 142, active)
      DisableControlAction(0, 106, active) 
    end
    Citizen.Wait(oInfinity)
  end
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
end)

RegisterNUICallback('balance', function(data, cb)
  SendNUIMessage({openSection = "balance"})
  
end)

RegisterNUICallback('withdraw', function(data, cb)
  SendNUIMessage({openSection = "withdraw"})
end)

RegisterNUICallback('deposit', function(data, cb)
  SendNUIMessage({openSection = "deposit"})
end)

RegisterNUICallback('transfer', function(data, cb)
  SendNUIMessage({openSection = "transfer"})
end)

RegisterNUICallback('quickCash', function(data, cb)
  sRP.quickCash()
end)

RegisterNUICallback('fastCash', function(data, cb)
  sRP.fastCash()
end)

RegisterNUICallback('withdrawSubmit', function(data, cb)
  sRP.sacarDinheiro(data.amount)
end)

RegisterNUICallback('depositSubmit', function(data, cb)
  bankDeposit(data.amount)
end)

RegisterNUICallback('multasSubmit', function(data, cb)
  sRP.pagarMultas(data.amount)
end)

RegisterNUICallback('transferSubmit', function(data, cb)
  local toPlayer = data.toPlayer
  local amount = data.amount
  TriggerServerEvent("bank:transfer86486484848", toPlayer, tonumber(amount))
end)


function IsNearBank()
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  for _, item in pairs(banks) do
    local distance = GetDistanceBetweenCoords(item.x, item.y, item.z,  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
    if (distance <= 3) then
      return true
    end
  end
end


function IsNearPlayer(player)
  local ply = PlayerPedId()
  local plyCoords = GetEntityCoords(ply, 0)
  local ply2 = GetPlayerPed(GetPlayerFromServerId(player))
  local ply2Coords = GetEntityCoords(ply2, 0)
  local distance = GetDistanceBetweenCoords(ply2Coords["x"], ply2Coords["y"], ply2Coords["z"],  plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
  if (distance <= 5) then
    return true
  end
end


function bankDeposit(amount)
  if(IsNearBank() == true or depositAnywhere == true ) then
    sRP.depositarDinheiro(tonumber(amount))
  else
    TriggerEvent("Notify","negado","Você só pode depositar em um banco!")
  end
end


RegisterNetEvent('bank:withdraw86486484848')
AddEventHandler('bank:withdraw86486484848', function(amount)
  if(IsNearBank() == true or withdraWAnywhere == true) then
      TriggerServerEvent("bank:withdraw86486484848", tonumber(amount))
  else
    TriggerEvent("Notify","negado","Você só pode sacar em um banco!")
  end
end)


RegisterNetEvent('bank:givecash86486484848')
AddEventHandler('bank:givecash86486484848', function(toPlayer, amount)
  if(IsNearPlayer(toPlayer) == true or giveCashAnywhere == true) then
    local player2 = GetPlayerFromServerId(toPlayer)
    local playing = IsPlayerPlaying(player2)
    if (playing ~= false) then
      TriggerServerEvent("bank:givecash86486484848", toPlayer, tonumber(amount))
      vRP.notify("Você transferiu " .. tonumber(amount) .. " para " .. toPlayer)
    else
      vRP.notifyWarning("Cidadão fora da cidade!")
    end
  else
    vRP.notifyWarning("Cidadão não mora nessa cidade!")
  end
end)

RegisterNetEvent('banking:updateBalance77784844484')
AddEventHandler('banking:updateBalance77784844484', function(balance,carteira)
  SendNUIMessage({
    updateBalance = true,
    bank = balance,
    cart = carteira
  })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW3DS
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z, text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,50)
end
