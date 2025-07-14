ESX = nil
local RegisteredSocieties = {}

ESX = exports["es_extended"]:getSharedObject()
local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getMoneyFromUser(id_user)
	local xPlayer = ESX.GetPlayerFromId(id_user)
	return xPlayer.getMoney()

end

local function getBlackMoneyFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('black_money')
	return account.money

end

local function getBankFromUser(id_user)
		local xPlayer = ESX.GetPlayerFromId(id_user)
		local account = xPlayer.getAccount('bank')
	return account.money

end


RegisterCommand("työ", function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local job = xPlayer.job.label
  local jobgrade = xPlayer.job.grade_label
  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Työ: ' .. job .. ' | Arvo: ' .. jobgrade})
end)

RegisterCommand("käteinen", function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local wallet = getMoneyFromUser(_source)
  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Käteinen: ' .. wallet .. '€'})
end)


RegisterCommand("pankki", function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local bank 			= getBankFromUser(_source)
  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Pankki: ' .. bank .. '€'})
end)

RegisterCommand("likainen", function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local black_money 	= getBlackMoneyFromUser(_source)

  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Likainen raha: ' .. black_money .. '€'})
end)

RegisterCommand("tiedot", function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local job = xPlayer.job.label
  local jobgrade = xPlayer.job.grade_label
  local wallet 		= getMoneyFromUser(_source)
  local bank 			= getBankFromUser(_source)
  local black_money 	= getBlackMoneyFromUser(_source)
  if xPlayer.job.grade_name == 'omistaja' or xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'hallinto' then
  local society = GetSociety(xPlayer.job.name)
  if society ~= nil then
    TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
      money = account.money
    end)
  else
    money = 0
  end

              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Työ: ' .. job .. ' | Arvo: ' .. jobgrade})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Käteinen: ' .. wallet .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Pankki: ' .. bank .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Likainen raha: ' .. black_money .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Firmantili: ' .. money .. '€'})

else
        
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Työ: ' .. job .. ' | Arvo: ' .. jobgrade})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Käteinen: ' .. wallet .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Pankki: ' .. bank .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Likainen raha: ' .. black_money .. '€'})
              Citizen.Wait(1500)
              TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Et ole pomo!'})

end
end)

RegisterCommand("tili", function(source, args, rawCommand)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.grade_name == 'omistaja' or xPlayer.job.grade_name == 'boss' or xPlayer.job.grade_name == 'hallinto' then
		local society = GetSociety(xPlayer.job.name)
		if society ~= nil then
			TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function(account)
				money = account.money
			end)
		else
			money = 0
		end
		
	        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Firmantili: ' .. money .. '€'})
																	
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Et ole pomo!'})

	end
end)

TriggerEvent('esx_society:getSocieties', function(societies) 
	RegisteredSocieties = societies
end)
function GetSociety(name)
  for i=1, #RegisteredSocieties, 1 do
    if RegisteredSocieties[i].name == name then
      return RegisteredSocieties[i]
    end
  end
end