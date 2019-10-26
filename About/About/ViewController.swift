//
//  ViewController.swift
//  About
//
//  Created by yunseo on 9/30/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
          // 계정 상태가 변경되었을때
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}

