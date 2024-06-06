//
//  SM_HomeLoanAgainViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/22.
//

import UIKit
import NNModule_swift
class SM_HomeLoanAgainViewController: UIViewController {
    var mainModel : LoanTheyatModel?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SM_ProductCell", bundle: nil), forCellReuseIdentifier: "SM_ProductCell")
        tableView.register(UINib.init(nibName: "SM_HomeBannerCell", bundle: nil), forCellReuseIdentifier: "SM_HomeBannerCell")
        tableView.register(UINib.init(nibName: "SM_HomeBanner01Cell", bundle: nil), forCellReuseIdentifier: "SM_HomeBanner01Cell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
        }
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.getLoanList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "856CEB")
        
        self.view.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(10)
            make?.bottom.offset()(0)
        }
        
    }
     
    func getLoanList(){
        SM_HomeViewModel.getLoanList { dataModel in
            if dataModel.onsinging == 0 {
                self.mainModel = LoanTheyatModel(jsondata: dataModel.ended!)
                self.title = self.mainModel?.cooking
                self.tableView.reloadData()
            }
        }
    }
    
    func applyAction(model : theyatListModel){
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
}

extension SM_HomeLoanAgainViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainModel?.theyatArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let model : theyatListModel = self.mainModel!.theyatArr[indexPath.section]
        let cell : SM_ProductCell = tableView.dequeueReusableCell(withIdentifier: "SM_ProductCell") as! SM_ProductCell
        cell.configData(model: model)
        cell.applyBlock = { model in
            self.applyAction(model: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (screenWidth - 52)*141/323 + (screenWidth - 52)*50/323
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
}
