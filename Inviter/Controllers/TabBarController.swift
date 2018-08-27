//
//  TabBarController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/25/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//
import UIKit
import Foundation

class TabBarController: UITabBarController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabbarItems(tabIndex: 0, selectedImage: "Templates-Active", unSelectedImage: "Templates-INactive", Title: "Templates")
        setTabbarItems(tabIndex: 1, selectedImage: "MyVideos_Active", unSelectedImage: "MyVideos-INactive", Title: "My Videos")
        setTabbarItems(tabIndex: 2, selectedImage: "Settings_Active", unSelectedImage: "Settings_INactive", Title: "Settings")

    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        // - 40 is editable , the default value is 49 px, below lowers the tabbar and above increases the tab bar size
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 60

        self.tabBar.frame = tabFrame
    }
    
    func setTabbarItems(tabIndex:Int, selectedImage: String, unSelectedImage: String, Title: String)
    {
        let tabbarItem = (self.tabBar.items?[tabIndex])! as UITabBarItem
        tabbarItem.image = UIImage(named: unSelectedImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        tabbarItem.selectedImage = UIImage(named:selectedImage)?.withRenderingMode (UIImageRenderingMode.alwaysOriginal)
        tabbarItem.title = Title
//        tabbarItem.imageInsets = UIEdgeInsets(top: -5, left: 0, bottom:-15, right: 0)
//        tabbarItem.largeContentSizeImageInsets  = UIEdgeInsets(top: -5, left: 0, bottom:-10, right: 0)
    }
    
}
