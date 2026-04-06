public class TestDriveReminder {

    public static void sendReminder() {

        List<Vehicle_Order__c> orders = [
            SELECT Id, Customer_Email__c, Test_Drive_Date__c
            FROM Vehicle_Order__c
            WHERE Test_Drive_Date__c = :Date.today().addDays(1)
        ];

        for (Vehicle_Order__c order : orders) {

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            mail.setToAddresses(new String[] { order.Customer_Email__c });
            mail.setSubject('Test Drive Reminder');
            mail.setPlainTextBody('Reminder: Your test drive is scheduled for tomorrow.');

            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}
