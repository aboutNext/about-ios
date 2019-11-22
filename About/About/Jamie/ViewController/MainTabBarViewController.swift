//
//  MainTabBarViewController.swift
//  About
//
//  Created by yunseo on 11/22/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit

class MainTabBarViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var backgroundView: UIImageView!
    
    var listViewController: UIViewController!
    var mainViewController: UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    var movingView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        listViewController = storyboard.instantiateViewController(withIdentifier: "ListViewController")
        mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        
        
        viewControllers = [listViewController, mainViewController]
        
        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])

        let screenWidth = UIScreen.main.bounds.width
               movingView = UIView(frame: CGRect(x: 0, y: 80, width: screenWidth / 5, height: 5))
               movingView.backgroundColor = UIColor.red
               backgroundView.addSubview(movingView)
        
    }
    

    @IBAction func didPressTab(_ sender: UIButton) {
        
        let previousIndex = selectedIndex

        selectedIndex = sender.tag

        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]

        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()

        sender.isSelected = true

        let vc = viewControllers[selectedIndex]

        addChild(vc)

        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParent: self)

        let newx = sender.frame.origin.x

        UIView.animate(withDuration: 1.0) {
            self.movingView.frame.origin.x = newx
        }
    }
}
