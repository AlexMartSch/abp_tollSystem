RegisterNetEvet('abp_TollSystem::Payment', function(tollId) 
    local src = source
    local tollData = Config.Tolls[tollId]
    MakePayment(source, tollData.price)
end)

RegisterNetEvet('abp_TollSystem::PaymentFault', function(tollId) 
    local src = source
    local tollData = Config.Tolls[tollId]
    MakePaymentFault(source, tollData.fine)
end)


-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------