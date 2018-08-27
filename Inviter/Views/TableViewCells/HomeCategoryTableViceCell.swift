//
//  HomeCategoryTableViceCell.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//
import UIKit
import Foundation

enum HomeCollectionCellType {
    case Template
    case Catergory
}
class HomeCategoryTableViceCell: UITableViewCell, UICollectionViewDataSource
{
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var homeCellType:HomeCollectionCellType!
    private var CategoriesList = [Category]()
    private var TemplatesList = [Template]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemsCollectionView.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCellID")
        
        itemsCollectionView.register(UINib.init(nibName: "TemplateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TemplateCollectionViewCellID")
        
        itemsCollectionView.register(UINib.init(nibName: "ShowAllCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ShowAllCollectionViewCellID")
        
        //        itemsCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCellID")
        //
        //        itemsCollectionView.register(TemplateCollectionViewCell.self, forCellWithReuseIdentifier: "TemplateCollectionViewCellID")
        
        setCollectionViewCellSize()
        itemsCollectionView.layoutIfNeeded()
        
    }
    
    func updateCategoriesViewData(categories: [Category])
    {
        CategoriesList = categories
//        itemsCollectionView.reloadSections(IndexSet(integer: 0)) // TODO : update only section data
        itemsCollectionView.reloadData()
    }
    
    func updateTemplatesViewData(templates: [Template])
    {
        TemplatesList = templates
//        itemsCollectionView.reloadSections(IndexSet(integer: 1)) // TODO : update only section data
        itemsCollectionView.reloadData()
    }
    
    func setCollectionViewCellSize()
    {
        // TODO: Check dynamic height
        //        let cellWidth = (UIScreen.main.bounds.width-15-15-10)/2
        //        let cellSize = CGSize(width: cellWidth, height:cellWidth*0.8)
        let cellSize = CGSize(width: 156, height:120)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //.horizontal
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10
        itemsCollectionView.setCollectionViewLayout(layout, animated: true)
        itemsCollectionView.reloadData()
        
        itemsCollectionView.layoutIfNeeded()
    }
    
    // MARK: - UICollectionView DataSources
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        // TODO: Update dynamic items
        if homeCellType == HomeCollectionCellType.Catergory
        {
            return CategoriesList.count > 0 ? 4 : 0
        }
        return TemplatesList.count > 0 ? 4 : 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if indexPath.item == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowAllCollectionViewCellID", for: indexPath as IndexPath) as! ShowAllCollectionViewCell
            return cell
        }
        else
        {
            switch homeCellType
            {
            case .Template:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateCollectionViewCellID", for: indexPath as IndexPath) as! TemplateCollectionViewCell
                cell.updateData(template: TemplatesList[indexPath.item])
                return cell
            case .Catergory:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCellID", for: indexPath as IndexPath) as! CategoryCollectionViewCell
                cell.updateData(category: CategoriesList[indexPath.item])
                return cell
            default: ()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCellID", for: indexPath as IndexPath) as! CategoryCollectionViewCell
            cell.updateData(category: CategoriesList[indexPath.item])
            return cell
            }
        }
    }
}

