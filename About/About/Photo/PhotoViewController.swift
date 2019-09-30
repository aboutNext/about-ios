//
//  PhotoViewController.swift
//  About
//
//  Created by yunseo on 9/30/19.
//  Copyright © 2019 aboutNext. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "PhotoViewCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        self.collectionView.register(PhotoViewCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        
    }
}

extension PhotoViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoViewCollectionViewCell
        cell.backgroundColor = UIColor.green
        return cell
    }
}
