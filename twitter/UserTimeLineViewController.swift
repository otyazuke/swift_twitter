//
//  UserTimeLineViewController.swift
//  twitter
//
//  Created by 鶴田拓也 on 2016/11/18.
//  Copyright © 2016年 Takuya Tsuruda. All rights reserved.
//

import Foundation
import TwitterKit

class UserTimeLineViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                self.dataSource = TWTRUserTimelineDataSource(screenName: session!.userName, apiClient: client)
            } else {
                print("error: \(error!.localizedDescription)")
            }
        }
    }
    
}

