//
//  BTDevice.swift
//  ListOfPossibleConnections
//
//  Created by Володимир Ільків on 2/14/19.
//  Copyright © 2019 Володимр Ільків. All rights reserved.
//

import Foundation
import CoreBluetooth

class BTDevice {
    var deviceName: String?
    var RSSI: NSNumber?
    var deviceIdentifier: UUID
    init (name: String, rssi: NSNumber, identifier: UUID) {
        deviceName  = name
        RSSI = rssi
        deviceIdentifier = identifier
    }
}
