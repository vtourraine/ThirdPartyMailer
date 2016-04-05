//
//  ViewController.swift
//  ThirdPartyMailerExample
//
//  Created by Vincent Tourraine on 28/03/16.
//  Copyright © 2016 Vincent Tourraine. All rights reserved.
//

import UIKit
import ThirdPartyMailer

class ViewController: UITableViewController {

    let clients = ThirdPartyMailClient.clients()


    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let client = clients[indexPath.row]
        let application = UIApplication.sharedApplication()

        cell.textLabel?.text = client.name

        if ThirdPartyMailer.application(application, isMailClientAvailable: client) {
            cell.detailTextLabel?.text = NSLocalizedString("Available", comment: "")
            cell.detailTextLabel?.textColor = view.tintColor
        }
        else {
            cell.detailTextLabel?.text = NSLocalizedString("Unvailable", comment: "")
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }

        return cell
    }


    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let client = clients[indexPath.row]
        let application = UIApplication.sharedApplication()

        ThirdPartyMailer.application(application, openMailClient: client, recipient: nil, subject: NSLocalizedString("Test ThirdPartyMailer", comment: ""), body: nil)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
