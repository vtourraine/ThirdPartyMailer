//
//  ThirdPartyMailClientsTests.swift
//  ThirdPartyMailerExampleTests
//
//  Created by Vincent Tourraine on 28/03/16.
//  Copyright © 2016-2020 Vincent Tourraine. All rights reserved.
//

import XCTest

@testable import ThirdPartyMailer

class ThirdPartyMailClientsTests: XCTestCase {

    let clients = ThirdPartyMailClient.clients()
    let application = ApplicationMock()

    func clientWithURLScheme(_ URLScheme: String) -> ThirdPartyMailClient? {
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

        ThirdPartyMailer.application(application, openMailClient: sparrow!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:")

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:")

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: sparrow!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com?subject=Sub&body=ABC%20def")
    }

    func testGmail() {
        let gmail = clientWithURLScheme("googlegmail")
        XCTAssertNotNil(gmail)

        ThirdPartyMailer.application(application, openMailClient: gmail!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:")

        ThirdPartyMailer.application(application, openMailClient: gmail!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co")

        ThirdPartyMailer.application(application, openMailClient: gmail!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: gmail!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testDispatch() {
        let dispatch = clientWithURLScheme("x-dispatch")
        XCTAssertNotNil(dispatch)

        ThirdPartyMailer.application(application, openMailClient: dispatch!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:")

        ThirdPartyMailer.application(application, openMailClient: dispatch!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose")

        ThirdPartyMailer.application(application, openMailClient: dispatch!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: dispatch!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testSpark() {
        let spark = clientWithURLScheme("readdle-spark")
        XCTAssertNotNil(spark)

        ThirdPartyMailer.application(application, openMailClient: spark!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark:")

        ThirdPartyMailer.application(application, openMailClient: spark!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose")

        ThirdPartyMailer.application(application, openMailClient: spark!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose?recipient=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: spark!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose?recipient=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testAirmail() {
        let airmail = clientWithURLScheme("airmail")
        XCTAssertNotNil(airmail)

        ThirdPartyMailer.application(application, openMailClient: airmail!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail:")

        ThirdPartyMailer.application(application, openMailClient: airmail!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose")

        ThirdPartyMailer.application(application, openMailClient: airmail!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: airmail!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose?to=test@mail.com&subject=Sub&plainBody=ABC%20def")
    }

    func testOutlook() {
        let outlook = clientWithURLScheme("ms-outlook")
        XCTAssertNotNil(outlook)

        ThirdPartyMailer.application(application, openMailClient: outlook!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook:")

        ThirdPartyMailer.application(application, openMailClient: outlook!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose")

        ThirdPartyMailer.application(application, openMailClient: outlook!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: outlook!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testYahooMail() {
        let yahoo = clientWithURLScheme("ymail")
        XCTAssertNotNil(yahoo)

        ThirdPartyMailer.application(application, openMailClient: yahoo!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail:")

        ThirdPartyMailer.application(application, openMailClient: yahoo!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose")

        ThirdPartyMailer.application(application, openMailClient: yahoo!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: yahoo!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testFastmail() {
        let fastmail = clientWithURLScheme("fastmail")
        XCTAssertNotNil(fastmail)

        ThirdPartyMailer.application(application, openMailClient: fastmail!)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail:")

        ThirdPartyMailer.application(application, openMailClient: fastmail!, recipient: nil, subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail://mail/compose")

        ThirdPartyMailer.application(application, openMailClient: fastmail!, recipient: "test@mail.com", subject: nil, body: nil)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail://mail/compose?to=test@mail.com")

        ThirdPartyMailer.application(application, openMailClient: fastmail!, recipient: "test@mail.com", subject: "Sub", body: "ABC def")
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail://mail/compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

}

class ApplicationMock: UIApplicationOpenURLProtocol {
    var canOpenNextURL = false
    var lastOpenedURL: URL?

    func canOpenURL(_ url: URL) -> Bool {
        return canOpenNextURL
    }

    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?) {
        lastOpenedURL = url
    }
}
