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
        cell.textLabel?.text = client.name

        if ThirdPartyMailer.application(UIApplication.sharedApplication(), isMailClientAvailable: client) {
            cell.detailTextLabel?.text = NSLocalizedString("Available", comment: "")
            cell.detailTextLabel?.textColor = view.tintColor
        }
        else {
            cell.detailTextLabel?.text = NSLocalizedString("Unvailable", comment: "")
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }

        return cell
    }
}
