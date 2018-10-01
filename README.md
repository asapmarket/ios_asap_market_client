## intro
ios delivery app for client  

## guide
### Prerequisites

xcode、iOS 8.0 or higher

### Installation    
##### Installation xcode   
1、macBook download xcode at appstore 
### how to run
##### Import project root file
Click the suffix .xcworkspace file to run the project.
The device is configured with udid in the developer account, select the real machine to run directly (comand+R), or run with various iPhone device simulators.
## Code introduction 
Use object c encoding to support iOS8.0 and above

##### Network request 
This software uses the AHNetwork open source library to process network requests.
WHttpTool-engineering network request base class class, data processing for each tab page server class, all network requests of the software are implemented in this class  
success:(void (^)(id json))success 
failure:(void (^)(NSError *error))failure   


