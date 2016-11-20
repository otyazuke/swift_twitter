//
//  UserTimeLineViewController.swift
//  twitter
//
//  Created by 鶴田拓也 on 2016/11/18.
//  Copyright © 2016年 Takuya Tsuruda. All rights reserved.
//

import Foundation
import TwitterKit

// Timelineを取得
class TwitterAPI {
    let baseURL = "https://api.twitter.com"
    let version = "/1.1"
    
    init() {
        
    }
    
    class func getHomeTimeline(user:String?, tweets: @escaping ([TWTRTweet]) -> (), error: @escaping (NSError) -> ()) {
        let client = TWTRAPIClient(userID: user)
        var clientError: NSError?
        let api = TwitterAPI()
        let path = "/statuses/home_timeline.json"
        let endpoint = api.baseURL + api.version + path
        let request:NSURLRequest? = client.urlRequest(withMethod: "GET", url: endpoint, parameters: nil, error: &clientError) as NSURLRequest?
        
        if request != nil {
            client.sendTwitterRequest(request! as URLRequest, completion: {
                response, data, err in
                if err == nil {
                    var jsonError: NSError?
                    let json:AnyObject? = try! JSONSerialization.jsonObject(with: data!) as AnyObject?
                    if let jsonArray = json as? NSArray {
                        tweets(TWTRTweet.tweets(withJSONArray: jsonArray as! [Any]) as! [TWTRTweet])
                    }else{
                        error(err as! NSError)
                    }
                }else{
                    print("request error: \(err)")
                }
            })
        }
    }
}











