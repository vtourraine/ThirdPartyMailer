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
    let application = UIApplication.sharedApplication()

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let client = clients[indexPath.row]
        cell.textLabel?.text = client.name
        application.isMailClientAvailable(client)
        return cell
    }
}
