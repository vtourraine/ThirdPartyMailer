# ThirdPartyMailer

_Interact with third-party iOS mail clients, using custom URL schemes._

![Platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift 5](https://img.shields.io/badge/Swift-5-blue.svg)
[![Build Status](https://travis-ci.org/vtourraine/ThirdPartyMailer.svg?branch=master)](https://travis-ci.org/vtourraine/ThirdPartyMailer)
![Swift Package Manager](https://img.shields.io/badge/support-Swift_Package_Manager-orange.svg)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/ThirdPartyMailer.svg)](https://cocoapods.org/pods/ThirdPartyMailer)
[![MIT license](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/vtourraine/ThirdPartyMailer/raw/master/LICENSE.md)


## Supported mail clients

Client             | URL Scheme      | App Store
------------------ | --------------- | ---------
Sparrow            | `sparrow`       | _discontinued_
Gmail              | `googlegmail`   | [link](https://apps.apple.com/app/id422689480?mt=8)
Dispatch           | `x-dispatch`    | [link](https://apps.apple.com/app/id642022747?mt=8)
Spark              | `readdle-spark` | [link](https://apps.apple.com/app/id997102246?mt=8)
Airmail            | `airmail`       | [link](https://apps.apple.com/app/id993160329?mt=8)
Microsoft Outlook  | `ms-outlook`    | [link](https://apps.apple.com/app/id951937596?mt=8)
Yahoo Mail         | `ymail`         | [link](https://apps.apple.com/app/id577586159?mt=8)
Fastmail           | `Fastmail`      | [link](https://apps.apple.com/app/id931370077?mt=8)

Unfortunately, not all mail clients offer URL schemes to be supported by `ThirdPartyMailer`. If you’re aware of another candidate, please [let us know](https://github.com/vtourraine/ThirdPartyMailer/issues).


## How to install

### Swift Package Manager

In Xcode, click on the “File” menu, “Swift Packages”, “Add Package Dependency…”, then enter the URL for this repo: `https://github.com/vtourraine/ThirdPartyMailer.git`.


### CocoaPods

With [CocoaPods](https://cocoapods.org), simply add ThirdPartyMailer to your Podfile:

```
pod 'ThirdPartyMailer'
```

Or, you can manually import the files from the Sources folder.


## How to use

### Getting the list of supported clients

``` swift
let clients = ThirdPartyMailClient.clients()
```

### Testing the client availability (i.e. if the app is installed)

⚠️ In order to test the client availability, your app needs to declare the relevant URL scheme in its `Info.plist` file, by adding a `LSApplicationQueriesSchemes` array. You can find [an example here](https://github.com/vtourraine/ThirdPartyMailer/blob/69ef4095336ccebc76ac528234c1739f66d258d1/Tests/ThirdPartyMailerExample/Info.plist#L23), or check out the [documentation](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/LaunchServicesKeys.html#//apple_ref/doc/uid/TP40009250-SW14).

``` swift
let application = UIApplication.shared

if ThirdPartyMailer.application(application, isMailClientAvailable: client) {
    // ...
}
```

### Opening the client (with optional message recipient, subject, and body)

``` swift
let application = UIApplication.shared

ThirdPartyMailer.application(application, openMailClient: client, recipient: nil, subject: nil, body: nil)
```


## Requirements

ThirdPartyMailer is written in Swift 5.0, requires iOS 8.0 and above, Xcode 10.2 and above.


## Credits

ThirdPartyMailer was created by [Vincent Tourraine](https://www.vtourraine.net).


## License

ThirdPartyMailer is available under the MIT license. See the LICENSE file for more info.
