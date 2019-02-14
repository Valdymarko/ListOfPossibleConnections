//
//  ViewController.swift
//  ListOfPossibleConnections
//
//  Created by Володимир Ільків on 2/14/19.
//  Copyright © 2019 Володимр Ільків. All rights reserved.
//

import UIKit
import CoreBluetooth

class BTDevicesListViewController: UITableViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var refreshButton: UIButton!
    // MARK: - Properties
    private var btDataModel = BTDataModel.sharedInstance
    private var devices = [BTDevice]()
    private var isScanning: Bool? = true
    private var buttonTitle: String?
    // MARK: - Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedNewBluetoothDevice), name: NSNotification.Name(rawValue: kNewDeviceDiscovered), object: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupButtonTitle()
    }
    // MARK: - IBActions
    @IBAction private func refreshButtonAction(_ sender: Any) {
        if btDataModel.btAvailable == true {
            if isScanning! {
                btDataModel.stopScan()
            } else {
                btDataModel.scanForAvailableDevices()
            }
            setupButtonTitle()
        } else {
            let alert = UIAlertController.init(title: "Error", message: "Turn on Bluetooth", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    // MARK: - Functions
    private func setupButtonTitle() {
        isScanning = btDataModel.isScanning()
        isScanning! == true ? refreshButton.setTitle("Stop", for: .normal)
                             : refreshButton.setTitle("Refresh", for: .normal)
    }
    // MARK: - NotificationsHandler
    @objc func receivedNewBluetoothDevice () {
        devices = btDataModel.btDevices
        tableView.reloadData()
    }
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "BTDeviceInfoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath)
        let device = devices[indexPath.row]
        cell.textLabel?.text = device.deviceName
        cell.detailTextLabel?.text = "RSSI: " + (device.RSSI?.stringValue)!
        return cell
    }
}
