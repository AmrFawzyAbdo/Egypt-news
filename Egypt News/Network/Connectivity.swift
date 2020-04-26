//
//  Connectivity.swift
//  BlueRideDriver
//
//  Created by Apple on 4/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import Alamofire


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
