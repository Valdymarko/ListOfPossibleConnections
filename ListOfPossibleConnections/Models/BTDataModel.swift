//
//  BTDataModel.swift
//  ListOfPossibleConnections
//
//  Created by Володимир Ільків on 2/14/19.
//  Copyright © 2019 Володимр Ільків. All rights reserved.
//

import Foundation
import CoreBluetooth

let kNewDeviceDiscovered: String = "newDeviceDiscovered"

final class BTDataModel: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    // MARK: - Properties
    private var btManager: CBCentralManager?
    private var set = Set<BTDevice>()
    public var btDevices = [BTDevice]()
    public var btAvailable: Bool?
    // MARK: - Shared
    static let sharedInstance = BTDataModel()
    // MARK: - Initializer
    override init () {
        super.init()
        btManager = CBCentralManager.init(delegate: self, queue: nil)
    }
    // MARK: - Functions
    public func scanForAvailableDevices() {
        btDevices.removeAll()
        btManager?.scanForPeripherals(withServices: nil, options: nil)
    }
    public func stopScan() {
        btManager?.stopScan()
    }
    public func isScanning() -> Bool? {
      return btManager?.isScanning
    }
    // MARK: - CBCentralManager delegate
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let btDeivce = BTDevice(name: peripheral.name ?? "N/A", rssi: RSSI, identifier: peripheral.identifier)
        set.insert(btDeivce)
        btDevices = Array(set)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNewDeviceDiscovered), object: nil)
    }
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            scanForAvailableDevices()
            btAvailable = true
        default:
            btAvailable = false
        }
    }
}
