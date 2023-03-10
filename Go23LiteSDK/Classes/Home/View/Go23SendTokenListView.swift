//
//  Go23SendTokenListView.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2022/12/7.
//

import UIKit
import Go23SDK

class Go23SendTokenListView: UIView {
    
    var tokenList: [Go23WalletTokenModel]?
    private var tokenIndex = 1

    
    var clickBlock: ((_ model: Go23WalletTokenModel)->())?
    
    var addBtnBlock:(()->())?
    
    var closeBlock:(()->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
          }
        initSubviews()
        
        getUserTokens()
        let header = Go23RefreshHeaderAnimator.init(frame: .zero)
        tableView.es.addPullToRefresh(animator: header) { [weak self] in
            self?.tokenIndex = 1
            self?.getUserTokens(isLoading: false)
    
        }
        
        tableView.es.addInfiniteScrolling {[weak self] in
            self?.tokenIndex += 1
            self?.getUserTokens(isLoading: false)
        }

         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        roundCorners([.topLeft,.topRight], radius: 12)
        
        backgroundColor = .white
        addSubview(titleLabel)
        addSubview(closeBtn)
        addSubview(tableView)
        
        addSubview(addBtn)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(32)
        }
        closeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-6)
            make.width.height.equalTo(44)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        addBtn.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(0)
             } else {
                 make.bottom.equalTo(0)
            }
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(52)
        }
        
    }
        
        
    @objc private func closeBtnClick() {
        self.closeBlock?()
        
    }
    
    @objc private func addBtnClick() {
        addBtnBlock?()
    }
        
    private lazy var closeBtn: UIButton = {
            let btn = UIButton(type: .custom)
            let imgv = UIImageView()
            imgv.image = Go23Helper.image(named: "close")
            btn.addSubview(imgv)
            imgv.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.height.equalTo(13)
                make.width.equalTo(13)
            }
            btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
            return btn
        }()
        
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a token to send"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
            return label
        }()
    
    private lazy var addBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.backgroundColor = UIColor.rdt_HexOfColor(hexString: "#00D6E1")
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SendTokenListCell.self, forCellReuseIdentifier: SendTokenListCell.reuseIdentifier())


        return tableView
    }()
    }
    

extension Go23SendTokenListView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tokenList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SendTokenListCell.reuseIdentifier(), for: indexPath) as? SendTokenListCell,let list = self.tokenList, indexPath.row < list.count
        else {
                return UITableViewCell()
            }
            
        if let model = self.tokenList?[indexPath.row] {
            cell.filled(cover: model.imageUrl, type: model.name, num: model.balance, money: model.balanceU)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SendTokenListCell.cellHeight

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let list = self.tokenList, indexPath.row < list.count {
            self.clickBlock?(list[indexPath.row])
        }
    }
}

class SendTokenListCell: UITableViewCell {
    static var cellHeight: CGFloat {
        return 60.0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
          }
        selectionStyle = .none
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func filled(cover: String, type: String, num: String, money: String) {
        iconImgv.kf.setImage(with: URL(string: cover))
        titleLabel.text = type
        numLabel.text = "\(num)"
        if let mon =  Double(money), mon == 0 {
            moneyLabel.text = "$0.00"
        } else {
            moneyLabel.text = "$\(money)"
        }
        
        
    }
    
    private func initSubviews() {
        contentView.backgroundColor = .white
        contentView.addSubview(iconImgv)
        contentView.addSubview(titleLabel)
        contentView.addSubview(numLabel)
        contentView.addSubview(moneyLabel)
        
        iconImgv.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImgv.snp.right).offset(12)
            make.top.equalTo(8)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        numLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.equalTo(8)
            make.height.equalTo(24)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(numLabel.snp.bottom).offset(0)
            make.trailing.equalTo(-20)
            make.height.equalTo(18)
        }
    }
    
    
    private lazy var iconImgv: UIImageView = {
        let imgv = UIImageView()
        
        return imgv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        return label
    }()
    
    private lazy var numLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#262626")
        label.textAlignment = .right
        return label
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.rdt_HexOfColor(hexString: "#8C8C8C")
        label.textAlignment = .right
        return label
    }()
}

extension Go23SendTokenListView {
    private func getUserTokens(isLoading: Bool = true) {
        guard let shared = Go23WalletSDK.shared
        else {
            return
        }
        
        if isLoading {
            Go23Loading.loading()
        }
        
        shared.getWalletTokenList(with: Go23WalletMangager.shared.address, chainId: Go23WalletMangager.shared.walletModel?.chainId ?? 0, pageSize: 20, pageNumber: self.tokenIndex) {  [weak self]list in
            if isLoading {
                Go23Loading.clear()
            }
            self?.tableView.es.stopPullToRefresh()
            self?.tableView.es.stopLoadingMore()
            if self?.tokenIndex ?? 1 > 1 {
                if let _ = self?.tokenList, let ll = list?.listModel {
                    self?.tokenList! += ll
                }
            } else {
                self?.tokenList?.removeAll()
                self?.tokenList = list?.listModel
            }
            self?.tableView.reloadData()
        }
    }
}

