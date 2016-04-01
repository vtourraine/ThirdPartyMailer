//
//  ThirdPartyMailClientsTests.swift
//  ThirdPartyMailerExampleTests
//
//  Created by Vincent Tourraine on 28/03/16.
//  Copyright © 2016 Vincent Tourraine. All rights reserved.
//

import XCTest

@testable import ThirdPartyMailer

class ThirdPartyMailClientsTests: XCTestCase {

    let clients = ThirdPartyMailClient.clients()
    let application = ApplicationMock()

    func clientWithURLScheme(URLScheme: String) -> ThirdPartyMailClient? {
        return clients.filter { return $0.URLScheme == URLScheme }.first
    }

    func testClientAvailability() {
        let client = ThirdPartyMailClient(name: "", URLScheme: "qwerty", URLRoot: nil, URLRecipientKey: nil, URLSubjectKey: nil, URLBodyKey: nil)

        application.canOpenNextURL = true

        let isAvailablePositive = ThirdPartyMailer.application(application, isMailClientAvailable: client)
        XCTAssertTrue(isAvailablePositive)

        application.canOpenNextURL = false

        let isAvailableNegative = ThirdPartyMailer.application(application, isMailClientAvailable: client)
        XCTAssertFalse(isAvailableNegative)
    }

    func testSparrow() {
        let sparrow = clientWithURLScheme("sparrow")
        XCTAssertNotNil(sparrow)

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:")

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com?subject=Sub&body=ABC%20def")
    }
}

class ApplicationMock: UIApplicationOpenURLProtocol {
    var canOpenNextURL = false
    var lastOpenedURL: NSURL?

    func canOpenURL(url: NSURL) -> Bool {
        return canOpenNextURL
    }

    func openURL(url: NSURL) -> Bool {
        lastOpenedURL = url
        return true
    }
}
