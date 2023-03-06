//
//  listedDefaults.swift
//  ListedAssignment
//
//  Created by Heramb on 05/03/23.
//

import Foundation
import UIKit

struct listedKEY{
    
    static let listedTOKEN = "TOKEN"
    static let listedClient = "X-Client-App"
    static let listedVersion = "X-Client-Version"
    static let listedOS = "X-Client-OS-Version"
    static let listedWildAccessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
}

class listedDefaults{
    static let shared = listedDefaults()
    //Initializer access level change now
    private init(){
        
    }
    func saveToken(){
        UserDefaults.standard.set(listedKEY.listedWildAccessToken, forKey:listedKEY.listedTOKEN)
        UserDefaults.standard.synchronize()
    }
    func retriveToken() -> String{
        let retrivedToken = UserDefaults.standard.value(forKey:listedKEY.listedTOKEN) ?? ""
        return retrivedToken as! String
    }
}
