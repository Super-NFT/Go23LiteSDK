//
//  HomeHeaderView.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2022/12/2.
//

import Foundation
import UIKit
import Kingfisher

protocol HomeTopViewDelegate: AnyObject {
    func chooseClick()
    func settingBtnClick()
    func backBtnDidClick()

}

protocol HomeHeaderViewDelegate: AnyObject {
    func receiveBtnClick()
    func sendBtnClick()
    func eyeBtnClick()
    
}

class HomeTopView: UIView {
    
    static var cellHight = 145.0
    weak var delegate: HomeTopViewDelegate?
    
    
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
        backgroundColor = UIColor.rdt_HexOfColor(hexString: "#F9F9F9")
        addSubview(backBtn)
        addSubview(rightBtn)
        addSubview(chooseV)
        addSubview(iconImgv)
        addSubview(emailLabel)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(44)
            make.left.equalTo(5)
            make.width.height.equalTo(44)
        }
        rightBtn.snp.makeConstraints { make in
            make.top.equalTo(44)
            make.trailing.equalTo(0)
            make.width.height.equalTo(44)
        }
        chooseV.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(rightBtn.snp.bottom).offset(10)
            make.height.equalTo(36)
            make.width.equalTo(120)
        }
        chooseV.isHidden = true
        iconImgv.snp.makeConstraints { make in
            make.centerY.equalTo(chooseV.snp.centerY)
            make.leading.equalTo(20)
            make.width.height.equalTo(28)
        }
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImgv.snp.right).offset(4)
            make.centerY.equalTo(iconImgv.snp.centerY)
        }
        emailLabel.isHidden = true
        
    }
    
    func filled(chainName: String) {
        var email = ""
        if let nickName = Go23LiteSDKMangager.shared.nickName, nickName.count > 0 {
            email = nickName
        } else {
            if Go23WalletMangager.shared.email.count > 0 {
                
                email = Go23WalletMangager.shared.email
            } else {
                email = Go23WalletMangager.shared.phone
            }
        }
        
        if let img = Go23LiteSDKMangager.shared.iconImage {
            iconImgv.image = img
        } else {
            iconImgv.backgroundColor = UIColor.rdt_HexOfColor(hexString: "#00D6E1")
            iconImgv.layer.cornerRadius = 14
        }
        
        var ee = email
        if email.count > 17 {
            ee = email.substring(to: 15) + "..."
        }
        
        let emailWidth = ScreenWidth-getRowWidth(desc: chainName)-20-52
        if getStringWidth(email, lineHeight:  16.0, font: UIFont.systemFont(ofSize: 14)) <= emailWidth {
            ee = email
        }
        emailLabel.isHidden = false
        emailLabel.text = ee

        chooseV.isHidden = false
        chooseV.snp.remakeConstraints() { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(rightBtn.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(getRowWidth(desc: chainName))
        }
        emailLabel.snp.remakeConstraints() { make in
            make.left.equalTo(iconImgv.snp.right).offset(4)
            make.centerY.equalTo(iconImgv.snp.centerY)
            make.width.equalTo(emailWidth)
        }

    }
    
    func getRowWidth(desc: String) -> CGFloat {
        return getStringWidth(desc, lineHeight:  16.0, font: UIFont.systemFont(ofSize: 12))  + 66.0
    }
    
    private func getStringWidth(_ content: String,
                                 lineHeight:CGFloat = 27.0,
                                 font: UIFont = UIFont.systemFont(ofSize: 12),
                                 wordWidth: CGFloat = (ScreenWidth - 40.0)) -> CGFloat {
        let paraph = NSMutableParagraphStyle()
        paraph.maximumLineHeight = lineHeight
        paraph.minimumLineHeight = lineHeight
        let attributes = [NSAttributedString.Key.paragraphStyle: paraph, NSAttributedString.Key.font: font] as [NSAttributedString.Key : Any]

        let rowHeight = (content.trimmingCharacters(in: .newlines) as NSString).boundingRect(with: CGSize(width: wordWidth, height: 0), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil).size.width
         return rowHeight
     }
    
    
    @objc private func settingBtnDidClick() {
        self.delegate?.settingBtnClick()
    }
    
    @objc private func backBtnDidClick() {
        self.delegate?.backBtnDidClick()
    }
    
    private lazy var rightBtn: UIButton = {
        let rightBtn = UIButton()
        rightBtn.frame = CGRectMake(0, 0, 44, 44)
        let imgv = UIImageView()
        rightBtn.addSubview(imgv)
        imgv.image = Go23Helper.image(named: "rightDot")
        imgv.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        rightBtn.addTarget(self, action: #selector(settingBtnDidClick), for: .touchUpInside)
        return rightBtn
    }()
    
    private lazy var backBtn: UIButton = {
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
        return backBtn
    }()

    private lazy var iconImgv: UIImageView = {
        let imgv = UIImageView()
        
        return imgv
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        return label
    }()

    lazy var chooseV: ChooseView = {
        let view = ChooseView()
        view.clickBlock = { [weak self] in
            self?.delegate?.chooseClick()
        }
        return view
    }()
    
     
}



class HomeHeaderView: UIView {
    
    static var cellHight = 280.0
    private var email = ""
    weak var delegate: HomeHeaderViewDelegate?
    
    var token = ""
    var imageViewFrame: CGRect = CGRect.zero
    private var money = ""
    private var symbol = ""
    private var balanceU = ""
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
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageViewFrame = bounds
    }
    
    private func initSubviews() {
        backgroundColor = UIColor.rdt_HexOfColor(hexString: "#F9F9F9")
        addSubview(contentV)
        contentV.addSubview(tokenLabel)
        contentV.addSubview(tokenControl)
        contentV.addSubview(numLabel)
        contentV.addSubview(eyeBtn)
        contentV.addSubview(titleLabel)
        contentV.addSubview(receiveBtn)
        contentV.addSubview(sendBtn)
        contentV.addSubview(lineV)
        
        contentV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tokenLabel.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(134)
        }
        tokenControl.snp.makeConstraints { make in
            make.center.equalTo(tokenLabel.snp.center)
            make.height.equalTo(35)
            make.width.equalTo(134)
        }

        numLabel.snp.makeConstraints { make in
            make.top.equalTo(tokenLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(36)
        }
        
        eyeBtn.snp.makeConstraints { make in
            make.centerY.equalTo(numLabel.snp.centerY).offset(-10)
            make.left.equalTo(numLabel.snp.right).offset(-10)
            make.width.height.equalTo(44)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }

        receiveBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.width.equalTo(82.5)
            make.height.equalTo(77)
            make.left.equalTo(numLabel.snp.centerX).offset(-100)
        }

        sendBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.width.equalTo(82.5)
            make.height.equalTo(77)
            make.right.equalTo(numLabel.snp.centerX).offset(100)
        }

        lineV.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.trailing.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    func filled(money: String, symbol: String, balanceU: String, address: String) {
        self.money = money
        self.symbol = symbol
        self.balanceU = balanceU
        var mon = money
        var bal = balanceU
        if let ss = Double(money) {
            if ss <= 0 {
                mon = "0.00"
            }
        } else {
            mon = "0.00"
        }
        if Float(mon) ?? 0.0 > 0 {
            numLabel.text = mon + " " + symbol
        } else {
            numLabel.text = "0.00" + " " + symbol
        }
        
        if let bb = Double(balanceU){
            if bb <= 0 {
                bal = "0.00"
            }
        } else {
            bal = "0.00"
        }
        titleLabel.text = "$"+bal
        
        self.token = address
        let str = String.getSecretString(token: token)
        
        let attri = NSMutableAttributedString()
        attri.add(text: str) { attr in
            attr.font(14)
            attr.color(UIColor.rdt_HexOfColor(hexString: "#8C8C8C"))
        }.add(text: " ") { att in
            
        }
        if UserDefaults.standard.bool(forKey: kEyeBtnKey) {
            eyeBtn.setImage(Go23Helper.image(named: "eyeClose"), for: .normal)
            numLabel.text = "****"
            titleLabel.text = "****"
        } else {
            eyeBtn.setImage(Go23Helper.image(named: "eyeOpen"), for: .normal)
        }
        
        attri.addBundleImage("copy", CGRectMake(0, 0, 12, 12))
        tokenLabel.attributedText = attri
        tokenLabel.backgroundColor = UIColor.rdt_HexOfColor(hexString: "#EBF5F5")
        eyeBtn.isHidden = false

    }
    
    @objc private func controlClick() {
        UIPasteboard.general.string = self.token
        let toast = Go23Toast.init(frame: .zero)
        toast.show("Copied!", after: 1)
    }
    
    @objc private func receiveBtnClick() {
        self.delegate?.receiveBtnClick()
    }
    
    @objc private func sendBtnClick() {
        self.delegate?.sendBtnClick()
    }
    
    @objc private func eyeBtnClick() {
        if UserDefaults.standard.bool(forKey: kEyeBtnKey) {
            eyeBtn.setImage(Go23Helper.image(named: "eyeOpen"), for: .normal)
            UserDefaults.standard.set(false, forKey: kEyeBtnKey)
            var mon = money
            var bal = balanceU
            if let ss = Double(money) {
                if ss <= 0 {
                    mon = "0.00"
                }
            } else {
                mon = "0.00"
            }
            numLabel.text = mon + " " + symbol
            if let bb = Double(balanceU){
                if bb <= 0 {
                    bal = "0.00"
                }
            } else {
                bal = "0.00"
            }
            titleLabel.text = "$"+bal
        } else {
            eyeBtn.setImage(Go23Helper.image(named: "eyeClose"), for: .normal)
            UserDefaults.standard.set(true, forKey: kEyeBtnKey)
            numLabel.text = "****"
            titleLabel.text = "****"
        }
        self.delegate?.eyeBtnClick()
    }
    
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        
        var contentFrame = imageViewFrame
        contentFrame.size.height -= contentOffsetY
        contentFrame.origin.y = contentOffsetY
//        print("contentOffet ========== \(contentOffsetY)")
        self.contentV.frame = contentFrame
    }
    
    
    private lazy var contentV: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.cornerRadius = 17.5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    private lazy var tokenControl: UIControl = {
        let control = UIControl()
        control.addTarget(self, action: #selector(controlClick), for: .touchUpInside)
        return control
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#8C8C8C")
        return label
    }()
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.text = "0.00"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var eyeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(Go23Helper.image(named: "eyeOpen"), for: .normal)
        btn.isHidden = true
        btn.addTarget(self, action: #selector(eyeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var receiveBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(Go23Helper.image(named: "scan"), for: .normal)
        btn.setTitle("Receive", for: .normal)
        btn.setTitleColor(UIColor.rdt_HexOfColor(hexString: "#8C8C8C"), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layoutButtonEdgeInsets(style: .imageTop, margin: 20.0)
        btn.addTarget(self, action: #selector(receiveBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Send", for: .normal)
        btn.setImage(Go23Helper.image(named: "send"), for: .normal)
        btn.setTitleColor(UIColor.rdt_HexOfColor(hexString: "#8C8C8C"), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.layoutButtonEdgeInsets(style: .imageTop, margin: 20.0)
        btn.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var lineV: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rdt_HexOfColor(hexString: "#F5F5F5")
        return view
    }()
    
}


class ChooseView: UIView {
    
    public var clickBlock: (()->())?
    
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
        
        addSubview(iconImgv)
        addSubview(titleLabel)
        addSubview(control)
        
        iconImgv.snp.makeConstraints { make in
            make.leading.equalTo(10)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImgv.snp.right).offset(0)
            make.trailing.equalTo(-10)
        }
        
        control.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func filled(title: String, img: String) {
        
        iconImgv.kf.setImage(with: URL(string: img))
        let attri = NSMutableAttributedString()
        attri.add(text: " ") { attr in
            
        }
        attri.add(text: title) { attr in
            attr.font(12)
            attr.color(UIColor.rdt_HexOfColor(hexString: "#262626"))
        }
        attri.add(text: " ") { attr in
            
        }
        attri.addBundleImage("arrowDown", CGRectMake(0, 0, 12, 12))
        titleLabel.attributedText = attri
        
        layer.masksToBounds = true
        layer.cornerRadius = 20
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.rdt_HexOfColor(hexString: "#D9D9D9").cgColor
    }
    
    
    @objc private func controlClick() {
        self.clickBlock?()
    }
    
    private lazy var iconImgv: UIImageView = {
        let imgv = UIImageView()
        
        return imgv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var downImgv: UIImageView = {
        let imgv = UIImageView()
        imgv.image = Go23Helper.image(named: "arrowDown")
        return imgv
    }()
    
    private lazy var control: UIControl = {
        let control = UIControl()
        control.addTarget(self, action: #selector(controlClick), for: .touchUpInside)
        return control
    }()
    
}
