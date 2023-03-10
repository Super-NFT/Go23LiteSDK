//
//  Go23AddCustomTokenViewController.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2022/12/6.
//

import UIKit
import Go23SDK

class Go23AddCustomTokenViewController: UIViewController {

    var chainId = 0
    var tokenInfo: Go23ChainTokenInfoModel?
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
          }
        setNav()
        initSubviews()                
    }
    
    private func setNav() {

        let backBtn = UIButton()
        backBtn.frame = CGRectMake(0, 0, 44, 44)
        let imgv = UIImageView()
        backBtn.addSubview(imgv)
        imgv.image = Go23Helper.image(named: "back")
        imgv.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        backBtn.addTarget(self, action: #selector(backBtnDidClick), for: .touchUpInside)
        
        if self.navgationBar == nil {
            addBarView()
            navgationBar?.title = "Add Custom Token"
            navgationBar?.attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)] as [NSAttributedString.Key : Any]
            navgationBar?.leftBarItem = HBarItem.init(customView: backBtn)
        }
    }
    
    @objc private func backBtnDidClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func initSubviews() {
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(tipsImgv)
        topView.addSubview(tipsLabel)
        view.addSubview(tokenLabel)
        view.addSubview(tokenTxtFiled)
        view.addSubview(symbolLabel)
        view.addSubview(symbolTxtFiled)
        view.addSubview(precisionLabel)
        view.addSubview(precisionTxtFiled)
        view.addSubview(confirmBtn)
        
        symbolLabel.isHidden = true
        symbolTxtFiled.isHidden = true
        precisionLabel.isHidden = true
        precisionTxtFiled.isHidden = true
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(navgationBar!.snp.bottom).offset(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(63)
        }
        tipsImgv.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(tipsImgv.snp.right).offset(20)
            make.right.equalTo(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tokenLabel.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(topView.snp.bottom).offset(24)
            make.height.equalTo(22)
        }
        
        tokenTxtFiled.snp.makeConstraints { make in
            make.top.equalTo(tokenLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(46)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(tokenTxtFiled.snp.bottom).offset(12)
            make.leading.equalTo(20)
            make.height.equalTo(22)
        }
        
        symbolTxtFiled.snp.makeConstraints { make in
            make.top.equalTo(symbolLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(46)
        }
        
        precisionLabel.snp.makeConstraints { make in
            make.top.equalTo(symbolTxtFiled.snp.bottom).offset(22)
            make.leading.equalTo(20)
            make.height.equalTo(22)
        }
        
        precisionTxtFiled.snp.makeConstraints { make in
            make.top.equalTo(precisionLabel.snp.bottom).offset(8)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(46)
        }
        
        confirmBtn.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                 make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
             } else {
                 make.bottom.equalTo(self.view.snp.bottom)
            }
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(52)
        }
    }
    
    @objc private func confirmBtnClick() {
        addToken()
    }
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.rdt_HexOfColor(hexString: "#D9D9D9").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var tipsImgv: UIImageView = {
        let imgv = UIImageView()
        imgv.image = Go23Helper.image(named: "tips")
        return imgv
    }()
    
    private lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "Anyone can create a fake token. Make sure you trust a token before you import it."
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#595959")
        return label
    }()
    
    private lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.text = "Token Contract Address"
        return label
    }()
    
    private lazy var tokenTxtFiled: UITextField = {
        let textfield = UITextField()
        let textplace = "Enter Contract Address"
        let placeholder = NSMutableAttributedString()
        placeholder.add(text: textplace) { (attributes) in
            attributes.font(12)
        }
        textfield.attributedPlaceholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.tintColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        textfield.leftViewMode = .always
        textfield.leftView = UIView.init(frame: CGRectMake(0, 0, 15, 0))
        textfield.clearButtonMode = .always
        textfield.layer.cornerRadius = 8
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1
        textfield.addTarget(self, action: #selector(textDidChange(_ :)), for: .editingChanged)
        textfield.layer.borderColor = UIColor.rdt_HexOfColor(hexString: "#D9D9D9").cgColor
        return textfield
    }()
    
    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.text = "Token Symbol"
        return label
    }()
    
    private lazy var symbolTxtFiled: UITextField = {
        let textfield = UITextField()
        textfield.isUserInteractionEnabled = false
        let textplace = "Enter Token Symbol"
        let placeholder = NSMutableAttributedString()
        placeholder.add(text: textplace) { (attributes) in
            attributes.font(12)
        }
        textfield.attributedPlaceholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.tintColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        textfield.leftViewMode = .always
        textfield.leftView = UIView.init(frame: CGRectMake(0, 0, 15, 0))
        textfield.layer.cornerRadius = 8
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.rdt_HexOfColor(hexString: "#D9D9D9").cgColor
        return textfield
    }()
    
    private lazy var precisionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.text = "Token Decimal"
        return label
    }()
    
    private lazy var precisionTxtFiled: UITextField = {
        let textfield = UITextField()
        textfield.isUserInteractionEnabled = false
        let textplace = "Enter Token of Precision"
        let placeholder = NSMutableAttributedString()
        placeholder.add(text: textplace) { (attributes) in
            attributes.font(12)
        }
        textfield.attributedPlaceholder = placeholder
        textfield.font = UIFont.systemFont(ofSize: 14)
        textfield.tintColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        textfield.leftViewMode = .always
        textfield.leftView = UIView.init(frame: CGRectMake(0, 0, 15, 0))
        textfield.layer.cornerRadius = 8
        textfield.layer.masksToBounds = true
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.rdt_HexOfColor(hexString: "#D9D9D9").cgColor
        return textfield
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

extension Go23AddCustomTokenViewController {
    
    //textfield
    @objc func textDidChange(_ textField:UITextField) {
        print("event:\(textField.text)")
        if let txt = textField.text, txt.count > 30 {
            checkToken(with: self.chainId, address: txt)
        } else {
            symbolLabel.isHidden = true
            symbolTxtFiled.isHidden = true
            precisionLabel.isHidden = true
            precisionTxtFiled.isHidden = true
        }
    }
    
    func checkToken(with chainId: Int, address: String) {
        print("checkToken")
        guard let shared = Go23WalletSDK.shared else {
            return
        }
        
        Go23Loading.loading()
        shared.checkToken(with: address, chainId: chainId) { [weak self] model in
            Go23Loading.clear()
            self?.tokenInfo = model
            self?.symbolTxtFiled.text = model?.symbol ?? ""
            if let num = model?.decimal {
                self?.precisionTxtFiled.text = "\(num)"
            }
            guard let _ = model else {return}
            self?.symbolLabel.isHidden = false
            self?.symbolTxtFiled.isHidden = false
            self?.precisionLabel.isHidden = false
            self?.precisionTxtFiled.isHidden = false
        }
    }
    
    func addToken() {
        guard let shared = Go23WalletSDK.shared
        else {
            return
        }
        guard let model = self.tokenInfo else {
            return
        }
        Go23Loading.loading()
        shared.addToken(with: model.chainId, walletAddress: Go23WalletMangager.shared.address, contractAddress: model.contractAddress) {[weak self](data) in
            Go23Loading.clear()
            NotificationCenter.default.post(name: NSNotification.Name(kRefreshWalletData),
                                            object: nil,
                                            userInfo: nil)
            print("addToken")
            
            let totast = Go23Toast.init(frame: .zero)
            totast.show("Add success!", after: 1)
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
}
