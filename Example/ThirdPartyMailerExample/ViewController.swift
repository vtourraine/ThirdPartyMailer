//
//  ViewController.swift
//  ThirdPartyMailerExample
//
//  Created by Vincent Tourraine on 28/03/16.
//  Copyright © 2016-2022 Vincent Tourraine. All rights reserved.
//

import UIKit
import ThirdPartyMailer

class ViewController: UITableViewController {

    let clients = ThirdPartyMailClient.clients

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let client = clients[indexPath.row]
        cell.textLabel?.text = client.name

        if ThirdPartyMailer.isMailClientAvailable(client) {
            cell.detailTextLabel?.text = NSLocalizedString("Available", comment: "")
            cell.detailTextLabel?.textColor = view.tintColor
        }
        else {
            cell.detailTextLabel?.text = NSLocalizedString("Unavailable", comment: "")
            cell.detailTextLabel?.textColor = .red
        }

        return cell
    }


    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let client = clients[indexPath.row]

        ThirdPartyMailer.openCompose(client, subject: NSLocalizedString("Test ThirdPartyMailer", comment: ""))

        tableView.deselectRow(at: indexPath, animated: true)
    }
}
