//
//  HomeViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/24/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var homeMenuButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var specificCategoryCollectionVw: UICollectionView!
    @IBOutlet weak var genericCategoryCollectionVw: UICollectionView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var categoryScrollView: UIScrollView!
    @IBOutlet weak var categoryView: UIView!
    
//    private var CategoriesList = [Category]()
    private var CategoriesList_Generic = [Category]()
    private var CategoriesList_Specific = [Category]()

    private var TemplatesList = [Template]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UISegmentedControl.appearance().setTitleTextAttributes(NSDictionary(objects: [UIFont.systemFont(ofSize: 15.0)],
//                                                                            forKeys: [kCTFontAttributeName as! NSCopying]) as? [AnyHashable : Any],
//                                                               for: UIControlState.normal)

        getUserData()

        tableView.estimatedRowHeight = 1.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
          genericCategoryCollectionVw.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCellID")
        specificCategoryCollectionVw.register(UINib.init(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCellID")
        
        setCollectionViewCellSize(collectionView: specificCategoryCollectionVw)
        setCollectionViewCellSize(collectionView: genericCategoryCollectionVw)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.layoutSubviews()
    }
    
    // MARK: - UITableViewDataSources
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCategoryTableViceCellID", for: indexPath) as! HomeCategoryTableViceCell
        
        cell.homeCellType = (indexPath.section == 1) ? HomeCollectionCellType.Template : HomeCollectionCellType.Catergory
        cell.parentVC = self
        if indexPath.section == 0
        {
            cell.updateCategoriesViewData(categories: self.CategoriesList_Generic) // This is for home showall data
        }
        else
        {
            cell.updateTemplatesViewData(templates: TemplatesList)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let hView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: hView.frame.width, height: 60-10-10))
        label.text = (section == 0) ? "By category" : "By template"
        label.textColor = UIColor.lightGray
        label.font = UIFont.init(name: "Arial", size: 20)
        hView.addSubview(label)
        return hView
    }
    
    // MARK: - UITableViewDelegates
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let cellWidth = (UIScreen.main.bounds.width-15-15-10)/2
        return 120//cellWidth*0.8 // TODO: check dynamic height
    }
    
    // MARK: - UICollectionViewDataSources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return (collectionView == specificCategoryCollectionVw) ? CategoriesList_Specific.count : CategoriesList_Generic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var tempCatList = (collectionView == specificCategoryCollectionVw) ? CategoriesList_Specific : CategoriesList_Generic
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCellID", for: indexPath as IndexPath) as! CategoryCollectionViewCell
        cell.updateData(category: tempCatList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) 
    {
        var tempCatList = (collectionView == specificCategoryCollectionVw) ? CategoriesList_Specific : CategoriesList_Generic
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CategoryDetailViewControllerID") as! CategoryDetailViewController
        vc.selectedCategory = tempCatList[indexPath.item]
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
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        
        collectionView.layoutIfNeeded()
    }
    
    @IBAction func categorySegmentClicked(_ sender: UISegmentedControl)
    {
        let scrollViewWidth = categoryScrollView.frame.width
        categoryScrollView.setContentOffset(CGPoint(x: ((CGFloat)(sender.selectedSegmentIndex)*scrollViewWidth), y: categoryScrollView.contentOffset.y), animated: true)
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton)
    {
        
    }
    
    fileprivate func getCategoriesList(categoryType:CategoryType)
    {
        NetworkManager.Instance.getCategories(type:categoryType, userAuthParameters:AppHelper.Instance.getUserAuthParameters(), withCompletionHandler: { (catResponse) in
            
            print("RESTTTTTT: getCategories "+catResponse.description)
            
            for data in catResponse.array!
            {
                let categoryDic =
                    Category(id: data["id"].int ?? 0, categoryName: (data["category_name"].description) , generic: Generic(rawValue: (data["generic"].description) )!, image:  (data["image"].description) , firebaseID: (data["firebase_id"].description ) , createdAt: (data["created_at"].description) , updatedAt: (data["updated_at"].description) )
                
//                self.CategoriesList.append(categoryDic)
                
                // Based on category type data will update
                if(categoryType == .Generic)
                {
                    self.CategoriesList_Generic.append(categoryDic)
                }
                else
                {
                    self.CategoriesList_Specific.append(categoryDic)
                }
            }

//            self.CategoriesList_Generic = self.CategoriesList.filter{ ($0.generic.rawValue == "generic") }
//            self.CategoriesList_Specific = self.CategoriesList.filter{ ($0.generic.rawValue == "specific") }
            
            self.tableView.reloadSections(IndexSet(integer: 0), with: UITableViewRowAnimation.automatic)
            self.specificCategoryCollectionVw.reloadData()
            self.genericCategoryCollectionVw.reloadData()
            
        })
    }
    
    fileprivate func getTemplatesList() {
        NetworkManager.Instance.getTemplates(AppHelper.Instance.getUserAuthParameters(), withCompletionHandler: { (catResponse) in
            
            print("RESTTTTTT: getTemplates "+catResponse.description)
            
            for data in catResponse.array!
            {
                let dic = Template(id: data["id"].description , status: data["status"].description, draft_status: data["draft_status"].description, category: data["category"].description,  duration: data["duration"].description, categoryName: data["category_name"].description, type: data["type"].description.description, price: data["price"].description , priceInr: data["price_inr"].description , priceSar: data["price_sar"].description ?? "", code: data["code"].description ?? "", templateTitle: data["template_title"].description ?? "", thumbnail: data["thumbnail"].description ?? "", video: data["video"].description ?? "", definition: data["definition"].description ?? "", createdAt: data["created_at"].description ?? "", updatedAt: data["updated_at"].description ?? "", baseURL: BaseURL(rawValue: data["base_url"].description ))
                
                self.TemplatesList.append(dic)
            }
            
            self.tableView.reloadSections(IndexSet(integer: 1), with: UITableViewRowAnimation.automatic)
        })
    }
    
    func getUserData()
     {
        NetworkManager.Instance.getUserDetails(UserDefaults.standard.value(forKey: "userID") as! String) { (response) in
            print("RESTTTTTT: getUserDetails "+response.description)
            
            if response["description"].description == "Data retrieved successfully"
            {
                UserDefaults.standard.set(response["data"]["userAPIKeys"]["accessToken"].description, forKey: "accessToken") //Bool
                
                let lastName = response["data"]["userProfile"]["lastName"].description
                let firstName = response["data"]["userProfile"]["firstName"].description

                let name = firstName + (lastName.count > 0 ? " "+lastName : "")
                UserDefaults.standard.set(name, forKey: "UserName") //Bool
                
                UserDefaults.standard.synchronize()

                self.getCategoriesList(categoryType: .Generic)
                self.getCategoriesList(categoryType: .Specific)

                self.getTemplatesList()
            }
            else
            {
                AppHelper.Instance.ShowAlertView(title: "Alert", message: response["description"].description, selfVC: self)
            }
        }
    }
    
    @IBAction func homeButtonClicked(_ sender: UIButton)
    {
       showAllCategories()
    }
    
    func showAllCategories()
    {
        homeMenuButton.isSelected = !(homeMenuButton.tag == 1)
        titleLabel.text = (homeMenuButton.tag == 1) ? "Templates" : "Categories"
        categoryView.isHidden = (homeMenuButton.tag == 1)
        homeMenuButton.tag = (homeMenuButton.tag == 1) ? 2 : 1
    }
}
