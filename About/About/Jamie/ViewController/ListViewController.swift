//
//  ListViewController.swift
//  About
//
//  Created by yunseo on 11/20/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var highlights = [Highlight]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeTestData()
     }
     
     func setupUI() {
         let nibName = UINib(nibName: "ListTableViewCell", bundle: nil)
         tableView.register(nibName, forCellReuseIdentifier: "ListTableViewCell")
         self.view.addSubview(tableView)
    }
    
    private func makeTestData() {
        for i in 0..<10 {
            var data = Highlight.init(highlightID: UUID(), date: Date(), title: "오늘의 할일")
            data.memo = "오늘의 메모 123123 12312312 123123"
            data.isSuccess = i % 2 == 0 ? true : false
            highlights.append(data)
        }
        tableView.reloadData()
    }
}



extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
            headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //임시 설정
        return CardConstant.mainTableViewSectionHeaderHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        let data = highlights[indexPath.row]

        //Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd"
        let dateString =  dateFormatter.string(from: data.date)
        cell.dateLabel.text = dateString
        cell.titleLabel.text = data.title
        print(data.isSuccess)
//        
//        if let name = card.imageName, let testImage = UIImage(named: name) {
//            cell.backgroundImageView.image = testImage
//        }
//        //test
//        if let image = card.image {
//            cell.backgroundImageView.image = image
//        }
        return cell
    }
}
