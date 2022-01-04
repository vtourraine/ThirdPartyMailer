//
// ThirdPartyMailClientsTests.swift
//
// Copyright (c) 2016-2022 Vincent Tourraine (https://www.vtourraine.net)
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

    let clients = ThirdPartyMailClient.clients

    func clientWithURLScheme(_ URLScheme: String) -> ThirdPartyMailClient? {
        return clients.filter { return $0.URLScheme == URLScheme }.first
    }

    func testSparrow() throws {
        let sparrow = try XCTUnwrap(clientWithURLScheme("sparrow"))

        XCTAssertEqual(sparrow.openURL().absoluteString, "sparrow:")
        XCTAssertEqual(sparrow.composeURL().absoluteString, "sparrow:")
        XCTAssertEqual(sparrow.composeURL(to: "test@mail.com").absoluteString, "sparrow:test@mail.com")
        XCTAssertEqual(sparrow.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "sparrow:test@mail.com?subject=Sub&body=ABC%20def")
    }

    func testGmail() throws {
        let gmail = try XCTUnwrap(clientWithURLScheme("googlegmail"))

        XCTAssertEqual(gmail.openURL().absoluteString, "googlegmail:")
        XCTAssertEqual(gmail.composeURL().absoluteString, "googlegmail:///co")
        XCTAssertEqual(gmail.composeURL(to: "test@mail.com").absoluteString, "googlegmail:///co?to=test@mail.com")
        XCTAssertEqual(gmail.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "googlegmail:///co?to=test@mail.com&subject=Sub&body=ABC%20def")
        XCTAssertEqual(gmail.composeURL(to: "test@mail.com", cc: "testcopy@mail.com", bcc: "blindtestcopy@mail.com").absoluteString, "googlegmail:///co?to=test@mail.com&cc=testcopy@mail.com&bcc=blindtestcopy@mail.com")
    }

    func testDispatch() throws {
        let dispatch = try XCTUnwrap(clientWithURLScheme("x-dispatch"))

        XCTAssertEqual(dispatch.openURL().absoluteString, "x-dispatch:")
        XCTAssertEqual(dispatch.composeURL().absoluteString, "x-dispatch:///compose")
        XCTAssertEqual(dispatch.composeURL(to: "test@mail.com").absoluteString, "x-dispatch:///compose?to=test@mail.com")
        XCTAssertEqual(dispatch.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "x-dispatch:///compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testSpark() throws {
        let spark = try XCTUnwrap(clientWithURLScheme("readdle-spark"))

        XCTAssertEqual(spark.openURL().absoluteString, "readdle-spark:")
        XCTAssertEqual(spark.composeURL().absoluteString, "readdle-spark://compose")
        XCTAssertEqual(spark.composeURL(to: "test@mail.com").absoluteString, "readdle-spark://compose?recipient=test@mail.com")
        XCTAssertEqual(spark.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "readdle-spark://compose?recipient=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testAirmail() throws {
        let airmail = try XCTUnwrap(clientWithURLScheme("airmail"))

        XCTAssertEqual(airmail.openURL().absoluteString, "airmail:")
        XCTAssertEqual(airmail.composeURL().absoluteString, "airmail://compose")
        XCTAssertEqual(airmail.composeURL(to: "test@mail.com").absoluteString, "airmail://compose?to=test@mail.com")
        XCTAssertEqual(airmail.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "airmail://compose?to=test@mail.com&subject=Sub&plainBody=ABC%20def")
    }

    func testOutlook() throws {
        let outlook = try XCTUnwrap(clientWithURLScheme("ms-outlook"))

        XCTAssertEqual(outlook.openURL().absoluteString, "ms-outlook:")
        XCTAssertEqual(outlook.composeURL().absoluteString, "ms-outlook://compose")
        XCTAssertEqual(outlook.composeURL(to: "test@mail.com").absoluteString, "ms-outlook://compose?to=test@mail.com")
        XCTAssertEqual(outlook.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "ms-outlook://compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testYahooMail() throws {
        let yahoo = try XCTUnwrap(clientWithURLScheme("ymail"))

        XCTAssertEqual(yahoo.openURL().absoluteString, "ymail:")
        XCTAssertEqual(yahoo.composeURL().absoluteString, "ymail://mail/compose")
        XCTAssertEqual(yahoo.composeURL(to: "test@mail.com").absoluteString, "ymail://mail/compose?to=test@mail.com")
        XCTAssertEqual(yahoo.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "ymail://mail/compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }

    func testFastmail() throws {
        let fastmail = try XCTUnwrap(clientWithURLScheme("fastmail"))

        XCTAssertEqual(fastmail.openURL().absoluteString, "fastmail:")
        XCTAssertEqual(fastmail.composeURL().absoluteString, "fastmail://mail/compose")
        XCTAssertEqual(fastmail.composeURL(to: "test@mail.com").absoluteString, "fastmail://mail/compose?to=test@mail.com")
        XCTAssertEqual(fastmail.composeURL(to: "test@mail.com", subject: "Sub", body: "ABC def").absoluteString, "fastmail://mail/compose?to=test@mail.com&subject=Sub&body=ABC%20def")
    }
}
