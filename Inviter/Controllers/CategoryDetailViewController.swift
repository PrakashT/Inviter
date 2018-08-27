//
//  CategoryDetailViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/26/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class CategoryDetailViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.register(UINib.init(nibName: "TemplateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TemplateCollectionViewCellID")
        
        setCollectionViewCellSize(collectionView: detailCollectionView)
        
//        detailCollectionView.layer.headerReferenceSize = CGSizeMake(0, 200);

    }
    
    // MARK: - UICollectionViewDataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateCollectionViewCellID", for: indexPath as IndexPath) as! TemplateCollectionViewCell
        return cell
    }
    
    func setCollectionViewCellSize(collectionView: UICollectionView)
    {
        let cellWidth = (UIScreen.main.bounds.width-15-15-10)/2
        let cellSize = CGSize(width: cellWidth, height:cellWidth*0.8)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "", withReuseIdentifier: "CollectionHeaderViewID", for: indexPath as IndexPath)
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderViewID", for: indexPath as IndexPath)
//        return headerView
//    }
}
