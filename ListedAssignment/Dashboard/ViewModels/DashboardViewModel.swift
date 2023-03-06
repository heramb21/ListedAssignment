//
//  DashboardViewModel.swift
//  ListedAssignment
//
//  Created by Heramb on 06/03/23.
//

import Foundation
import UIKit
import Alamofire
class DashboardViewModel{
    var vc: ViewController?
    var dashboardDetails: DashboardAPIResponse?
    //   Network calls are here
    //   Get the user's dashboard details.
    func getDashboardDetails() {
        let headers : HTTPHeaders = ["Authorization":"Bearer \(listedDefaults.shared.retriveToken())"]
        NetworkManager.shared.request(type: EndpointItem.dashboard, method: .get, parameters:[:], headers:headers, interceptor: nil, vc:vc) { data, error  in
            guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(DashboardAPIResponse.self, from:data as! Data)
                self.dashboardDetails = json
                Logger.log(.success, "Json   : \(json)")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}
