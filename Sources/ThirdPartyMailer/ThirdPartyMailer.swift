//
// ThirdPartyMailer.swift
//
// Copyright (c) 2016-2021 Vincent Tourraine (http://www.vtourraine.net)
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
@available(iOSApplicationExtension, unavailable)
open class ThirdPartyMailer {

    /// Tests the availability of a third-party mail client.
    /// - Parameters:
    ///   - client: The third-party client to test.
    ///   - application: The main application (optional, default value is `UIApplication.shared`).
    /// - Returns: `true` if the application can open the client; otherwise, `false`.
    open class func isMailClientAvailable(_ client: ThirdPartyMailClient, with application: UIApplicationOpenURLProtocol = UIApplication.shared) -> Bool {
        var components = URLComponents()
        components.scheme = client.URLScheme

        guard let URL = components.url
            else { return false }

        return application.canOpenURL(URL)
    }

    /// Opens a third-party mail client.
    /// - Parameters:
    ///   - client: The third-party client to open.
    ///   - application: The main application (optional, default value is `UIApplication.shared`).
    ///   - completion: The block to execute with the results (optional, default value is `nil`).
    open class func open(_ client: ThirdPartyMailClient, with application: UIApplicationOpenURLProtocol = UIApplication.shared, completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = client.openURL()
        application.open(url, options: [:], completionHandler: completion)
    }

    /// Opens a third-party mail client in compose mode.
    /// - Parameters:
    ///   - client: The third-party client to open.
    ///   - recipient: The email address of the recipient (optional, default value is `nil`).
    ///   - subject: The email subject (optional, default value is `nil`).
    ///   - body: The email body (optional, default value is `nil`).
    ///   - cc: The email address of the recipient carbon copy (optional, default value is `nil`).
    ///   - bcc: The email address of the recipient blind carbon copy (optional, default value is `nil`).
    ///   - application: The main application (optional, default value is `UIApplication.shared`).
    ///   - completion: The block to execute with the results (optional, default value is `nil`).
    open class func openCompose(_ client: ThirdPartyMailClient, recipient: String? = nil, subject: String? = nil, body: String? = nil, cc: String? = nil, bcc: String? = nil, with application: UIApplicationOpenURLProtocol = UIApplication.shared, completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = client.composeURL(to: recipient, subject: subject, body: body, cc: cc, bcc: bcc)
        application.open(url, options: [:], completionHandler: completion)
    }
}

/// Extension with URL-specific methods for `UIApplication`, or any other object responsible for handling URLs.
public protocol UIApplicationOpenURLProtocol {

    /// Returns a Boolean value indicating whether or not the URL’s scheme can be handled by some app installed on the device.
    /// - Parameter url: A URL (Universal Resource Locator). At runtime, the system tests the URL’s scheme to determine if there is an installed app that is registered to handle the scheme. More than one app can be registered to handle a scheme.
    /// - Returns: `NO` if there is no app installed on the device that is registered to handle the URL’s scheme, or if you have not declared the URL’s scheme in your `Info.plist` file; otherwise, `YES`.
    func canOpenURL(_ url: URL) -> Bool

    /// Attempts to open the resource at the specified URL.
    /// - Parameters:
    ///   - url: The URL to open.
    ///   - options: A dictionary of options to use when opening the URL
    ///   - completion: The block to execute with the results.
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

/// Extend `UIApplication` to conform to the `UIApplicationOpenURLProtocol`.
extension UIApplication: UIApplicationOpenURLProtocol {}
