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
        btn.frame = CGRectMake((UIScreen.main.bounds.size.width - 150)/2.0, (UIScreen.main.bounds.size.height - 40)/2.0, 150, 40)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc private func btnClick() {
        
        var email = ""
        if let kEmail = UserDefaults.standard.string(forKey: kEmailPrivateKey), kEmail.count > 0 {
            email = kEmail
        }
        
        var phone = ""
        var areaCode = ""
        if let kSMS = UserDefaults.standard.string(forKey: kPhonePrivateKey), kSMS.count > 0 , kSMS.components(separatedBy: " ").count == 2 {
            phone = kSMS.components(separatedBy: " ")[1]
            areaCode = kSMS.components(separatedBy: " ")[0]
        }
        
        popSettingEmail()
        
        if email.count == 0 && phone.count == 0 {
            return
        }
        
        
//        Go23LiteSDKMangager.shared.initialization(uniqueId: "feruiehg347097feif347ffggeiryer", email: "ming.lu@coins.ph", phone: ("",""))
        
        //This value is the unique identifier of the wallet when it is registered, and it is determined by the third-party access itself
        //demo use the email for uniqueId
        Go23LiteSDKMangager.shared.initialization(uniqueId: email, email: email, phone: (areaCode, phone), iconImage: UIImage.init(named: "nickName"), nickName: "mig.bulid.your.eth.dream")
        let vc = Go23HomeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func popSettingEmail() {
        
        if let kEmail = UserDefaults.standard.string(forKey: kEmailPrivateKey), kEmail.count > 0 {
            return
        }
        
        if  let kSMS = UserDefaults.standard.string(forKey: kPhonePrivateKey), kSMS.count > 0 {
            return
        }
        
        let alert = Go23SettingAccountView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight-120))
        let ovc = OverlayController(view: alert)
        ovc.maskStyle = .black(opacity: 0.4)
        ovc.layoutPosition = .bottom
        ovc.presentationStyle = .fromToBottom
        ovc.isDismissOnMaskTouched = false
        ovc.isPanGestureEnabled = true
        alert.confirmBlock = {[weak self] in
            if let view = self?.view {
                Go23Loading.loading()
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self?.btnClick()
                    view.dissmiss(overlay: .last)
                    Go23Loading.clear()
                }
            }
        }
        alert.closeBlock = { [weak self] in
            if let view = self?.view {
                view.dissmiss(overlay: .last)
            }
        }
        self.view.present(overlay: ovc)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

