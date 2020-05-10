# Scenarios

> Please note that there is two clients to run. Client office (will be refered as CO) and Client Warehouse (refered as CW).

## Client warehouse
### Add a new drone
`adddrone 001`
### Fetch new parcels from carrier API
`checkfornewparcels`

## Client office
### Schedule deliveries
`scheduledelivery 8:00 123456789A`

`scheduledelivery 8:00 123456789B` (should display an error message)

`scheduledelivery 8:15 123456789B`

`scheduledelivery 8:30 123456789C`

`scheduledelivery 9:45 123456789D`

### See planning for drone 001
`getplanning 001`

## Client warehouse
### Add a new drone
`adddrone 002`

## Client office
### Schedule new delivery at 8:15am
`scheduledelivery 9:45 123456789E` 

### See planning for drone 002
`getplanning 002`

## Client warehouse
### Get the next delivery to load
`getnextdelivery 7:50` (should display delivery 123456789A with drone 001)
### Initialize the delivery
`startdelivery 123456789A` (wait a couple of seconds for the drone to come back before next step)
### Initialize two more deliveries
`getnextdelivery 8:05`

`startdelivery 123456789B`

`getnextdelivery 8:25`

`startdelivery 123456789C`

### Put the drone in charge

`getdrones`

`setincharge 001`

`setavailable 001`

`setincharge 001` (should display an error)

`setinreview 001` (should display an error)

### Put the drone available
`setAvailable 001`

### Put the drone in review after 20 hours of flight
`setinreview 001`

`setincharge 001` (should display an error)

`setinreview 001` (should display an error)

## Client office
### Get occupancy rate of the drones for the day (number of hours of flight + number of hours in review + number of hours in charge) / number of hours in the day
`occupancy 001`

`occupancy 002`

### Get invoices
`getinvoices`

### Confirm invoice payment
`confirminvoicepayment` (add the id displayed by the above command )

### Check payment
`getinvoices`