//
//  SM_BillVC.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/8.
//

import UIKit
import NNModule_swift
class SM_BillVC: UIViewController {
    var ifFromAccount : Bool = false
    var billPostbox : UIImageView!
    var choiceBgIcon : UIImageView!
    var currentTypeLabel : UILabel!
    var arrowIcon : UIImageView!
    var ifShowTypeList : Bool = false
    var chooseTypeListView : SM_BillChooseTypeListView!
    var orderType : String = "4"
    var orderModel : SMOrderModel?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "SM_BillStyle01Cell", bundle: nil), forCellReuseIdentifier: "SM_BillStyle01Cell")
         if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "F5D8F5")
        self.buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SMUserModel.getSessionId()?.count == 0 {
            
        }else{
            self.getOrderList()
        }
    }
    
    func getOrderList(){
        if SMUserModel.getSessionId()?.count == 0 {
            return
        }
        SM_HomeViewModel.getOrderList(known: self.orderType) { dataModel in
            if dataModel.onsinging == 0 {
                self.orderModel = SMOrderModel(jsondata: dataModel.ended!)
                self.tableView.reloadData()
            }
        }
    }
    
    func buildUI(){
        self.billPostbox = UIImageView()
        self.billPostbox.image = UIImage(named: "billPostbox")
        self.view.addSubview(self.billPostbox)
        self.billPostbox.mas_makeConstraints { make in
            make?.height.equalTo()(screenHeight - 24)
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.equalTo()(self.view)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Bills"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { make in
            make?.top.offset()(60)
            make?.centerX.equalTo()(self.view)
        }
        
        self.choiceBgIcon = UIImageView()
        self.choiceBgIcon.image = UIImage(named: "billChoiceBg")
        self.view.addSubview(self.choiceBgIcon)
        self.choiceBgIcon.mas_makeConstraints { make in
            make?.top.equalTo()(self.billPostbox.mas_top)?.offset()(124*((screenHeight - 24)/812))
            make?.left.offset()(40)
            make?.right.offset()(-40)
            make?.height.equalTo()((screenWidth - 80)*110/578)
        }
        self.choiceBgIcon.isUserInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseTypeAction))
        self.choiceBgIcon.addGestureRecognizer(tap)
        
        arrowIcon = UIImageView()
        arrowIcon.image = UIImage(named: "billDownArrow")
        self.view.addSubview(arrowIcon)
        arrowIcon.mas_makeConstraints { make in
            make?.right.equalTo()(self.choiceBgIcon.mas_right)?.offset()(-50)
            make?.centerY.equalTo()(self.choiceBgIcon)
        }
        
        if self.ifFromAccount == true {
            let backBtn = UIButton(type: .custom)
            backBtn.setImage(UIImage(named: "H5Back"), for: .normal)
            backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            self.view.addSubview(backBtn)
            backBtn.mas_makeConstraints { make in
                make?.left.offset()(24);
                make?.centerY.equalTo()(titleLabel);
                make?.width.equalTo()(50);
                make?.height.equalTo()(50);
            }
        }
        
        self.currentTypeLabel = UILabel()
        self.currentTypeLabel.text = "All"
        self.currentTypeLabel.font = UIFont(name: "SFProDisplay-Black", size: 16)
        self.currentTypeLabel.textColor = UIColor(hex: "4D2717")
        self.view.addSubview(self.currentTypeLabel)
        self.currentTypeLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.choiceBgIcon)
            make?.centerY.equalTo()(self.choiceBgIcon)
        }
        let attributes: [NSAttributedString.Key: Any] = [
                         .strokeColor: UIColor.white,
                         .foregroundColor: UIColor.black,
                         .strokeWidth: -6.0
     ]
        let attributedString = NSAttributedString(string: currentTypeLabel.text!, attributes: attributes)
        self.currentTypeLabel.attributedText = attributedString
        
        let postPlaceImageView = UIImageView()
        postPlaceImageView.image = UIImage(named: "billPollingPlace")
        self.view.addSubview(postPlaceImageView)
        postPlaceImageView.mas_makeConstraints { make in
            make?.top.equalTo()(self.choiceBgIcon.mas_bottom)?.offset()(7)
            make?.left.offset()(40)
            make?.right.offset()(-40)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { make in
            make?.left.offset()(44)
            make?.right.offset()(-44)
            make?.top.equalTo()(postPlaceImageView.mas_centerY)
            make?.bottom.equalTo()(self.view)?.offset()(-108)
        }
    }
    
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func chooseTypeAction(){
        if self.ifShowTypeList == false {
            self.ifShowTypeList = true
            arrowIcon.image = UIImage(named: "billUpArrow")
            self.chooseTypeListView = SM_BillChooseTypeListView(frame: CGRectZero)
            self.view.addSubview(self.chooseTypeListView)
            self.chooseTypeListView.mas_makeConstraints { make in
                make?.top.equalTo()(self.choiceBgIcon.mas_bottom)?.offset()(-5)
                make?.centerX.equalTo()(self.view)
                make?.width.equalTo()(250)
                make?.height.equalTo()(223)
            }
            self.chooseTypeListView.chooseTypeBlock = {[weak self] typeStr,typeNameStr in
                self?.currentTypeLabel.text = typeNameStr
                self?.orderType = typeStr
                self?.ifShowTypeList = false
                self?.arrowIcon.image = UIImage(named: "billDownArrow")
                self?.getOrderList()
            }
        }else{
            self.ifShowTypeList = false
            self.chooseTypeListView.removeFromSuperview()
            arrowIcon.image = UIImage(named: "billDownArrow")
        }
    }
}

extension SM_BillVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orderModel?.theyatArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : SMOrderListModel = self.orderModel!.theyatArr[indexPath.section]
        let cell : SM_BillStyle01Cell =  tableView.dequeueReusableCell(withIdentifier: "SM_BillStyle01Cell") as! SM_BillStyle01Cell
        cell.configData(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model : SMOrderListModel = self.orderModel!.theyatArr[indexPath.section]
        URLRouter.default.openRoute(model.merry ?? "")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model : SMOrderListModel = self.orderModel!.theyatArr[indexPath.section]
        if model.loyalty == "174" || model.loyalty == "180" || (model.loyalty == "151" && Int(model.hissingClosed ?? "0") ?? 0 > 0){
            return 188
        }else{
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}

