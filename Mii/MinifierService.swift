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
    func minifyCss(css:String, success:(String) -> Void, failure: (NSError) -> Void)-> Void{
        var request = HTTPTask()
        let params: Dictionary<String, AnyObject> = ["input": css]
        
        request.POST("http://cssminifier.com/raw", parameters: params, success: {(response: HTTPResponse) in
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
