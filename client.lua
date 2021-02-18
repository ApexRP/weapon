Config = {}

-- weaponlist
Config.WeaponList = {
	453432689, --pistol
	-1076751822, --snspistol
	-771403250, --Heavypistol 
	324215364, --microsmg
	-619010992, --machinepistol
	736523883, --smg
	-1121678507, --minismg
	-1063057011, --specialcarbinerifle
	1649403952, --compactrifle
	487013001, --pumpshotgun
	2017895192, --sawnoffshotgun
	-1600701090, --bzgas
	101631238, --fire
	883325847, --petrolcan
	600439132, --ball
	126349499, --snowball
	-37975472, --smoke
	-1716189206, --knife
	1317494643,  --Hammer
	-1786099057, --bat 
	-2067956739, --Crowbar
	1141786504,  --Golfclub
	-102323637, --Bottle
	-1834847097, --Dagger
	-102973651, --Hatchet
	-656458692, --KnuckleDuster
	-581044007, --Machete
	-538741184, --Switchblade
	-1810795771, --Poolcue
	419712736, --Wrench 
	-853065399, --Battleaxe
}

Config.PedAbleToWalkWhileSwapping = true
Config.UnarmedHash = -1569615261

Citizen.CreateThread(function()
	local animDict = 'reaction@intimidation@1h'

	local animIntroName = 'intro'
	local animOutroName = 'outro'

	local animFlag = 0

	RequestAnimDict(animDict)
	  
	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(100)
	end

	local lastWeapon = nil

	while true do
		Citizen.Wait(0)

		if not IsPedInAnyVehicle(GetPlayerPed(-1), true) then
			if Config.PedAbleToWalkWhileSwapping then
				animFlag = 48
			else
				animFlag = 0
			end

			for i=1, #Config.WeaponList do
				if lastWeapon ~= nil and lastWeapon ~= Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.WeaponList[i] then
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
					TaskPlayAnim(GetPlayerPed(-1), animDict, animIntroName, 8.0, -8.0, 2700, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.WeaponList[i], true)
				end

				if lastWeapon ~= nil and lastWeapon == Config.WeaponList[i] and GetSelectedPedWeapon(GetPlayerPed(-1)) == Config.UnarmedHash then
					TaskPlayAnim(GetPlayerPed(-1), animDict, animOutroName, 8.0, -8.0, 2100, animFlag, 0.0, false, false, false)

					Citizen.Wait(1000)
					SetCurrentPedWeapon(GetPlayerPed(-1), Config.UnarmedHash, true)
				end
			end
		end

		lastWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
	end
end)