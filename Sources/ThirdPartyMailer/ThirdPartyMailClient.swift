//
// ThirdPartyMailClient.swift
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

import Foundation

/// A third-party mail client, offering a custom URL scheme.
public struct ThirdPartyMailClient {

    /// The name of the mail client.
    public let name: String

    /// The custom URL scheme of the mail client.
    public let URLScheme: String

    /// The URL “root” slashes (after the URL scheme and the colon).
    let URLRoot: String?
    
    /// The URL compose keyword (after the URL scheme, colon and slashes).
    let URLCompose: String?

    /// The URL query items key for the recipient.
    let URLRecipientKey: String?

    /**
     The URL query items key for the subject, or `nil` if this client doesn’t
     support setting the subject.
     */
    let URLSubjectKey: String?

    /**
     The URL query items key for the message body, or `nil` if this client
     doesn’t support setting the message body.
     */
    let URLBodyKey: String?

    /**
     Returns an array of predefined mail clients.

     - Returns: An array of `ThirdPartyMailClient`.
     */
    public static func clients() -> [ThirdPartyMailClient] {
        return [
            // sparrow:[to]?subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Sparrow", URLScheme: "sparrow",
                URLRoot: nil, URLCompose: nil, URLRecipientKey: nil, URLSubjectKey: "subject", URLBodyKey: "body"),

            // googlegmail:///co?to=[to]&subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Gmail", URLScheme: "googlegmail",
                URLRoot: "///", URLCompose: "co", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body"),

            // x-dispatch:///compose?to=[to]&subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Dispatch", URLScheme: "x-dispatch",
                URLRoot: "///", URLCompose: "compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body"),

            // readdle-spark://compose?subject=[subject]&body=[body]&recipient=[recipient]
            ThirdPartyMailClient(name: "Spark", URLScheme: "readdle-spark",
                URLRoot: "//", URLCompose: "compose", URLRecipientKey: "recipient", URLSubjectKey: "subject", URLBodyKey: "body"),

            // airmail://compose?subject=[subject]&from=[from]&to=[to]&cc=[cc]&bcc=[bcc]&plainBody=[plainBody]&htmlBody=[htmlBody]
            ThirdPartyMailClient(name: "Airmail", URLScheme: "airmail",
                URLRoot: "//", URLCompose: "compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "plainBody"),

            // ms-outlook://compose?subject=[subject]&body=[body]&to=[to]
            ThirdPartyMailClient(name: "Microsoft Outlook", URLScheme: "ms-outlook",
                 URLRoot: "//", URLCompose: "compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body"),

            // ymail://mail/compose?subject=[subject]&body=[body]&to=[to]
            ThirdPartyMailClient(name: "Yahoo Mail", URLScheme: "ymail",
                 URLRoot: "//", URLCompose: "mail/compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body")]
    }

    /**
     Returns the compose URL for the mail client, based on its custom URL scheme.

     - Parameters recipient: The recipient for the email message (optional).
     - Parameters subject: The subject for the email message (optional).
     - Parameters body: The body for the email message (optional).

     - Returns: A `NSURL` opening the mail client for the given parameters.
     */
    public func composeURL(_ recipient: String?, subject: String?, body: String?) -> URL {
        var components = URLComponents(string: "\(URLScheme):\(URLRoot ?? "")\(URLCompose ?? "")")
        components?.scheme = self.URLScheme

        if URLRecipientKey == nil {
            if let recipient = recipient {
                components = URLComponents(string: "\(URLScheme):\(URLRoot ?? "")\(URLCompose ?? "")\(recipient)")
            }
        }

        var queryItems: [URLQueryItem] = []

        if let recipient = recipient, let URLRecipientKey = URLRecipientKey {
            queryItems.append(URLQueryItem(name: URLRecipientKey, value:recipient))
        }

        if let subject = subject, let URLSubjectKey = URLSubjectKey {
            queryItems.append(URLQueryItem(name: URLSubjectKey, value:subject))
        }

        if let body = body, let URLBodyKey = URLBodyKey {
            queryItems.append(URLQueryItem(name: URLBodyKey, value:body))
        }

        if queryItems.isEmpty == false {
            components?.queryItems = queryItems
        }

        if let URL = components?.url {
            return URL
        }
        else {
            return URLComponents().url!
        }
    }
    
    /**
     Returns the open URL for the mail client, based on its custom URL scheme.

     - Returns: A `NSURL` opening the mail client.
     */
    public func openURL() -> URL {
        if let openURL = URL(string: "\(URLScheme):\(URLRoot ?? "")") {
            return openURL
        } else {
            return URLComponents().url!
        }
    }
}

