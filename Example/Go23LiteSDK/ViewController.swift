//
//  ViewController.swift
//  Go23LiteSDK
//
//  Created by ming.lu on 02/03/2023.
//  Copyright (c) 2023 ming.lu. All rights reserved.
//

import UIKit
import Go23LiteSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .custom)
        btn.setTitle("Go23LiteSDK", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.black, for: .normal)
        btn.frame = CGRectMake(20, 100, 150, 40)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc private func btnClick() {
//        Go23LiteSDKMangager.shared.initialization(uniqueId: "feruiehg347097feif347ffggeiryer", email: "ming.lu@coins.ph", phone: ("",""))
        
        Go23LiteSDKMangager.shared.initialization(uniqueId: "ming.lu@coins.ph", email: "ming.lu@coins.ph", phone: ("", ""), iconImage: UIImage.init(named: "nickName"), nickName: "mig.eth")
        let vc = Go23HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

