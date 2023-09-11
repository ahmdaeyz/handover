# handover

An App for Delivery services for individuals to deliver packages from one place to another.

#### Note that the app supports both Arabic and English Language, It reads the device's current language and uses it if it is supported. 
##### Check out some of the Arabic version's screenshots from [here](https://github.com/ahmdaeyz/handover/tree/master/screenshots).

## Demo

https://github.com/ahmdaeyz/handover/assets/36048466/31124ea3-aa0a-4fb9-a28a-1815101c33cc


## App Logic/Business
![Flow Chart](https://github.com/ahmdaeyz/handover/blob/master/docs/flow_chart.png) ![Notification sequence diagram](https://github.com/ahmdaeyz/handover/blob/master/docs/notification_sequence.png) 

## Simulation
The app simulates the delivery process offline based on the logic flow chart attached above, Check out the `ShipmentsService` class and its documentation in the source code.

## Background Tracking
Due to platform and vendor limitations and non-reliability, the idea was discarded. A possible and recommended solution is relying on Remote Push notifications to update the app data and maybe refresh/update a LiveActivity on iOS 16+.
Checkout the following links:
  - [https://developer.apple.com/forums/thread/685525](https://developer.apple.com/forums/thread/685525)
  - [https://developer.apple.com/forums/thread/85066](https://developer.apple.com/forums/thread/85066)

## Next Steps
- Add tests for the simulation class.
- Create a backend service and integrate with it swapping `ShipmentsService`.
- Add integration tests to validate the whole flow (maybe use patrol).

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
