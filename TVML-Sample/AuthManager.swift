//
//  AuthManager.swift
//  TVML-Sample
//
//  Created by Susumu Hoshikawa on 2017/12/10.
//  Copyright © 2017年 SH Lab, Inc. All rights reserved.
//

import UIKit

class AuthManager: NSObject, AuthManagerProtocol {
    // ユーザ名の保存処理.
    func setUserName(_ userName: String) {
        let defaults = UserDefaults.standard
        defaults.set(userName, forKey: "USER_NAME")
        defaults.synchronize()
    }
    // ユーザ名の取得処理.
    func userName() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "USER_NAME") ?? "(no user)"
    }
}
