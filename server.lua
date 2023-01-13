local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
sRP = {}
Tunnel.bindInterface("vrp_banco",sRP)


local webhookdepositar = "https://discord.com/api/webhooks/938163273742827580/Aes44NOU8FcNk6CZLcAldX1VIbw3_9nmTPGLgjT2yqqDN8rPrI4YQZj3lNkj2Yj5xPJo"
local webhooksacar = "https://discord.com/api/webhooks/938163633832198274/A9CwUKGu8jwRLeQfcK12f0IzPC8541gs2fbDGdGOFGcF55W-cJlOe2ICf6sJ3VQBJ9MQ"
local webhookmulta = "https://discord.com/api/webhooks/938163889726697492/D0SuNZTDYMmxBXzU4zyR1lxiCcf9kIREVvg2Rgozjf63fgfwcpKukBhpDIL00h-ARmrf"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
------------------------------------------------------------------------------------------------------------
-- SCRIPT
------------------------------------------------------------------------------------------------------------
function sRP.enableBanking()
    local source = source 
    local user_id = vRP.getUserId(source)
    local banco = vRP.getBankMoney(user_id)
    local carteira = vRP.getMoney(user_id)
    local identity = vRP.getUserIdentity(user_id)
    local salario = vRP.getUData(user_id,"vRP:Salario")
    local salario2 = json.decode(salario) or 0
    if user_id then 
        TriggerClientEvent("send:banco", source, parseInt(banco),parseInt(carteira),identity.name.." "..identity.firstname,parseInt(salario2))
    end
end

function sRP.quickCash()
    local source = source 
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then 
        local mymultas = vRP.getUData(user_id,"vRP:multas")
        local multas = json.decode(mymultas) or 0
        if multas >= 30000 then
          TriggerClientEvent("Notify",source,"negado","Encontramos <b>multas pendentes</b>, não fornecemos dinheiro aos devedores.",3000)
          return
        end
        if vRP.tryWithdraw(user_id,1000) then
            local banco = vRP.getBankMoney(user_id)
            local carteira = vRP.getMoney(user_id)
            TriggerClientEvent("Notify",source,"sucesso","Você sacou <b>$ "..vRP.format(1000).."</b> da sua conta.",5000)
            TriggerClientEvent("banking:updateBalance77784844484",source,parseInt(banco),parseInt(carteira))
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua conta bancária.",5000)
        end
    end
end

function sRP.fastCash()
    local source = source 
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then 
        local mymultas = vRP.getUData(user_id,"vRP:multas")
        local multas = json.decode(mymultas) or 0
        if multas >= 30000 then
          TriggerClientEvent("Notify",source,"negado","Encontramos <b>multas pendentes</b>, não fornecemos dinheiro aos devedores.",3000)
          return
        end
        if vRP.tryDeposit(user_id,1000) then
            local banco = vRP.getBankMoney(user_id)
            local carteira = vRP.getMoney(user_id)
            TriggerClientEvent("Notify",source,"sucesso","Você depositou <b>$ "..vRP.format(1000).."</b> na sua conta.",5000)
            TriggerClientEvent("banking:updateBalance77784844484",source,parseInt(banco),parseInt(carteira))
        else
            TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua carteira.",5000)
        end
    end
end

function sRP.sacarDinheiro(amount)
    local source = source 
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then 
        local mymultas = vRP.getUData(user_id,"vRP:multas")
        local multas = json.decode(mymultas) or 0
        if multas >= 30000 then
          TriggerClientEvent("Notify",source,"negado","Encontramos <b>multas pendentes</b>, não fornecemos dinheiro aos devedores.",3000)
          return
        end
    
       if parseInt(amount) > 0 then
           if vRP.tryWithdraw(user_id,parseInt(amount)) then
                local banco = vRP.getBankMoney(user_id)
                local carteira = vRP.getMoney(user_id)
                TriggerClientEvent("Notify",source,"sucesso","Você sacou <b>$ "..amount.."</b> da sua conta.",5000)
                TriggerClientEvent("banking:updateBalance77784844484",source,parseInt(banco),parseInt(carteira))
                SendWebhookMessage(webhooksacar,"```prolog\n[ID]: "..user_id.." "..identity["name"].." "..identity["firstname"].." \n[SACOU]: $"..vRP.format(parseInt(amount)).."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
           else
                TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua conta bancária.",5000)
           end
       end
    end
end

function sRP.depositarDinheiro(amount)
    local source = source 
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then 
        if parseInt(amount) > 0 then
            if vRP.tryDeposit(user_id,parseInt(amount)) then
              local banco = vRP.getBankMoney(user_id)
              local carteira = vRP.getMoney(user_id)            
              TriggerClientEvent("Notify",source,"sucesso","Você depositou <b>$ "..amount.."</b> na sua conta.",5000)
              TriggerClientEvent("banking:updateBalance77784844484",source,parseInt(banco),parseInt(carteira))
              SendWebhookMessage(webhookdepositar,"```prolog\n[ID]: "..user_id.." "..identity["name"].." "..identity["firstname"].." \n[DEPOSITOU]: $"..vRP.format(parseInt(amount)).."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            else
              TriggerClientEvent("Notify",source,"negado","Dinheiro <b>insuficiente</b> na sua carteira.",5000)
            end
        end
    end
end

function sRP.pagarMultas(amount)
    local source = source 
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local banco = vRP.getBankMoney(user_id)
    local carteira = vRP.getMoney(user_id)
    local mymultas = vRP.getUData(user_id,"vRP:multas")
    local multas = json.decode(mymultas) or 0
    if user_id then 
        if banco >= parseInt(amount) and parseInt(amount) > 0 then
            if parseInt(amount) <= parseInt(multas) then
                local reward = parseInt(amount)
                vRP.setBankMoney(user_id,parseInt(banco-reward))
                vRP.setUData(user_id,"vRP:multas",json.encode(parseInt(multas)-parseInt(reward)))
                
                local bancox = vRP.getBankMoney(user_id)
                local carteirax = vRP.getMoney(user_id)

                TriggerClientEvent("Notify",source,"sucesso","Você pagou <b>$"..reward.." dólares</b> em multas.",8000)
                TriggerClientEvent("banking:updateBalance77784844484",source,parseInt(bancox),parseInt(carteirax))
                SendWebhookMessage(webhookmulta,"```prolog\n[ID]: "..user_id.." "..identity["name"].." "..identity["firstname"].." \n[PAGOU EM MULTAS]: $"..vRP.format(parseInt(amount)).."  "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                else
                    TriggerClientEvent("Notify",source,"negado","Você não pode pagar mais do que deve.",8000)
                end
            else
            TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
        end
    end
end

function sRP.returnMultas()
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then 
        local mymultas = vRP.getUData(user_id,"vRP:multas")
        local multas = json.decode(mymultas) or 0
        return multas
    end
end


