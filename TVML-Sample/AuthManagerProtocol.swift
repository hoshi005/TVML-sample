//
//  AuthManagerProtocol.swift
//  TVML-Sample
//
//  Created by Susumu Hoshikawa on 2017/12/10.
//  Copyright © 2017年 SH Lab, Inc. All rights reserved.
//

import UIKit
import TVMLKit

@objc
protocol AuthManagerProtocol: JSExport {
    func setUserName(_ userName: String)
    func userName() -> String
}
