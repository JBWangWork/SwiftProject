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
        // 添加所有控制器
        addChildViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 添加加号按钮
        setupComposeBtn()
    }
    
    @objc func composeBtnClicked() {
        print(#function)
    }
    
    // MARK: - 添加加号按钮
    func setupComposeBtn() {
        let width = UIScreen.main.bounds.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: width * 2, y: 0, width: width, height: 49)
        composeBtn.frame = rect
        tabBar.addSubview(composeBtn)
    }
    // MARK: - 添加所有控制器
    private func addChildViewController() {
        let path = Bundle.main.path(forResource: "MainVCSettings", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        do {
            let jsonData = try Data(contentsOf: url)
            let dicArr:Any = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
            let jsonArr = dicArr as! NSArray
            
            for dict in jsonArr as! [[String:String]] {
                addChild(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
            }
        } catch {
            print(error)
            addChild("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChild("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            addChild("NullViewController", title: "", imageName: "")
            addChild("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
            addChild("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
    }
    
    private func addChild(_ childController: String, title:String, imageName:String) {
        // 动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转换为类
        let cls:AnyClass? = NSClassFromString(ns + "." + childController)
        // 通过类名创建类对象并设置相应数据
        let vcCls = cls as! UIViewController.Type
        let vc = vcCls.init()
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_hover")
        vc.title = title

        let nav = UINavigationController()
        nav.addChild(vc)
        addChild(nav)
    }
    
    private var composeBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControl.State.highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControl.State.highlighted)
        btn.addTarget(self, action: #selector(composeBtnClicked), for: UIControl.Event.touchUpInside)
        return btn
    }()

}
