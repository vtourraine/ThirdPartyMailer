//
// ThirdPartyMailer.swift
//
// Copyright (c) 2016-2025 Vincent Tourraine (https://www.vtourraine.net)
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
    /// - Returns: `true` if the application can open the client; otherwise, `false`.
    open class func isMailClientAvailable(_ client: ThirdPartyMailClient) -> Bool {
        var components = URLComponents()
        components.scheme = client.URLScheme

        guard let URL = components.url
            else { return false }

        let application = UIApplication.shared
        return application.canOpenURL(URL)
    }

    /// Opens a third-party mail client.
    /// - Parameters:
    ///   - client: The third-party client to open.
    ///   - completion: The block to execute with the results (optional, default value is `nil`).
    open class func open(_ client: ThirdPartyMailClient = .systemDefault, completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = client.openURL()
        let application = UIApplication.shared
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
    ///   - completion: The block to execute with the results (optional, default value is `nil`).
    open class func openCompose(_ client: ThirdPartyMailClient = .systemDefault, recipient: String? = nil, subject: String? = nil, body: String? = nil, cc: String? = nil, bcc: String? = nil, with application: UIApplication = .shared, completionHandler completion: ((Bool) -> Void)? = nil) {
        let url = client.composeURL(to: recipient, subject: subject, body: body, cc: cc, bcc: bcc)
        let application = UIApplication.shared
        application.open(url, options: [:], completionHandler: completion)
    }
}

#if swift(>=5.5.2)
    @available(iOS 13, *)
    @MainActor
    extension ThirdPartyMailer {
        open class func openCompose(_ client: ThirdPartyMailClient = .systemDefault, recipient: String? = nil, subject: String? = nil, body: String? = nil, cc: String? = nil, bcc: String? = nil, with application: UIApplication) async -> Bool {
            return await withCheckedContinuation { continuation in
                openCompose(client, recipient: recipient, subject: subject, body: body, cc: cc, bcc: bcc, with: application) { result in
                    continuation.resume(returning: result)
                }
            }
        }

        open class func openCompose(_ client: ThirdPartyMailClient = .systemDefault, recipient: String? = nil, subject: String? = nil, body: String? = nil, cc: String? = nil, bcc: String? = nil) async -> Bool {
            return await openCompose(client, recipient: recipient, subject: subject, body: body, cc: cc, bcc: bcc, with: .shared)
        }
    }
#endif
