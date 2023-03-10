//
//  Go23PwdSuccessView.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2022/12/7.
//

import UIKit

class Go23PwdSuccessView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
          }
        initSubviews()
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        roundCorners([.topLeft,.topRight], radius: 12)
        
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(closeBtn)
        addSubview(imgv)
        addSubview(tipLabel)
        addSubview(confirmBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        closeBtn.snp.makeConstraints { make in
            make.leading.equalTo(0)
            make.width.height.equalTo(44)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        imgv.snp.makeConstraints { make in
            make.top.equalTo(135)
            make.width.equalTo(58)
            make.height.equalTo(58)
            make.centerX.equalToSuperview()
        }
        
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(imgv.snp.bottom).offset(15)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
        
        confirmBtn.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                 make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
             } else {
                 make.bottom.equalTo(0)
            }
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(46)
        }
    }
    
    @objc private func confirmBtnClick() {
        UIApplication.shared.keyWindow?.dissmiss(overlay: .all)
        NotificationCenter.default.post(name: NSNotification.Name(kRefreshWalletData),
                                        object: nil,
                                        userInfo: nil)
    }
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton(type: .custom)
        let imgv = UIImageView()
        imgv.image = Go23Helper.image(named: "back")
        btn.addSubview(imgv)
        imgv.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Set Pincode"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imgv: UIImageView = {
        let imgv = UIImageView()
        imgv.image = Go23Helper.image(named: "success")
        return imgv
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "Successful"
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var confirmBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = UIColor.rdt_HexOfColor(hexString: "#00D6E1")
        btn.setTitle("Confirm", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(confirmBtnClick), for: .touchUpInside)
        return btn
    }()

}
