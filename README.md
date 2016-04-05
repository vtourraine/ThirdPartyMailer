# ThirdPartyMailer

_Interact with third-party iOS mail clients, using custom URL schemes._

Tested on Travis CI: [![Build Status](https://travis-ci.org/vtourraine/ThirdPartyMailer.svg?branch=master)](https://travis-ci.org/vtourraine/ThirdPartyMailer)


## Supported mail clients

Client   | URL Scheme      | App Store
-------- | --------------- | ---------
Sparrow  | `sparrow`       | _discontinued_
Gmail    | `googlegmail`   | [link](https://itunes.apple.com/app/id422689480?mt=8)
Dispatch | `x-dispatch`    | [link](https://itunes.apple.com/app/id642022747?mt=8)
Spark    | `readdle-spark` | [link](https://itunes.apple.com/app/id997102246?mt=8)
Airmail  | `airmail`       | [link](https://itunes.apple.com/app/id993160329?mt=8)

Unfortunately, not all mail clients offer URL schemes to be supported by `ThirdPartyMailer`. If you’re aware of another candidate, please [let us know](https://github.com/vtourraine/ThirdPartyMailer/issues).


## How to use

Getting the list of available clients:

``` swift
let clients = ThirdPartyMailClient.clients()
```

Testing the client availability (i.e. is the app installed):

``` swift
let application = UIApplication.sharedApplication()

if ThirdPartyMailer.application(application, isMailClientAvailable: client) {
    // ...
}
```

Opening the client (with optional message recipient, subject, and body):

``` swift
let application = UIApplication.sharedApplication()

ThirdPartyMailer.application(application, openMailClient: client, recipient: nil, subject: nil, body: nil)
```


## Requirements

ThirdPartyMailer is written in Swift 2.2, requires iOS 8.0 and above, Xcode 7.3 and above.


## Credits

ThirdPartyMailer was created by [Vincent Tourraine](http://www.vtourraine.net).


## License

ThirdPartyMailer is available under the MIT license. See the LICENSE file for more info.
