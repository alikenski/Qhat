//
//  Constants.swift
//  Qhat
//
//  Created by Alisher Aidarkhan on 12/25/19.
//  Copyright © 2019 Alisher Aidarkhan. All rights reserved.
//

struct K {
    static let appName = "Qhat"
    struct Segue {
        static let register:String = "RegisterToChat"
        static let login:String = "LoginToChat"
    }
    
    struct Cell {
        static let identifier:String = "ReusableCell"
        static let nibName:String = "MessageCell"
    }
    
    struct BrandColors {
        static let blueLight:String = "blueLight"
        static let blueDark:String = "blueDark"
        static let redLight:String = "redLight"
        static let redDark:String = "redDark"
    }
    
    struct FStore {
        static let collectionName:String = "messages"
        static let senderField:String = "sender"
        static let bodyField:String = "body"
        static let dateField:String = "date"
    }
    
}
