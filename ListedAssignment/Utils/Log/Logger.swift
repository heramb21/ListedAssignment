//
//  Logger.swift
//  ListedAssignment
//
//  Created by Heramb on 06/03/23.
//

import Foundation
enum LogType: String{
    case error
    case warning
    case success
}

class Logger{
    static func log(_ logType:LogType,_ message:String){
        switch logType {
        case LogType.error:
            print("\n📕 Error: \(message)\n")
        case LogType.warning:
            print("\n⚠️ Warning: \(message)\n")
        case LogType.success:
            print("\n✅ Success: \(message)\n")
    }
    }
}
