local Toll = {}
Toll.InAnyToll = false

local function isInToll(vehicle, tollData)
    local timeToGo = Config.TimeToGo
    
    CreateThread(function() 
        while Toll.InAnyToll do

            local speed = (GetEntitySpeed(vehicle) * 3.6)
    
            if speed > 0 then
                if Config.UseCustomNotifications then
                    Notify(locale("PLEASE_STOP"))
                else
                    if Config.UseLibNotifications then
                        lib.notify({
                            description = locale("PLEASE_STOP"),
                            type = "warning"
                        })
                    else
                        BottomNotification(locale("PLEASE_STOP"), 1000)
                    end
                end
                timeToGo = Config.TimeToGo
            else
                if timeToGo <= 0 then
    
                    if Config.UseCustomNotifications then
                        Notify(locale("PAYMENT_COMPLETED"))
                    else
                        if Config.UseLibNotifications then
                            lib.notify({
                                description = locale("PAYMENT_COMPLETED"),
                                type = "success"
                            })
                        else
                            BottomNotification(locale("PAYMENT_COMPLETED"), 1000)
                        end
                    end
    
                    if Config.UseCustomAdvancedNotifications then
                        AdvancedNotify(locale("PAYMENT_COMPLETED_ADVANCED", tollData.price))
                    else
                        ShowAdvancedNotification(locale("TOLL"), '', locale("PAYMENT_COMPLETED_ADVANCED", tollData.price), "CHAR_LS_TOURIST_BOARD", 1, true, false, 70)
                    end

                    TriggerServerEvent('abp_TollSystem::Payment', tollData.tollId)

                    PlaySoundFrontend(-1, "Pin_Good", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
                    Toll.InAnyToll = false
                else
    
                    if Config.UseCustomNotifications then
                        Notify(locale("READY_IN", timeToGo))
                    else
                        if Config.UseLibNotifications then
                            lib.notify({
                                description = locale("READY_IN", timeToGo),
                                type = "warning"
                            })
                        else
                            BottomNotification(locale("READY_IN", timeToGo), 1000)
                        end
                    end
    
                    timeToGo -= 1
                end
            end
            
            Wait(1000)
        end
    end)
end

local function isOutToll(vehicle, tollData)

    local mustPay = true

    if Config.EmergencyVehiclesNoPayWhenSirenOn then
        if IsVehicleSirenOn(vehicle) then
            mustPay = false
        end
    end

    if mustPay then
        if Config.FineWhenEscaping then
            if Config.UseCustomAdvancedNotifications then
                AdvancedNotify(locale("PAYMENT_COMPLETED_ADVANCED"))
            else
                ShowAdvancedNotification(locale("TOLL"), locale("PAYMENT_FAULT"), locale("PAYMENT_COMPLETED_ADVANCED"), "CHAR_LS_TOURIST_BOARD", 1, true, false, 70)
            end

            TriggerServerEvent('abp_TollSystem::PaymentFault', tollData.tollId)
        end
    else
        if Config.UseCustomAdvancedNotifications then
            AdvancedNotify(locale("PAYMENT_FOR_EMERGENCY"))
        else
            ShowAdvancedNotification(locale("TOLL"), '', locale("PAYMENT_FOR_EMERGENCY"), "CHAR_LS_TOURIST_BOARD", 1, true, false, 70)
        end
    end

end

local function initScript()
    for tollIndex, toll in pairs(Config.Tolls) do

        local function onEnter(self)
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                
                if vehicle and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                    Toll.InAnyToll = true
                    isInToll(vehicle, self)
                end

            end
        end
        
        local function onExit(self)
            if Toll.InAnyToll then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                    
                    if vehicle and (GetPedInVehicleSeat(vehicle, -1) == PlayerPedId()) then
                        Toll.InAnyToll = false
                        isOutToll(vehicle, self)
                    end

                end
            end
        end

        for _, tollStation in pairs(toll.stations) do
            Config.Tolls[tollIndex].Zone = lib.zones.sphere({
                coords = tollStation,
                radius =  2.5,
                debug = Config.DebugMode,
                onEnter = onEnter,
                onExit = onExit,
                tollId = tollIndex,
                price = toll.price,
                fine = toll.fine
            })
        end
    end
end


initScript()

