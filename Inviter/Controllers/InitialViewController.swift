//
//  ViewController.swift
//  Inviter
//
//  Created by Manikanta Prakash Toram on 8/23/18.
//  Copyright © 2018 Manikanta Prakash Toram. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    func loadHomeVC()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarControllerID")
        self.present(vc!, animated: true, completion: {})
    }
    
    func loadLetsGoVC()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LetsGoViewControllerID")
        self.present(vc!, animated: true, completion: {})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (UserDefaults.standard.value(forKey: "userID") != nil)
        {
            loadHomeVC()
        }
        else if UserDefaults.standard.bool(forKey: "isLetsGoScreen")
        {
            loadLetsGoVC()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UserDefaults.standard.set(true, forKey: "isLetsGoScreen")
        UserDefaults.standard.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UIScrollViewDelegate Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)

    }

}

