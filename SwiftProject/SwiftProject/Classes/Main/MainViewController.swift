//
//  MainViewController.swift
//  SwiftProject
//
//  Created by Jiabin wang on 2018/11/6.
//  Copyright © 2018年 Jiabin wang. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(HomeTableViewController(), title: "首页", imageName: "")
        addChild(DiscoverTableViewController(), title: "广场", imageName: "")
        addChild(MessageTableViewController(), title: "消息", imageName: "")
        addChild(ProfileTableViewController(), title: "我", imageName: "")

    }
    
    private func addChild(_ childController: UIViewController, title:String, imageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        
        let nav = UINavigationController()
        nav.addChild(childController)
        addChild(nav)
        
    }

}
