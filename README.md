# ThirdPartyMailer

_Interact with third-party iOS mail clients, using custom URL schemes._

![Platform iOS](https://img.shields.io/badge/platform-iOS-blue.svg)
![Swift 5](https://img.shields.io/badge/Swift-5-blue.svg)
[![Build](https://github.com/vtourraine/ThirdPartyMailer/actions/workflows/ios.yml/badge.svg)](https://github.com/vtourraine/ThirdPartyMailer/actions/workflows/ios.yml)
![Swift Package Manager](https://img.shields.io/badge/support-Swift_Package_Manager-orange.svg)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/ThirdPartyMailer.svg)](https://cocoapods.org/pods/ThirdPartyMailer)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)
[![MIT license](http://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/vtourraine/ThirdPartyMailer/raw/master/LICENSE.md)


## Supported mail clients

Client             | URL Scheme      | App Store
------------------ | --------------- | ---------
Gmail              | `googlegmail`   | [link](https://apps.apple.com/app/id422689480?mt=8)
Spark              | `readdle-spark` | [link](https://apps.apple.com/app/id997102246?mt=8)
Airmail            | `airmail`       | [link](https://apps.apple.com/app/id993160329?mt=8)
Microsoft Outlook  | `ms-outlook`    | [link](https://apps.apple.com/app/id951937596?mt=8)
Yahoo Mail         | `ymail`         | [link](https://apps.apple.com/app/id577586159?mt=8)
Fastmail           | `fastmail`      | [link](https://apps.apple.com/app/id931370077?mt=8)
ProtonMail         | `protonmail`    | [link](https://apps.apple.com/app/id979659905?mt=8)
Sparrow            | `sparrow`       | _discontinued_
Dispatch           | `x-dispatch`    | _discontinued_

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
let clients = ThirdPartyMailClient.clients
```

### Testing the client availability (i.e. if the app is installed)

⚠️ In order to test the client availability, your app needs to declare the relevant URL scheme in its `Info.plist` file, by adding a `LSApplicationQueriesSchemes` array. You can find [an example here](https://github.com/vtourraine/ThirdPartyMailer/blob/69ef4095336ccebc76ac528234c1739f66d258d1/Tests/ThirdPartyMailerExample/Info.plist#L23), or check out the [documentation](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/LaunchServicesKeys.html#//apple_ref/doc/uid/TP40009250-SW14).

``` swift
if ThirdPartyMailer.isMailClientAvailable(client) {
    // ...
}
```

### Opening the client (with optional message recipient, subject, body, cc, and bcc)

``` swift
ThirdPartyMailer.openCompose(client, recipient: "friend@mail.com")

ThirdPartyMailer.openCompose(client, recipient: "friend@mail.com", subject: "Hello", body: "Good morning…", cc: "cc@mail.com", bcc: "bcc@mail.com")
```

### :new: Using the system default mail client

If you don’t specify a client, the `openCompose(…)` function will use `.systemDefault`, a client defined for the [standard `mailto:` scheme](https://en.wikipedia.org/wiki/Mailto). By default, it will open Apple Mail, but if [the user has selected a custom mail client](https://support.apple.com/en-us/HT211336) (iOS 14), it will automatically open it instead.

``` swift
ThirdPartyMailer.openCompose(recipient: "friend@mail.com")
```


## Requirements

ThirdPartyMailer is written in Swift 5.0, requires iOS 10.0 and above, Xcode 10.2 and above.


## Credits

ThirdPartyMailer was created by [Vincent Tourraine](https://www.vtourraine.net).


## License

ThirdPartyMailer is available under the MIT license. See the [LICENSE.txt](./LICENSE.txt) file for more info.
