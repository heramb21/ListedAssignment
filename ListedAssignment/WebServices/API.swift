//
//  API.swift
//  ListedAssignment
//
//  Created by Heramb on 04/03/23.
//

import Foundation
protocol EndPointType {
    // MARK: - Vars 
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
}
enum NetworkEnvironment {
    case integration
}
enum EndpointItem{
    case dashboard
}
extension EndpointItem: EndPointType {
    var baseURL: String {
        switch API.networkEnviroment {
        case .integration:
            debugPrint("Integraton setup Done")
            return "https://api.inopenapp.com/api/v1"
        }
    }
    var path: String {
        switch self {
        case .dashboard:
            return "/dashboardNew"
        }
    }
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}
class API{
    
    static let shared: API = {
        return API()
    }()
    static let networkEnviroment: NetworkEnvironment = .integration
}
