//
//  SM_HomeVC.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/8.
//

import UIKit
import NNModule_swift
import MessageUI
class SM_HomeVC: UIViewController{
    var myScrollview : UIScrollView!
    var myScrollContentView : UIView!
    var headphonesBtn : UIButton!
    var topIcon : UIImageView!
    var middleIcon : UIImageView!
    var downIcon : UIImageView!
    var leftIcon : UIImageView!
    var rightIcon : UIImageView!
    var applyBtn : UIButton!
    var firstTitleLabel : UILabel!
    var loanAmountLabel : UILabel!
    var rateLabel : UILabel!
    var rateTitleLabel : UILabel!
    var termLabel : UILabel!
    var termTitleLabel : UILabel!
    var mainModel : SMHomeInfoModel!
    var hasUploadedInfo : Bool = false
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        NotificationCenter.default.addObserver(self, selector: #selector(uploadDeviceInfo), name: NSNotification.Name(rawValue: "SMUPLOADDEVICEINFO"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if hasUploadedInfo == false {
            SMHomeUploadDeviceInfoManager().uploadDeviceInfoToServe()
            hasUploadedInfo = true
        }
        
        self.getHomeInfomationDataList()
    }
    
   @objc func uploadDeviceInfo(){
        SMHomeUploadDeviceInfoManager().uploadDeviceInfoToServe()
    }
    
    func buildUI(){
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "homeBg")
        self.view.addSubview(bgImageView)
        bgImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.top.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
        }
      
        self.myScrollview = UIScrollView(frame: self.view.bounds)
        self.myScrollview.showsVerticalScrollIndicator = false
        self.myScrollview.showsHorizontalScrollIndicator = false
        self.myScrollview.backgroundColor = UIColor.clear
        self.myScrollview.contentInsetAdjustmentBehavior = .never
        self.view.addSubview(self.myScrollview)
        
        self.myScrollContentView = UIView()
        self.myScrollContentView.backgroundColor = UIColor.clear
        self.myScrollview.addSubview(self.myScrollContentView)
        self.myScrollContentView.mas_makeConstraints { make in
            make?.top.offset()(0)
            make?.bottom.offset()(0)
            make?.width.equalTo()(screenWidth)
            make?.left.offset()(0)
        }
        
        self.headphonesBtn = UIButton(type: .custom)
        self.headphonesBtn.addTarget(self, action: #selector(kfAction), for: .touchUpInside)
        self.headphonesBtn.setImage(UIImage(named: "headphones"), for: .normal)
        self.headphonesBtn.setTitle("", for: .normal)
        self.view.addSubview(self.headphonesBtn)
        self.headphonesBtn.mas_makeConstraints { make in
            make?.right.offset()(-24)
            make?.top.offset()(SM_ShareFunction.getStatusBarHeight() + 16)
            make?.width.equalTo()(44)
            make?.height.equalTo()(44)
        }
        
        self.topIcon = UIImageView()
        self.topIcon.image = UIImage(named: "home_top")
        self.myScrollContentView.addSubview(self.topIcon)
        self.topIcon.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(176/812*screenHeight)
            make?.height.equalTo()(screenWidth*94/375)
        }
        
        self.middleIcon = UIImageView()
        self.middleIcon.image = UIImage(named: "home_middle")
        self.myScrollContentView.addSubview(self.middleIcon)
        self.middleIcon.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.topIcon.mas_bottom)?.offset()(0)
            make?.height.equalTo()(screenWidth*240/375)
        }
        
        self.firstTitleLabel = UILabel()
        self.firstTitleLabel.textColor = UIColor(hex: "000000")
        self.firstTitleLabel.font = UIFont(name: "Silom", size: 14)
        self.firstTitleLabel.text = self.mainModel.digging?.dragged?.oldtemple ?? ""
        self.myScrollContentView.addSubview(self.firstTitleLabel)
        self.firstTitleLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.middleIcon.mas_top)?.offset()(22)
            make?.centerX.equalTo()(self.myScrollContentView)
        }
        
        let amountBackLine = UIView()
        amountBackLine.backgroundColor = UIColor(hex: "F2CE21")
        self.myScrollContentView.addSubview(amountBackLine)
        
        self.loanAmountLabel = UILabel()
        self.loanAmountLabel.text = self.mainModel.digging?.dragged?.discovered ?? ""
        self.loanAmountLabel.font = UIFont(name: "Phosphate-Inline", size: 32)
        self.loanAmountLabel.textColor = UIColor(hex: "856CEB")
        self.myScrollContentView.addSubview(self.loanAmountLabel)
        self.loanAmountLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.firstTitleLabel.mas_bottom)?.offset()(8)
            make?.centerX.equalTo()(self.myScrollContentView)
        }
        
        amountBackLine.mas_makeConstraints { make in
            make?.left.equalTo()(self.loanAmountLabel.mas_left)
            make?.right.equalTo()(self.loanAmountLabel.mas_right)
            make?.bottom.equalTo()(self.loanAmountLabel.mas_bottom)
            make?.height.equalTo()(12)
        }
        
        self.downIcon = UIImageView()
        self.downIcon.image = UIImage(named: "home_down")
        self.myScrollContentView.addSubview(self.downIcon)
        self.downIcon.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.middleIcon.mas_bottom)?.offset()(0)
            make?.height.equalTo()(screenWidth*144/375)
            make?.bottom.offset()(-106)
        }
        
        self.leftIcon = UIImageView()
        self.leftIcon.image = UIImage(named: "home_left")
        self.myScrollContentView.addSubview(self.leftIcon)
        self.leftIcon.mas_makeConstraints { make in
            make?.width.equalTo()(118)
            make?.height.equalTo()(140)
            make?.centerX.equalTo()(self.myScrollContentView)?.offset()(-70)
            make?.bottom.equalTo()(self.middleIcon)
        }
        
        self.rateLabel = UILabel()
        self.rateLabel.text = self.mainModel.digging?.dragged?.postcards
        self.rateLabel.textColor = UIColor(hex: "856CEB")
        self.rateLabel.font = UIFont(name: "Phosphate-Inline", size: 20)
        self.myScrollContentView.addSubview(self.rateLabel)
        self.rateLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.leftIcon)?.offset()(5)
            make?.top.equalTo()(self.leftIcon.mas_top)?.offset()(74)
        }
        let angleInRadians = CGFloat(15.0 * Double.pi / 180.0)
        self.rateLabel.transform = CGAffineTransform(rotationAngle: angleInRadians)
        
        self.rateTitleLabel = UILabel()
        self.rateTitleLabel.textAlignment = .center
        self.rateTitleLabel.numberOfLines = 0
        self.rateTitleLabel.text = "Interest Rate"
        self.rateTitleLabel.font = UIFont(name: "Silom", size: 12)
        self.rateTitleLabel.textColor = UIColor(hex: "333333")
        self.myScrollContentView.addSubview(self.rateTitleLabel)
        self.rateTitleLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.leftIcon)?.offset()(0)?.offset()(-2)
            make?.top.equalTo()(self.rateLabel.mas_top)?.offset()(28)
            make?.width.equalTo()(60)
            
        }
        self.rateTitleLabel.transform = CGAffineTransform(rotationAngle: angleInRadians)

        self.rightIcon = UIImageView()
        self.rightIcon.image = UIImage(named: "home_right")
        self.myScrollContentView.addSubview(self.rightIcon)
        self.rightIcon.mas_makeConstraints { make in
            make?.width.equalTo()(118)
            make?.height.equalTo()(140)
            make?.centerX.equalTo()(self.myScrollContentView)?.offset()(70)
            make?.bottom.equalTo()(self.middleIcon)
        }
        
        self.termLabel = UILabel()
        self.termLabel.text = self.mainModel.digging?.dragged?.crowded
        self.termLabel.textColor = UIColor(hex: "856CEB")
        self.termLabel.font = UIFont(name: "Phosphate-Inline", size: 20)
        self.myScrollContentView.addSubview(self.termLabel)
        self.termLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.rightIcon)?.offset()(-10)
            make?.top.equalTo()(self.rightIcon.mas_top)?.offset()(74)
        }

        self.termTitleLabel = UILabel()
        self.termTitleLabel.textAlignment = .center
        self.termTitleLabel.numberOfLines = 0
        self.termTitleLabel.text = "Loan Term"
        self.termTitleLabel.font = UIFont(name: "Silom", size: 12)
        self.termTitleLabel.textColor = UIColor(hex: "333333")
        self.myScrollContentView.addSubview(self.termTitleLabel)
        self.termTitleLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.rightIcon)?.offset()(0)?.offset()(-10)
            make?.top.equalTo()(self.termLabel.mas_top)?.offset()(28)
            make?.width.equalTo()(60)
            
        }
        
        self.applyBtn = UIButton(type: .custom)
        self.applyBtn.titleLabel?.font = UIFont(name: "Phosphate-Inline", size: 24)
        self.applyBtn.titleEdgeInsets = UIEdgeInsets(top: -10, left: 0, bottom: 10, right: 0)
        self.applyBtn.setBackgroundImage(UIImage(named: "homeBtnBg"), for: .normal)
        self.applyBtn.setTitle(self.mainModel.digging?.dragged?.werethemselves ?? "", for: .normal)
        self.applyBtn.setTitleColor(UIColor(hex: "000000"), for: .normal)
        self.myScrollContentView.addSubview(self.applyBtn)
        self.applyBtn.mas_makeConstraints { make in
            make?.width.equalTo()(253/375*screenWidth)
            make?.height.equalTo()(88/375*screenWidth)
            make?.centerX.equalTo()(self.downIcon)
            make?.top.equalTo()(self.downIcon.mas_top)?.offset()(14)
        }
        self.applyBtn.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
    }
    
    func buildUI02(){
        for subview in self.view.subviews {
            subview.removeFromSuperview()
        }
        self.view.backgroundColor = UIColor(hex: "856CEB")
        
        let productLabel = UILabel()
        productLabel.text = "Shiny Money"
        productLabel.textColor = UIColor.white
        productLabel.font = UIFont(name: "SFProDisplay-Black", size: 24)
        self.view.addSubview(productLabel)
        productLabel.mas_makeConstraints { make in
            make?.centerX.equalTo()(self.view)
            if SM_ShareFunction.hasNotch() == true {
                make?.top.offset()(55)
            }else{
                make?.top.offset()(35)
            }
        }
        
        self.headphonesBtn = UIButton(type: .custom)
        self.headphonesBtn.addTarget(self, action: #selector(kfAction), for: .touchUpInside)
        self.headphonesBtn.setImage(UIImage(named: "headphones"), for: .normal)
        self.headphonesBtn.setTitle("", for: .normal)
        self.view.addSubview(self.headphonesBtn)
        self.headphonesBtn.mas_makeConstraints { make in
            make?.right.offset()(-24)
            make?.centerY.equalTo()(productLabel)
            make?.width.equalTo()(44)
            make?.height.equalTo()(44)
        }
        
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib.init(nibName: "SM_ProductCell", bundle: nil), forCellReuseIdentifier: "SM_ProductCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
        }
        self.view.addSubview(self.tableView)
        self.tableView.tableHeaderView = self.tabviewHeaderView()
        self.tableView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.headphonesBtn.mas_bottom)?.offset()(20)
            make?.bottom.offset()(-108)
        }
        let refreshHeader :CARefreshHeader = CARefreshHeader {
            self.getHomeInfomationDataList()
        }
        refreshHeader.tintColor = UIColor.white
        refreshHeader.stateLabel?.textColor = UIColor.clear;
        refreshHeader.loadingView?.style = .white
        self.tableView.mj_header = refreshHeader;
    }
    
    @objc func kfAction(){
        print("click kf btn")
        URLRouter.default.openRoute("https://omdublending.com/bowedWhistled")
    }
    
    @objc func applyAction(){
        if SMUserModel.checkIsLogin() == false {
            return
        }
        SM_HomeViewModel.applyProduct(local: self.mainModel.digging?.dragged?.crash ?? "") { dataModel in
            if dataModel.onsinging == 0 {
                let applyModel : SMApplyDataModel = SMApplyDataModel.init(jsondata: dataModel.ended!)
                URLRouter.default.openRoute(applyModel.deadly ?? "")
            }
        }
    }
    
    func loanApplyAction(model : theyatListModel){
        if SMUserModel.checkIsLogin() == false {
            return
        }
        SM_HomeViewModel.applyProduct(local: model.crash ?? "") { dataModel in
            if dataModel.onsinging == 0 {
                let applyModel : SMApplyDataModel = SMApplyDataModel.init(jsondata: dataModel.ended!)
                URLRouter.default.openRoute(applyModel.deadly ?? "")
            }
        }
    }
    
    func getHomeInfomationDataList(){
        SM_HomeViewModel.getHomeInfomationListData { dataModel in
            if dataModel.onsinging == 0 {
                if dataModel.ended != nil {
                    self.mainModel = SMHomeInfoModel(jsondata: dataModel.ended!)
                    if self.mainModel.digging?.bigboy?.count != 0 {
                        self.buildUI()
                    }else{
                        self.buildUI02()
                    }
                }
            }
            if self.tableView != nil {
                self.tableView.mj_header?.endRefreshing()
            }
        }
    }
    
    func tabviewHeaderView() ->UIView {
        let headerView = UIView()
        if self.mainModel.guide?.bigboy?.count ?? 0 > 0 && self.mainModel.thepicture?.bigboy?.count ?? 0 > 0 {
            self.buildFirstCycleScrollView(headerView: headerView)
            self.buildSecondCycleScrollView(headerView: headerView,top: 102)
            headerView.height = 92 + 92 + 10
        }else if self.mainModel.guide?.bigboy?.count ?? 0 > 0 || self.mainModel.thepicture?.bigboy?.count ?? 0 > 0 {
            if self.mainModel.guide?.bigboy?.count ?? 0 > 0 {
                self.buildFirstCycleScrollView(headerView: headerView)
            }else{
                self.buildSecondCycleScrollView(headerView: headerView,top: 0)
            }
            headerView.height = 92
        }else{
            headerView.height = 0
        }
        return headerView
    }
    
    func buildFirstCycleScrollView(headerView : UIView){
        let cycleScrollView : SDCycleScrollView = SDCycleScrollView(frame:CGRectMake(26, 0, screenWidth - 52, 92), delegate: self, placeholderImage: UIImage(named: ""))
        cycleScrollView.tag = 101
        cycleScrollView.delegate = self
        cycleScrollView.autoScrollTimeInterval = 5.0
        cycleScrollView.currentPageDotImage = UIImage(named: "dotNormal")
        cycleScrollView.pageDotImage = UIImage(named: "dotSelected")
        cycleScrollView.layer.cornerRadius = 10
        cycleScrollView.layer.masksToBounds = true
        cycleScrollView.backgroundColor = UIColor.clear
        headerView.addSubview(cycleScrollView)
        
        var imageUrlArr : [String] = []
        for draggedModel in self.mainModel.guide!.draggedArr {
            imageUrlArr.append(draggedModel.beneath ?? "")
        }
        cycleScrollView.imageURLStringsGroup = imageUrlArr
    }
    
    func buildSecondCycleScrollView(headerView : UIView,top : CGFloat){
        let cycleScrollView : SDCycleScrollView = SDCycleScrollView(frame:CGRectMake(26, top, screenWidth - 52, 92), delegate: self, placeholderImage: UIImage(named: ""))
        cycleScrollView.tag = 102
        cycleScrollView.delegate = self
        cycleScrollView.autoScrollTimeInterval = 5.0
        cycleScrollView.currentPageDotImage = UIImage(named: "dotNormal")
        cycleScrollView.pageDotImage = UIImage(named: "dotSelected")
        cycleScrollView.layer.cornerRadius = 10
        cycleScrollView.layer.masksToBounds = true
        cycleScrollView.backgroundColor = UIColor.clear
        headerView.addSubview(cycleScrollView)
        
        var imageUrlArr : [String] = []
        for draggedModel in self.mainModel.thepicture!.theyatArr {
            imageUrlArr.append(draggedModel.beneath ?? "")
        }
        cycleScrollView.imageURLStringsGroup = imageUrlArr
    }
}

extension SM_HomeVC : UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainModel.theyat?.theyatArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model : theyatListModel = self.mainModel.theyat!.theyatArr[indexPath.section]
        let cell : SM_ProductCell = tableView.dequeueReusableCell(withIdentifier: "SM_ProductCell") as! SM_ProductCell
        cell.configData(model: model)
        cell.applyBlock = { model in
            self.loanApplyAction(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       if section == 0{
            return 20
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        if(cycleScrollView.tag == 101) {
            let model = self.mainModel.guide?.draggedArr[index]
            if model != nil {
                URLRouter.default.openRoute(model!.deadly ?? "")
            }
        }else{
            let model = self.mainModel.thepicture?.theyatArr[index]
            if model != nil {
                URLRouter.default.openRoute(model!.deadly ?? "")
            }
        }
        
    }
}
