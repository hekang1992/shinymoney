//
//  SM_AccountVC.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/8.
//

import UIKit
import NNModule_swift
class SM_AccountVC: UIViewController {
    let titleArr : [String] = ["Bills","My Payment Account","Loan Service Terms","Privace Policy","Contact Us","Loan Provider Info","Account Managment"]
    let iconNameArr : [String] = ["mine_LoanRepayment","mine_ReceivingAccount","mine_LoanAgreement","mine_PrivacyAgreement","mine_ContactUs","mine_AboutUs","mine_AccountManagement"]
    var indexPathsToAnimate: [IndexPath] = []
    var nickNameLabel : UILabel!
    var headphonesBtn : UIButton!
    var currentAnimateCellIndex = 0
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SM_AccountCell", bundle: nil), forCellReuseIdentifier: "SM_AccountCell")
         if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
        }
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "856CEB")
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUI), name: NSNotification.Name(rawValue: "SMLOGOUT"), object: nil)

        self.buildUI()
    }
    
    @objc func refreshUI(){
        self.nickNameLabel.text = "Not yet logged in"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SMUserModel.getSessionId()?.count ?? 0 > 0 {
            self.nickNameLabel.text = SMUserModel.getUser()?.theminto
        }else{
            self.nickNameLabel.text = "Not yet logged in"
        }
    }
    
    func buildUI(){
        let mineAppIcon = UIImageView()
        mineAppIcon.image = UIImage(named: "mine_appIcon")
        self.view.addSubview(mineAppIcon)
        mineAppIcon.mas_makeConstraints { make in
            make?.left.offset()(20)
            make?.top.equalTo()(SM_ShareFunction.getStatusBarHeight() + 50)
            make?.width.equalTo()(114)
            make?.height.equalTo()(111)
        }
        
        self.headphonesBtn = UIButton(type: .custom)
        self.headphonesBtn.addTarget(self, action: #selector(kfAction), for: .touchUpInside)
        self.headphonesBtn.setImage(UIImage(named: "headphones"), for: .normal)
        self.headphonesBtn.setTitle("", for: .normal)
        self.view.addSubview(self.headphonesBtn)
        self.headphonesBtn.mas_makeConstraints { make in
            make?.right.offset()(-24)
            make?.top.offset()(SM_ShareFunction.getStatusBarHeight() + 13)
            make?.width.equalTo()(44)
            make?.height.equalTo()(44)
        }
        
        let rightDecorateIcon = UIImageView()
        rightDecorateIcon.image = UIImage(named: "mine_ decorate")
        self.view.addSubview(rightDecorateIcon)
        rightDecorateIcon.mas_makeConstraints { make in
            make?.top.offset()(SM_ShareFunction.getStatusBarHeight() + 56)
            make?.right.offset()(0)
        }
        
        self.nickNameLabel = UILabel()
        if SMUserModel.getSessionId()?.count ?? 0 > 0 {
            self.nickNameLabel.text = SMUserModel.getUser()?.theminto
        }else{
            self.nickNameLabel.text = "Not yet logged in"
        }
        self.nickNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.nickNameLabel.textColor = UIColor.white
        self.view.addSubview(self.nickNameLabel)
        self.nickNameLabel.mas_makeConstraints { make in
            make?.left.offset()(28)
            make?.top.equalTo()(mineAppIcon.mas_bottom)?.offset()(12)
        }
        
        self.addIndexPathsToAnimate()
        
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.nickNameLabel.mas_bottom)?.offset()(35)
            make?.bottom.offset()(-110)
        }
    }
    
    func addIndexPathsToAnimate(){
        self.currentAnimateCellIndex = 0
        self.indexPathsToAnimate.removeAll()
        self.tableView.reloadData()
        for row in 0..<self.titleArr.count {
            self.indexPathsToAnimate.append(IndexPath(row: row, section: 0))
        }
        let indexPath = IndexPath(row: 0, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.alpha = 0
        } else {
                
        }
    }
    
    func performNextAnimation() {
        guard let indexPath = self.indexPathsToAnimate.first else {
            return
        }
        tableView.reloadRows(at: [indexPath], with: .right)
        self.indexPathsToAnimate.removeFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.currentAnimateCellIndex = self.currentAnimateCellIndex + 1
            self.performNextAnimation()
        }
    }
    
    @objc func kfAction(){
        URLRouter.default.openRoute("https://omdublending.com/bowedWhistled")
    }
}

extension SM_AccountVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SM_AccountCell = tableView.dequeueReusableCell(withIdentifier: "SM_AccountCell", for: indexPath) as! SM_AccountCell
        cell.titleStrLabel.text = self.titleArr[indexPath.row]
        cell.iconImageView.image = UIImage(named: self.iconNameArr[indexPath.row])
        if indexPath.row > self.currentAnimateCellIndex {
            cell.contentView.alpha = 0
        }else{
            cell.contentView.alpha = 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if SMUserModel.checkIsLogin() == false {
                return
            }
            let billsVC : SM_BillVC = SM_BillVC()
            billsVC.ifFromAccount = true
            self.navigationController?.pushViewController(billsVC, animated: true)
        }else if indexPath.row == 1 {
            if SMUserModel.checkIsLogin() == false {
                return
            }
            URLRouter.default.openRoute("https://omdublending.com/horrifiedParrots")
        }else if indexPath.row == 2 {
            URLRouter.default.openRoute("https://omdublending.com/forgotSuddenly")
        }else if indexPath.row == 3 {
            URLRouter.default.openRoute("https://omdublending.com/fingerStartled")
        }else if indexPath.row == 4 {
            URLRouter.default.openRoute("https://omdublending.com/bowedWhistled")
        }else if indexPath.row == 5 {
            let vc : SM_LoanProviderInfoViewController = SM_LoanProviderInfoViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 6 {
            if SMUserModel.checkIsLogin() == false {
                return
            }
            let vc : SM_AccountManagementViewController = SM_AccountManagementViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
