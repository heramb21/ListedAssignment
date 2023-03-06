//
//  NetworkManager.swift
//  ListedAssignment
//
//  Created by Heramb on 04/03/23.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import Lottie

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case somethingWrong
    case usernameExist
    case moveToMissingQueue
}

enum NetworkResult {
    case success(Data)
    case failure(RequestError)
}

// MARK: - Singleton
// 1. You need only one instance in the whole project. Having multiple NetworkManager won’t give you any performance benefits. However, having one is an optimal solution regarding memory.
// 2. Other classes should use NetworkManager as dependency. You’ll use singleton shared instance only when injecting it to other objects or in composition root.
class NetworkManager : RequestInterceptor {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    var validToken: String?
    var isRefreshing: Bool = false
    var request: Alamofire.Request?
    let progressHUD = LottieProgressHUD.shared
    func request(type:EndPointType, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders,
                 interceptor: RequestInterceptor? = nil, isLoader :Bool = true, vc : UIViewController?,completion: @escaping ((Any?), Error?)-> Void){
        var en : ParameterEncoding
        if method == .get{
            en = URLEncoding.queryString
        }else{
            en = JSONEncoding.prettyPrinted
        }
        if isLoader == false{
            
        }else{
            DispatchQueue.main.async {
                vc?.lottieStartAnimating(vc: vc)
            }
        }
        checkInternetConnection(vc:vc ?? UIViewController())
        let headerz : HTTPHeaders  = ["Authorization":"Bearer \(listedDefaults.shared.retriveToken())"]
        //#if DEBUG
        print("Alamofire Implementation---->")
        print("Header  : \(headerz)")
        print("Parameters  : \(parameters)")
        print("url  : \(type.url)")
        //#endif
        AF.request(type.url, method: method, parameters:parameters,encoding:en,
                   headers: headerz, interceptor: interceptor ?? self).validate().responseJSON { (response) in
            let statusCode = response.response?.statusCode ?? 0
            debugPrint("Status Code : \(statusCode)")
            switch statusCode {
            case 401 :
                debugPrint("401 : \(String(describing: response.error?.localizedDescription))")
                break
            case 404 :
                debugPrint("API is not deployed or : \(String(describing: response.error?.localizedDescription))")
            default :
                break
            }
            switch response.result {
            case .success(_):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String: Any] {
                        print("JSON data : \(json)")
                        //                        completion(response.data ,nil)
                        if (json["status"] as! Int == 1){
                            DispatchQueue.main.async {
                                debugPrint("response:\(json)")
                            }
                        }
                    }
                }
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                vc?.lottieStopAnimating()
                completion(response.data ,nil)
            case .failure(let error):
                print("Request failed with error: \(error)")
                vc?.lottieStopAnimating()
                completion(nil ,response.error)
            }
        }
    }
    
    func checkInternetConnection(vc : UIViewController){
        if Connectivity.isConnectedToInternet {
            debugPrint("Yes! internet is available.")
        }else{
            debugPrint("Oh no there is no internet connection")
        }
    }
}

extension UIViewController {
    @objc func lottieStartAnimating(vc : UIViewController?){
        DispatchQueue.main.async {
            let progressHUD = LottieProgressHUD.shared
            progressHUD.center = self.view.center
            progressHUD.hudBackgroundColor = UIColor.white.withAlphaComponent(0.8)
            self.view.addSubview(progressHUD)
            progressHUD.show()
        }
    }
    @objc func lottieStopAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let view = self.view
            let progressHUD = LottieProgressHUD.shared
            if ((view?.subviews.contains(progressHUD)) != nil) {
                progressHUD.hide()
            }else{
                progressHUD.hide()
            }
        }
    }
}
