# ThirdPartyMailer changelog


## 2.0 (work in progress)

- Support system default client (`mailto:`)
- Support `cc` and `bcc` parameters
- Replace deprecated `openURL(_)` with `open(_, options: , completionHandler:)`
- Update `ThirdPartyMailClient.composeURL(...)` with default parameters values
- Rename `ThirdPartyMailClient` `clients()` to `clients`
- Update `ThirdPartyMailer` functions with completion handler instead of boolean return value
- Rename `ThirdPartyMailer` `application(_, isMailClientAvailable:)` to `isMailClientAvailable(_)`, with default parameters values
- Rename `ThirdPartyMailer` `application(_, openMailClient:, completionHandler:)` to `open(_, completionHandler:)`, with default parameters values
- Rename `ThirdPartyMailer` `application(_, openMailClient:, recipient:, subject:, body:, completionHandler:)` to `openCompose(_, recipient:, subject:, body:, cc:, bcc:, completionHandler:)`, with default parameters values
- Require iOS 10


## 1.8

- Carthage support


## 1.7.1

- Update deployment target to iOS 9


## 1.7

- Add Fastmail support


## 1.6

- Add open client method


## 1.5

- Add Swift Package Manager support


## 1.4

- Update to Swift 5.0


## 1.3

- Update to Swift 4.2


## 1.2

- Add Microsoft Outlook support
- Add Yahoo Mail support


## 1.1

- Update to Swift 3.2


## 1.0

- Update to Swift 3


## 0.1.1

- Add documentation


## 0.1

Initial release
