//
//  DetailCardViewController.swift
//  About
//
//  Created by yunseo on 9/30/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {

    var image: UIImage?
    static func instanceViewController(image: UIImage) -> DetailCardViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailCardViewController") as! DetailCardViewController
        
        controller.image = image
        
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
