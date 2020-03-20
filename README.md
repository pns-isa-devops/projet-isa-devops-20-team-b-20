<p align="center"><img src="https://user-images.githubusercontent.com/43060105/75693679-9823d380-5ca7-11ea-8540-31c01c647cba.png" width="400"></p>

## Components assembly

<p align="center"><img src="https://user-images.githubusercontent.com/43060105/75693712-a7a31c80-5ca7-11ea-8d66-bfb3befdea9e.png" width="400"></p>

## Functional interfaces

- StatisticsCollector 
```
void addCustomerFeedback(CustomerFeedback feedbacks); 
CustomerFeedback[] getCustomerFeedback(); 
double getOccupancyRate(Drone drone); 
```
- InvoiceManager 
```
Invoice createInvoice(Delivery delivery); 
Invoice[] getInvoices(); 
bool updateInvoice(Invoice invoice); 
bool deleteInvoice(Invoice invoice); 
void generateInvoiceDocument(Invoice invoice); 
```
- DroneAvailabilityGetter 
```
Drone[] getAvailableDrones(Date date); 
```
- DroneReviewer 
```
Date getFlightTimeSinceLastRevision(Drone drone); 
Date getRemainingBatteryFlightTime(Drone drone); 
Date computeRemainingTimeBeforeBatteryIsFull(Drone drone); 
void setDroneInCharge(Drone drone); 
void putDroneInRevision(Drone drone); 
bool setDroneAvailable(Drone drone); 
```
- DroneMonitor 
```
bool waitForDroneToComeBackWithoutParcel(Drone drone); 
Date getFlightTimeSinceLastRevision(Drone drone); 
Date getRemainingBatteryFlightTime(Drone drone); 
Date getRemainingBattery(Drone drone); 
void launchDrone(Drone drone); 
```
- DroneLauncher 
```
bool initializeDroneLaunching(Drone drone, double arrivalHour); 
```
- DeliveryFinalizer 
```
void setDeliveryToDone(Delivery delivery); 
void setDeliveryToFailed (Delivery delivery); 
```
- DeliveryScheduler 
```
TimeSlot[] getPlanning(); 
bool scheduleDelivery(Date date, Delivery delivery); 
```
- DeliveryOrganizer 
```
Delivery[] getNextDeliveries(); 
```
- fr.polytech.components.DeliveryInitializer 
```
Parcel scanParcel(String parcelId); 
Delivery createDelivery(Parcel parcel); 
bool initializeDelivery(Deliever delivery); 
```

## Business Objects 

<p align="center"><img src="https://user-images.githubusercontent.com/43060105/75693708-a5d95900-5ca7-11ea-9708-443498efae9e.png" width="400"></p>
