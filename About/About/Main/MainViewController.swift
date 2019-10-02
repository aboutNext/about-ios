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

    @IBOutlet weak var galleryBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cardButton: UIButton!
    let picker = UIImagePickerController()
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        picker.delegate = self
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
    
    @IBAction func touchUpSelectNewImage(_ sender: Any) {

//         checkPermission {
//            openCamera()
            self.openLibrary()
//        }
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
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.allowsEditing = false
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
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
            tableView.reloadData()
//            showDetailViewController()
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func showDetailViewController() {
        guard let selectedImage = image else { return }
        let vc = DetailCardViewController.instanceViewController(image: selectedImage)
        present(vc, animated: true, completion: nil)
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
        if let testImage = self.image {
            cell.backgroundImageView.image = testImage
        }
        return cell
    }
}
