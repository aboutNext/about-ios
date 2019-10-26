//
//  LoginViewController.swift
//  About
//
//  Created by MacBook on 26/10/2019.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var signInGoogleButton: GIDSignInButton!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn();
//        [[GIDSignIn sharedInstance] restorePreviousSignIn];
         // Do any additional setup after loading the view.
     }
    @IBAction func onClickGoogleButton(_ sender: Any) {
    
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
//        return GIDSignIn.sharedInstance().handle(url,
//                                sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                                annotation: [:])
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }


    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
        
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
//      println(credential)
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            // ...
            return
          }
          // User is signed in
          // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        
    }
}
