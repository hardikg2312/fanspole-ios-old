//
//  UserDefaults.swift
//  Fanspole
//
//  Created by Hardik Gondaliya on 18/02/17.
//  Copyright © 2017 Fanspole. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case accessToken
        case refreshToken
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setAccessTokenn(value: String) {
        set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
        synchronize()
    }
    
    func getAccessTokenn() -> String {
        if let token = string(forKey: UserDefaultsKeys.accessToken.rawValue) {
            return token
        }
        return ""
    }
    
    func setRefreshToken(value: String) {
        set(value, forKey: UserDefaultsKeys.refreshToken.rawValue)
        synchronize()
    }
    
    func getRefreshToken() -> String {
        if let token =  string(forKey: UserDefaultsKeys.refreshToken.rawValue) {
            return token
        }
        return ""
    }
    
}
