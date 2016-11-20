//
//  ViewController.swift
//  twitter
//
//  Created by 鶴田拓也 on 2016/11/14.
//  Copyright © 2016年 Takuya Tsuruda. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "login"
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In",
                                              message: "User \(unwrappedSession.userName) has logged in",
                    preferredStyle: UIAlertControllerStyle.alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "timeline", sender: session)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let session = sender as? TWTRSession
        let dest = segue.destination as! TimelineViewController
        dest.title = session?.userName
        dest.userId = session?.userID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

