//
// ThirdPartyMailer.swift
//
// Copyright (c) 2016-2019 Vincent Tourraine (http://www.vtourraine.net)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

/// Tests third party mail clients availability, and opens third party mail clients in compose mode.
open class ThirdPartyMailer {

    /**
     Tests the availability of a third-party mail client.

     - Parameters application: The main application (usually `UIApplication.sharedApplication()`).
     - Parameters client: The third-party client to test.

     - Returns: `true` if the application can open the client; otherwise, `false`.
     */
    open class func application(_ application: UIApplicationOpenURLProtocol, isMailClientAvailable client: ThirdPartyMailClient) -> Bool {
        var components = URLComponents()
        components.scheme = client.URLScheme

        guard let URL = components.url
            else { return false }

        return application.canOpenURL(URL)
    }

    
    /**
     Opens a third-party mail client.

     - Parameters application: The main application (usually `UIApplication.sharedApplication()`).
     - Parameters client: The third-party client to test.

     - Returns: `true` if the application opens the client; otherwise, `false`.
     */
    open class func application(_ application: UIApplicationOpenURLProtocol, openMailClient client: ThirdPartyMailClient) -> Bool {
        return application.openURL(client.openURL())
    }
    
    /**
     Opens a third-party mail client in compose mode.

     - Parameters application: The main application (usually `UIApplication.sharedApplication()`).
     - Parameters client: The third-party client to test.
     - Parameters recipient: The email address of the recipient (optional).
     - Parameters subject: The email subject (optional).
     - Parameters body: The email body (optional).

     - Returns: `true` if the application opens the client; otherwise, `false`.
     */
    open class func application(_ application: UIApplicationOpenURLProtocol, openMailClient client: ThirdPartyMailClient, recipient: String?, subject: String?, body: String?) -> Bool {
        return application.openURL(client.composeURL(recipient, subject: subject, body: body))
    }
    
}

/**
 Extension with URL-specific methods for `UIApplication`, or any other object responsible for handling URLs.
 */
public protocol UIApplicationOpenURLProtocol {
    /**
     Returns a Boolean value indicating whether or not the URL’s scheme can be handled by some app installed on the device.

     - Parameters url: A URL (Universal Resource Locator). At runtime, the system tests the URL’s scheme to determine if there is an installed app that is registered to handle the scheme. More than one app can be registered to handle a scheme.

     - Returns: `NO` if there is no app installed on the device that is registered to handle the URL’s scheme, or if you have not declared the URL’s scheme in your `Info.plist` file; otherwise, `YES`.
     */
    func canOpenURL(_ url: URL) -> Bool

    /**
     Attempts to open the resource at the specified URL.

     - Parameters url: The URL to open.

     - Returns: `YES` if the resource located by the URL was successfully opened; otherwise `NO`.
     */
    func openURL(_ url: URL) -> Bool
}

/// Extend `UIApplication` to conform to the `UIApplicationOpenURLProtocol`.
extension UIApplication: UIApplicationOpenURLProtocol {}
