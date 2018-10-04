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
    var selectedCategory: Category!
    var TemplatesList = [Template]()
//    var categoryList = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.register(UINib.init(nibName: "TemplateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TemplateCollectionViewCellID")
//        detailCollectionView.register(CategoryCollectionHeaderView.self, forSupplementaryViewOfKind: "CategoryCollectionHeaderViewID", withReuseIdentifier: "CategoryCollectionHeaderViewID")
        
        detailCollectionView.register(UINib(nibName: "CategoryCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CategoryCollectionHeaderViewID")
//        detailCollectionView.register(CategoryHeaderCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryHeaderCollectionViewCellID")
//        detailCollectionView.register(UINib.init(nibName: "CategoryHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryHeaderCollectionViewCellID")

        setCollectionViewCellSize(collectionView: detailCollectionView)
        
//        detailCollectionView.layer.headerReferenceSize = CGSizeMake(0, 200);
        if TemplatesList.count == 0
        {
            getCategoryTemplatesList()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - UICollectionViewDataSources
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return TemplatesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
//        if indexPath.section == 0
//        {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryHeaderCollectionViewCellID", for: indexPath as IndexPath) as! CategoryHeaderCollectionViewCell
//            cell.setUpViewData(category: selectedCategory, parent:self)
//            return cell
//        }
//        else
//        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TemplateCollectionViewCellID", for: indexPath as IndexPath) as! TemplateCollectionViewCell
            cell.updateData(template: TemplatesList[indexPath.row])
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        if (kind == UICollectionElementKindSectionHeader)
        {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategoryCollectionHeaderViewID", for: indexPath) as? CategoryCollectionHeaderView
            if selectedCategory == nil
            {
                headerView?.setUpAllTemplatesViewData(parent: self)
            }
            else
            {
                headerView?.setUpViewData(category: selectedCategory, parent: self)
            }
            return headerView ?? UICollectionReusableView()
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TemplateViewControllerID") as! TemplateViewController
        vc.templateInfo = TemplatesList[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setCollectionViewCellSize(collectionView: UICollectionView)
    {
        let cellWidth = (UIScreen.main.bounds.width-15-15-10)/2
        let cellSize = CGSize(width: cellWidth, height:cellWidth*0.8)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 10
        
        let screenSize = UIScreen.main.bounds
        layout.headerReferenceSize = CGSize(width: screenSize.width, height: 0.7*screenSize.width)
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
    }
        
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
//    {
//        return CGSize(width: collectionView.bounds.width, height: 200)
//    }
   
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let cellWidth = (UIScreen.main.bounds.width-15-15-10)/2
//        let cellSize = CGSize(width: cellWidth, height:cellWidth*0.8)
//        return cellSize
//    }
    
    @IBAction func backButtonClicked(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func getCategoryTemplatesList() {
       NetworkManager.Instance.getRequestData(APIConstants.GET_TEMPLATES_BY_CATEGORY+selectedCategory.id.description, userAuthParameters: AppHelper.Instance.getUserAuthParameters(), withCompletionHandler: { (response) in
            
            print("RESTTTTTT: getTemplates "+response.description)
            
            for data in response.array!
            {
                let dic = Template(id: data["id"].description , status: data["status"].description, draft_status: data["draft_status"].description, category: data["category"].description,  duration: data["duration"].description, categoryName: data["category_name"].description, type: data["type"].description.description, price: data["price"].description , priceInr: data["price_inr"].description , priceSar: data["price_sar"].description ?? "", code: data["code"].description ?? "", templateTitle: data["template_title"].description ?? "", thumbnail: data["thumbnail"].description ?? "", video: data["video"].description ?? "", definition: data["definition"].description ?? "", createdAt: data["created_at"].description ?? "", updatedAt: data["updated_at"].description ?? "", baseURL: BaseURL(rawValue: data["base_url"].description ))
                
                self.TemplatesList.append(dic)
            }
            
            self.detailCollectionView.reloadData()
        })
    }
    
}
