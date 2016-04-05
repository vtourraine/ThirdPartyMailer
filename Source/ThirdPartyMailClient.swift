//
// ThirdPartyMailClient.swift
//
// Copyright (c) 2016 Vincent Tourraine (http://www.vtourraine.net)
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

/**
 
*/
public struct ThirdPartyMailClient {
    public let name: String
    public let URLScheme: String

    let URLRoot: String?
    let URLRecipientKey: String?
    let URLSubjectKey: String?
    let URLBodyKey: String?

    public static func clients() -> [ThirdPartyMailClient] {
        return [
            // sparrow:[to]?subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Sparrow", URLScheme: "sparrow",
                URLRoot: nil, URLRecipientKey: nil, URLSubjectKey: "subject", URLBodyKey: "body"),

            // googlegmail:///co?to=[to]&subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Gmail", URLScheme: "googlegmail",
                URLRoot: "///co", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body"),

            // x-dispatch:///compose?to=[to]&subject=[subject]&body=[body]
            ThirdPartyMailClient(name: "Dispatch", URLScheme: "x-dispatch",
                URLRoot: "///compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "body"),

            // readdle-spark://compose?subject=[subject]&body=[body]&recipient=[recipient]
            ThirdPartyMailClient(name: "Spark", URLScheme: "readdle-spark",
                URLRoot: "//compose", URLRecipientKey: "recipient", URLSubjectKey: "subject", URLBodyKey: "body"),

            // airmail://compose?subject=[subject]&from=[from]&to=[to]&cc=[cc]&bcc=[bcc]&plainBody=[plainBody]&htmlBody=[htmlBody]
            ThirdPartyMailClient(name: "Airmail", URLScheme: "airmail",
                URLRoot: "//compose", URLRecipientKey: "to", URLSubjectKey: "subject", URLBodyKey: "plainBody")]
    }

    public func composeURL(recipient: String?, subject: String?, body: String?) -> NSURL {
        var components = NSURLComponents(string: "\(URLScheme):\(URLRoot ?? "")")
        components?.scheme = self.URLScheme

        if URLRecipientKey == nil {
            if let recipient = recipient {
                components = NSURLComponents(string: "\(URLScheme):\(URLRoot ?? "")\(recipient)")
            }
        }

        var queryItems: [NSURLQueryItem] = []

        if let recipient = recipient, let URLRecipientKey = URLRecipientKey {
            queryItems.append(NSURLQueryItem(name: URLRecipientKey, value:recipient))
        }

        if let subject = subject, let URLSubjectKey = URLSubjectKey {
            queryItems.append(NSURLQueryItem(name: URLSubjectKey, value:subject))
        }

        if let body = body, let URLBodyKey = URLBodyKey {
            queryItems.append(NSURLQueryItem(name: URLBodyKey, value:body))
        }

        if queryItems.isEmpty == false {
            components?.queryItems = queryItems
        }

        if let URL = components?.URL {
            return URL
        }
        else {
            return NSURL()
        }
    }
}

