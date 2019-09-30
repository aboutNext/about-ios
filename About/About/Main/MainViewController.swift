//
//  MainViewController.swift
//  About
//
//  Created by yunseo on 9/30/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var galleryBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    func setupUI() {
        let nibName = UINib(nibName: "MainCardTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MainCardTableViewCell")
        self.view.addSubview(self.tableView)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DetailViewController 로 이동
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCardTableViewCell", for: indexPath) as! MainCardTableViewCell
        cell.dateLabel.text = "19.10.1"
        cell.backgroundColor = UIColor.yellow
        return cell
    }
}
