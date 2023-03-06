//
//  Connectivity.swift
//  ListedAssignment
//
//  Created by Heramb on 05/03/23.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

