//# sourceURL=application.js

//
//  application.js
//  TVML-Sample
//
//  Created by Susumu Hoshikawa on 2017/12/10.
//  Copyright © 2017年 SH Lab, Inc. All rights reserved.
//

App.onLaunch = function(options) {
    
    const url = options.BASEURL + "HelloWorld.xml";
    
    var templateXHR = new XMLHttpRequest();
    templateXHR.responseType = "document";
    templateXHR.addEventListener("load", function() {
        navigationDocument.pushDocument(templateXHR.responseXML);
    }, false);
    templateXHR.open("GET", url, true);
    templateXHR.send();
}

// 登録したクロージャを呼ぶためのfunction.
function logWithSwift() {
    // 登録したクロージャを呼び出す.
    log("jsからswiftを呼ぶよ");
}

// ユーザ名の保存処理を呼び出す.
function setUserNameWithSwift(userName) {
    authManager.setUserName(userName);
}
// ユーザ名の取得処理を呼び出す.
function userNameWithSwift() {
    const userName = authManager.userName();
    log(`userName = ${userName}`);
}
