//
// ThirdPartyMailClientsTests.swift
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

        let isAvailablePositive = ThirdPartyMailer.isMailClientAvailable(client, with: application)
        XCTAssertTrue(isAvailablePositive)

        application.canOpenNextURL = false

        let isAvailableNegative = ThirdPartyMailer.isMailClientAvailable(client, with: application)
        XCTAssertFalse(isAvailableNegative)
    }

    func testSparrow() throws {
        let sparrow = try XCTUnwrap(clientWithURLScheme("sparrow"))

        ThirdPartyMailer.open(sparrow, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:")

        ThirdPartyMailer.openCompose(sparrow, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:")

        ThirdPartyMailer.openCompose(sparrow, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com")

        ThirdPartyMailer.openCompose(sparrow, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "sparrow:test@mail.com?subject=Sub&body=ABC%20def")
    }

    func testGmail() throws {
        let gmail = try XCTUnwrap(clientWithURLScheme("googlegmail"))

        ThirdPartyMailer.open(gmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:")

        ThirdPartyMailer.openCompose(gmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co")

        ThirdPartyMailer.openCompose(gmail, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co?to=test@mail.com")

        ThirdPartyMailer.openCompose(gmail, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co?to=test@mail.com&subject=Sub&body=ABC%20def")

        ThirdPartyMailer.openCompose(gmail, recipient: "test@mail.com", cc: "testcopy@mail.com", bcc: "blindtestcopy@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "googlegmail:///co?to=test@mail.com&cc=testcopy@mail.com&bcc=blindtestcopy@mail.com")
    }

    func testDispatch() throws {
        let dispatch = try XCTUnwrap(clientWithURLScheme("x-dispatch"))

        ThirdPartyMailer.open(dispatch, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:")

        ThirdPartyMailer.openCompose(dispatch, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose")

        ThirdPartyMailer.openCompose(dispatch, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose?to=test@mail.com")

        ThirdPartyMailer.openCompose(dispatch, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "x-dispatch:///compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testSpark() throws {
        let spark = try XCTUnwrap(clientWithURLScheme("readdle-spark"))

        ThirdPartyMailer.open(spark, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark:")

        ThirdPartyMailer.openCompose(spark, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose")

        ThirdPartyMailer.openCompose(spark, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose?recipient=test@mail.com")

        ThirdPartyMailer.openCompose(spark, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "readdle-spark://compose?recipient=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testAirmail() throws {
        let airmail = try XCTUnwrap(clientWithURLScheme("airmail"))

        ThirdPartyMailer.open(airmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail:")

        ThirdPartyMailer.openCompose(airmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose")

        ThirdPartyMailer.openCompose(airmail, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose?to=test@mail.com")

        ThirdPartyMailer.openCompose(airmail, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "airmail://compose?to=test@mail.com&subject=Sub&plainBody=ABC%20def")
    }

    func testOutlook() throws {
        let outlook = try XCTUnwrap(clientWithURLScheme("ms-outlook"))

        ThirdPartyMailer.open(outlook, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook:")

        ThirdPartyMailer.openCompose(outlook, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose")

        ThirdPartyMailer.openCompose(outlook, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose?to=test@mail.com")

        ThirdPartyMailer.openCompose(outlook, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ms-outlook://compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testYahooMail() throws {
        let yahoo = try XCTUnwrap(clientWithURLScheme("ymail"))

        ThirdPartyMailer.open(yahoo, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail:")

        ThirdPartyMailer.openCompose(yahoo, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose")

        ThirdPartyMailer.openCompose(yahoo, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose?to=test@mail.com")

        ThirdPartyMailer.openCompose(yahoo, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "ymail://mail/compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testFastmail() throws {
        let fastmail = try XCTUnwrap(clientWithURLScheme("fastmail"))

        ThirdPartyMailer.open(fastmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail:")

        ThirdPartyMailer.openCompose(fastmail, with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail://mail/compose")

        ThirdPartyMailer.openCompose(fastmail, recipient: "test@mail.com", with: application)
        XCTAssertEqual(application.lastOpenedURL?.absoluteString, "fastmail://mail/compose?to=test@mail.com")

        ThirdPartyMailer.openCompose(fastmail, recipient: "test@mail.com", subject: "Sub", body: "ABC def", with: application)
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
