//
//  AppDelegate.swift
//  TVML-Sample
//
//  Created by Susumu Hoshikawa on 2017/12/10.
//  Copyright © 2017年 SH Lab, Inc. All rights reserved.
//

import UIKit
import TVMLKit

@UIApplicationMain
class AppDelegate: UIResponder {
    
    var window: UIWindow?
    var appController: TVApplicationController?
    
    static let tvBaseURL = "http://localhost:9001/"
    static let tvBootURL = "\(AppDelegate.tvBaseURL)/application.js"
    
    // MARK: Javascript Execution Helper
    
    func executeRemoteMethod(_ methodName: String, completion: @escaping (Bool) -> Void) {
        appController?.evaluate(inJavaScriptContext: { (context: JSContext) in
            let appObject : JSValue = context.objectForKeyedSubscript("App")
            if appObject.hasProperty(methodName) {
                appObject.invokeMethod(methodName, withArguments: [])
            }
        }, completion: completion)
    }
}

// MARK: UIApplicationDelegate.

extension AppDelegate: UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Create the TVApplicationControllerContext for this application and set the properties that will be passed to the `App.onLaunch` function in JavaScript.
        let appControllerContext = TVApplicationControllerContext()
        
        // The JavaScript URL is used to create the JavaScript context for your TVMLKit application. Although it is possible to separate your JavaScript into separate files, to help reduce the launch time of your application we recommend creating minified and compressed version of this resource. This will allow for the resource to be retrieved and UI presented to the user quickly.
        if let javaScriptURL = URL(string: AppDelegate.tvBootURL) {
            appControllerContext.javaScriptApplicationURL = javaScriptURL
        }
        
        appControllerContext.launchOptions["BASEURL"] = AppDelegate.tvBaseURL as NSString
        
        if let launchOptions = launchOptions {
            for (kind, value) in launchOptions {
                appControllerContext.launchOptions[kind.rawValue] = value
            }
        }
        
        appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
        
        return true
    }
}

// MARK: TVApplicationControllerDelegate.

extension AppDelegate: TVApplicationControllerDelegate {
    
    func appController(_ appController: TVApplicationController, didFinishLaunching options: [String: Any]?) {
        print("\(#function) invoked with options: \(options ?? [:])")
    }
    
    func appController(_ appController: TVApplicationController, didFail error: Error) {
        print("\(#function) invoked with error: \(error)")
        
        let title = "Error Launching Application"
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title, message: message, preferredStyle:.alert )
        
        self.appController?.navigationController.present(alertController, animated: true, completion: {
            // ...
        })
    }
    
    func appController(_ appController: TVApplicationController, didStop options: [String: Any]?) {
        print("\(#function) invoked with options: \(options ?? [:])")
    }
    
    // TVApplicationControllerDelegateのメソッドを実装する.
    func appController(_ appController: TVApplicationController, evaluateAppJavaScriptIn jsContext: JSContext) {
        // 文字列を受け取って出力するだけのクロージャ.
        let closure: @convention(block) (String) -> Void = {
            print($0)
        }
        // "log"という名前でクロージャを登録する.
        jsContext.setObject(closure, forKeyedSubscript: "log" as NSString)
        
        // "authManager"という名前で、クラス単位で登録する.
        jsContext.setObject(AuthManager(), forKeyedSubscript: "authManager" as NSString)
    }
}
