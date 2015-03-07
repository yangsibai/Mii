//
//  MinifierService.swift
//  M
//
//  Created by yangsibai on 15/2/28.
//  Copyright (c) 2015年 massimo. All rights reserved.
//

import Foundation
import SwiftHTTP

class MinifierService{
    
    func minify(type:ContentType, content:String, success:(String) -> Void, failure: (NSError) -> Void) -> Void{
        var apiURL:String = ""
        switch(type){
            case ContentType.CSS:
                apiURL = "http://cssminifier.com/raw"
        case ContentType.JavaScript:
            apiURL = "http://javascript-minifier.com/raw"
        default:
            failure(NSError(domain: "unknown content type", code: -1, userInfo: nil))
        }
        var request = HTTPTask()
        let params: Dictionary<String, AnyObject> = ["input": content]
        request.POST(apiURL, parameters: params, success: {(response: HTTPResponse) in
            if let data = response.responseObject as? NSData{
                let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                return success(str!)
            }
            success("")
            },failure: {(error: NSError, response: HTTPResponse?) in
                failure(error)
        })
    }
}
