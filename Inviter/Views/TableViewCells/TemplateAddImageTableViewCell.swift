//
//  TemplateAddImageTableViewCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 9/1/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class TemplateAddImageTableViewCell: UITableViewCell, UICollectionViewDataSource {

    @IBOutlet weak var dottedBGView: UIView!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        AppHelper.Instance.setDottedLineToView(yourView: dottedBGView)
        dottedBGView.layer.borderColor = UIColor.red.cgColor
        dottedBGView.layer.borderWidth = 5.0
        // Initialization code
        
        imagesCollectionView.register(UINib.init(nibName: "TemplateAddImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TemplateAddImageCollectionViewCellID")
        setCollectionViewCellSize(collectionView: imagesCollectionView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionViewCellSize(collectionView: UICollectionView)
    {
        let cellWidth = (collectionView.frame.width)/4
        let cellSize = CGSize(width: cellWidth, height:cellWidth*1.0)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
    }
    
    @IBAction func showAddImagesViewButtonClicked(_ sender: UIButton)
    {
        dottedBGView.isHidden = true
    }
    
    // MARK: - UICollectionViewDataSource Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateAddImageCollectionViewCellID", for: indexPath) as! TemplateAddImageCollectionViewCell
        return cell
        
    }
    
}
