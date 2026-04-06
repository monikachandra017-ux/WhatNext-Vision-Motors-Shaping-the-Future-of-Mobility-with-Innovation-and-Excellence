trigger VehicleOrderTrigger on Vehicle_Order__c (before insert, before update) {

    for (Vehicle_Order__c order : Trigger.new) {

        // 🔹 Stock Validation
        Vehicle__c vehicle = [
            SELECT Id, Stock__c 
            FROM Vehicle__c 
            WHERE Id = :order.Vehicle__c 
            LIMIT 1
        ];

        if (vehicle.Stock__c <= 0) {
            order.addError('Vehicle is out of stock. Cannot place order.');
        }

        // 🔹 Assign Nearest Dealer (simple logic)
        Dealer__c dealer = [
            SELECT Id 
            FROM Dealer__c 
            WHERE City__c = :order.Customer_City__c 
            LIMIT 1
        ];

        if (dealer != null) {
            order.Dealer__c = dealer.Id;
        }
    }
}
