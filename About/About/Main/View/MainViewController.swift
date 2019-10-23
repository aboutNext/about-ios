//
//  MainViewController.swift
//  About
//
//  Created by yunseo on 9/30/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit
import Photos

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cardButton: UIButton!
    let picker = UIImagePickerController()
    var image: UIImage?
    var cards = [CardData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        picker.delegate = self
        makeTestData()
      
    }
    
    func setupUI() {
        let nibName = UINib(nibName: "MainCardTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MainCardTableViewCell")
        self.view.addSubview(tableView)
        self.view.addSubview(cardButton)
        cardButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        cardButton.layer.masksToBounds = false
        cardButton.layer.shadowRadius = 1.0
        cardButton.layer.shadowOpacity = 0.5
        cardButton.layer.cornerRadius = cardButton.frame.width / 2
        cardButton.addTarget(self, action: #selector(cardButtonClick(_:)), for: .touchUpInside)
    }
    
    @objc func cardButtonClick(_ sender: UIButton){
        self.openLibrary()
    }
    
    func checkPermission(hanler: @escaping () -> Void) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            // Access is already granted by user
            hanler()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    // Access is granted by user
                    hanler()
                }
            }
        default:
            print("Error: no access to photo album.")
        }
    }
    
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.allowsEditing = false
        present(picker, animated: false, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController .isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = selectedImage
            var newCard = CardData.init(cardID: UUID(), date: Date())
            newCard.image = image
            cards.insert(newCard, at: 0)
        }
        dismiss(animated: true) {
            self.tableView.reloadData()
//            self.showDetailViewController()
        }
    }
    
    private func showDetailViewController() {
        guard let selectedImage = image else { return }
        let vc = DetailCardViewController.instanceViewController(image: selectedImage)
        present(vc, animated: true, completion: nil)
    }
    
    private func makeTestData() {
        for _ in 0..<5 {
            var card = CardData.init(cardID: UUID(), date: Date())
            card.imageName = "image1"
            cards.append(card)
        }
        tableView.reloadData()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DetailViewController 로 이동
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCardTableViewCell", for: indexPath) as! MainCardTableViewCell
        let card = cards[indexPath.row]

        //Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        let dateString =  dateFormatter.string(from: card.date)
        cell.dateLabel.text = dateString
        
        if let name = card.imageName, let testImage = UIImage(named: name) {
            cell.backgroundImageView.image = testImage
        }
        //test
        if let image = card.image {
            cell.backgroundImageView.image = image
        }
        return cell
    }
}
