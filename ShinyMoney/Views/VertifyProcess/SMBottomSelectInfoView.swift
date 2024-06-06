//
//  SMBottomSelectInfoView.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/4/24.
//

import UIKit
import SwiftyJSON
enum bottomViewStyle {
    case singleLevel
    case multiLevel
    case selectID
    case cardInfo
    case selectDate
}

protocol selectCardIDDelegate: AnyObject {
    func didSelectCardType(cardTypeName : String)
}

class SMBottomSelectInfoView: UIView {
    var contentView : UIView!
    var bottomView : UIView!
    var bottomWhiteView : UIView!
    var topIconImageView : UIImageView!
    var closeBtn : UIButton!
    var titleLabel : UILabel!
    var leftStarIcon : UIImageView!
    var rightStarIcon : UIImageView!
    var selectResultLabel : UILabel!
    var currentStyle : bottomViewStyle!
    var currentStep : NSInteger!
    var titleStr : String!
    var cardArr : [JSON]!
    var itemArr : [String]!
    var cardTypeStr : String?
    var currentSelectStr : String?
    var dateStr : String?
    var cardInfoModel : SMCardInfoModel?
    var scrollview : UIScrollView!
    var scrollContentView : UIView!
    var nameView : UIView!
    var nameTextfield : UITextField!
    var numberView : UIView!
    var numberTextfield : UITextField!
    var dateBirthView : UIView!
    var dateBirthTextfield : UITextField!
    var confirmBtn : UIButton!
    var currentYear: String!
    var currentMonth: String!
    var currentDay: String!
    var yearArr: [String] = []
    var monthArr: [String] = []
    var monthEnglishArr: [String] = []
    var dayArr: [String] = []
    var unitFlags: NSCalendar.Unit = []
    var calendar: Calendar?
    var selectedMonthRow: Int = 0
    var selectedYearRow: Int = 0
    var selectedDayRow: Int = 0
    weak var delegate: selectCardIDDelegate?
    var selectItemBlock : ((_ currentSelectStr : String)->())?
    var confirmCardInfoBlock : ((_ nameStr : String,_ numberStr : String,_ birthStr : String)->())?
    var selectDateBlock : ((_ dateStr : String) -> ())?
    var confirmDateBlock : ((_ dateStr : String) -> ())?
    lazy var pickerview: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.backgroundColor = .clear
        pickerView.layer.masksToBounds = true
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "SM_BottomSelectInfoViewCell", bundle: nil), forCellReuseIdentifier: "SM_BottomSelectInfoViewCell")
        tableView.register(UINib.init(nibName: "SM_BottomSelectInfoViewCell01", bundle: nil), forCellReuseIdentifier: "SM_BottomSelectInfoViewCell01")
         if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
        }
        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    static func showBottomSelectView(style : bottomViewStyle,currentStep : NSInteger,titleStr : String,itemArr : [String],currentSelectStr : String!, cardArr : [JSON]) -> SMBottomSelectInfoView{
        let bottomSelectInfoView : SMBottomSelectInfoView = SMBottomSelectInfoView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        bottomSelectInfoView.currentStyle = style
        bottomSelectInfoView.currentStep = currentStep
        bottomSelectInfoView.titleStr = titleStr
        bottomSelectInfoView.cardArr = cardArr
        bottomSelectInfoView.itemArr = itemArr
        bottomSelectInfoView.currentSelectStr = currentSelectStr
        bottomSelectInfoView.buildUI()
        if style == .singleLevel {
            bottomSelectInfoView.buildStyle01View()
        }else if style == .multiLevel{
            bottomSelectInfoView.buildStyle02View()
        }else if style == .selectID{
            bottomSelectInfoView.buildStyle03View()
        }else {
            
        }
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(bottomSelectInfoView)
        
        return bottomSelectInfoView
    }
    
    static func showBottomCardInfoView(style : bottomViewStyle,currentStep : NSInteger,titleStr : String,cardTypeStr : String,cardInfoModel : SMCardInfoModel) -> SMBottomSelectInfoView{
        let bottomSelectInfoView : SMBottomSelectInfoView = SMBottomSelectInfoView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        bottomSelectInfoView.currentStyle = style
        bottomSelectInfoView.currentStep = currentStep
        bottomSelectInfoView.titleStr = titleStr
        bottomSelectInfoView.cardTypeStr = cardTypeStr
        bottomSelectInfoView.cardInfoModel = cardInfoModel
        bottomSelectInfoView.buildUI()
        bottomSelectInfoView.buildStyle04View()

        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(bottomSelectInfoView)
        
        NotificationCenter.default.addObserver(bottomSelectInfoView, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(bottomSelectInfoView, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        return bottomSelectInfoView
    }
    
    static func showBottomSelectDateView(style : bottomViewStyle,dateStr : String,currentStep : NSInteger,titleStr : String) -> SMBottomSelectInfoView {
        let bottomSelectInfoView : SMBottomSelectInfoView = SMBottomSelectInfoView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        bottomSelectInfoView.titleStr = titleStr
        bottomSelectInfoView.dateStr = dateStr
        bottomSelectInfoView.currentStep = currentStep
        bottomSelectInfoView.currentStyle = style
        bottomSelectInfoView.buildUI()
        bottomSelectInfoView.buildStyle05View()

        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(bottomSelectInfoView)
        
        return bottomSelectInfoView

    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            let offset = keyboardSize.height
                UIView.animate(withDuration: 0.1) {
                self.frame.origin.y = -offset
            }
         }
       }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.1) {
            self.frame.origin.y = 0
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildUI(){
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        self.contentView = UIView()
        self.contentView.backgroundColor = UIColor.clear
        self.addSubview(self.contentView)
        self.contentView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
            if self.currentStyle == .singleLevel {
                make?.height.equalTo()(screenHeight/2)
            }else if(self.currentStyle == .cardInfo){
                make?.height.equalTo()(560)
            }
            else{
                make?.height.equalTo()(screenHeight/2 + 100)
            }
        }
        
        self.topIconImageView = UIImageView()
        self.contentView.addSubview(self.topIconImageView)
        self.topIconImageView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.offset()(0)
            make?.height.equalTo()(screenWidth*152/375)
        }
        
        self.bottomView = UIView()
        self.contentView.addSubview(self.bottomView)
        self.bottomView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.bottom.offset()(0)
            make?.top.equalTo()(self.topIconImageView.mas_bottom)?.offset()(0)
        }
        
        self.bottomWhiteView = UIView()
        self.bottomWhiteView.backgroundColor = UIColor.white
        self.contentView.addSubview(self.bottomWhiteView)
        self.bottomWhiteView.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.bottom.offset()(0)
            make?.top.equalTo()(self.topIconImageView.mas_bottom)?.offset()(0)
        }
        
        self.closeBtn = UIButton(type: .custom)
        self.closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.contentView.addSubview(self.closeBtn)
        self.closeBtn.mas_makeConstraints { make in
            make?.left.offset()(32/375*screenWidth)
            make?.top.offset()(77/152*(screenWidth*152/375))
            make?.width.equalTo()(28)
            make?.height.equalTo()(28)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.text = self.titleStr
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.titleLabel.textColor = UIColor.black
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.closeBtn.mas_top)?.offset()(13)
            make?.centerX.equalTo()(self)
        }
        
        self.leftStarIcon = UIImageView()
        self.contentView.addSubview(self.leftStarIcon)
        self.leftStarIcon.mas_makeConstraints { make in
            make?.right.equalTo()(self.titleLabel.mas_left)?.offset()(-4)
            make?.centerY.equalTo()(self.titleLabel)
        }
        
        self.rightStarIcon = UIImageView()
        self.contentView.addSubview(self.rightStarIcon)
        self.rightStarIcon.mas_makeConstraints { make in
            make?.left.equalTo()(self.titleLabel.mas_right)?.offset()(4)
            make?.centerY.equalTo()(self.titleLabel)
        }
        
        if self.currentStep == 2 {
            self.topIconImageView.image = UIImage(named: "alertViewTop02")
            self.closeBtn.setImage(UIImage(named: "alertViewClose02"), for: .normal)
            self.bottomView.backgroundColor = UIColor(hex: "7BD4FF")
            self.leftStarIcon.image = UIImage(named: "alertViewLeftStar02")
            self.rightStarIcon.image = UIImage(named: "alertViewRightStar02")

        }else if currentStep == 3 {
            self.topIconImageView.image = UIImage(named: "alertViewTop03")
            self.closeBtn.setImage(UIImage(named: "alertViewClose03"), for: .normal)
            self.bottomView.backgroundColor = UIColor(hex: "FFD934")
            self.leftStarIcon.image = UIImage(named: "alertViewLeftStar03")
            self.rightStarIcon.image = UIImage(named: "alertViewRightStar03")

        }else if currentStep == 4 {
            self.topIconImageView.image = UIImage(named: "alertViewTop04")
            self.closeBtn.setImage(UIImage(named: "alertViewClose04"), for: .normal)
            self.bottomView.backgroundColor = UIColor(hex: "ACF02C")
            self.leftStarIcon.image = UIImage(named: "alertViewLeftStar04")
            self.rightStarIcon.image = UIImage(named: "alertViewRightStar04")

        }else if currentStep == 5{
            self.topIconImageView.image = UIImage(named: "alertViewTop05")
            self.closeBtn.setImage(UIImage(named: "alertViewClose05"), for: .normal)
            self.bottomView.backgroundColor = UIColor(hex: "856CEB")
            self.leftStarIcon.image = UIImage(named: "alertViewLeftStar05")
            self.rightStarIcon.image = UIImage(named: "alertViewRightStar05")
        }else{
            self.topIconImageView.image = UIImage(named: "alertViewTop01")
            self.closeBtn.setImage(UIImage(named: "alertViewClose01"), for: .normal)
            self.bottomView.backgroundColor = UIColor(hex: "FCAA74")
            self.leftStarIcon.image = UIImage(named: "alertViewLeftStar01")
            self.rightStarIcon.image = UIImage(named: "alertViewRightStar01")
        }
    }
    
    @objc func closeAction(){
        self.removeFromSuperview()
    }
    
    func buildStyle01View(){
        self.contentView.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { make in
            make?.top.equalTo()(self.topIconImageView.mas_bottom)
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.bottom.offset()(-20)
        }
    }
    
    func buildStyle02View(){
        self.selectResultLabel = UILabel()
        self.selectResultLabel.text = "Please choose"
        self.selectResultLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.selectResultLabel.textColor = UIColor.black
        self.contentView.addSubview(self.selectResultLabel)
        self.selectResultLabel.mas_makeConstraints { make in
            make?.left.offset()(36)
            make?.top.equalTo()(self.topIconImageView.mas_bottom)?.offset()(26)
        }
        
        self.contentView.addSubview(self.tableView)
        self.tableView.mas_makeConstraints { make in
            make?.top.equalTo()(self.selectResultLabel.mas_bottom)?.offset()(26)
            make?.left.offset()(16)
            make?.right.offset()(-16)
            make?.bottom.offset()(0)
        }
    }
    
    func buildStyle03View(){
        self.scrollview = UIScrollView()
        self.scrollview.backgroundColor = UIColor.clear
        self.scrollview.showsVerticalScrollIndicator = false
        self.scrollview.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(self.scrollview)
        self.scrollview.mas_makeConstraints { make in
            make?.left.offset()(16)
            make?.width.equalTo()(screenWidth - 32)
            make?.top.equalTo()(topIconImageView.mas_bottom)?.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.scrollContentView = UIView()
        self.scrollContentView.backgroundColor = UIColor.clear
        self.scrollview.addSubview(self.scrollContentView)
        self.scrollContentView.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.width.equalTo()(screenWidth - 32)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        let itemWidth = (screenWidth - 82) / 2
        let itemHeight = 112
        let firstCardArr = self.cardArr[0].rawValue as! [String]
        for i in 0...firstCardArr.count - 1 {
            let row = i / 2
            let col = i % 2
            let cardItem : SM_SelectIDItemView = SM_SelectIDItemView()
            cardItem.tag = i
            cardItem.isUserInteractionEnabled = true
            cardItem.configData(cardNameStr: firstCardArr[i])
            self.scrollContentView.addSubview(cardItem)
            cardItem.mas_makeConstraints { make in
                make?.left.offset()(16 + (18 + itemWidth)*CGFloat(col))
                make?.top.offset()(10 + CGFloat((16 + itemHeight)*row))
                make?.width.equalTo()(itemWidth)
                make?.height.equalTo()(itemHeight)
                if i == firstCardArr.count - 1 {
                    make?.bottom.offset()(-16)
                }
            }
            
            let selectItemTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectCardTypeAction))
            cardItem.addGestureRecognizer(selectItemTap)
        }
    }
    
    func buildStyle04View(){
        let nameTitleLabel : UILabel = UILabel()
        nameTitleLabel.text = String(format: "%@ name", self.cardTypeStr!)
        nameTitleLabel.textColor = UIColor(hex: "FCAA74")
        nameTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(nameTitleLabel)
        nameTitleLabel.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.top.equalTo()(self.topIconImageView.mas_bottom)?.offset()(20)
        }
        
        self.nameView = UIView()
        self.nameView.layer.borderWidth = 2.0
        self.nameView.layer.cornerRadius = 12
        self.nameView.layer.borderColor = UIColor(hex: "FCAA74").cgColor
        self.contentView.addSubview(self.nameView)
        self.nameView.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.height.equalTo()(50)
            make?.top.equalTo()(nameTitleLabel.mas_bottom)?.offset()(8)
        }
        
        let nameIcon : UIImageView = UIImageView()
        nameIcon.image = UIImage(named: "alertViewEnterIcon01")
        nameView.addSubview(nameIcon)
        nameIcon.mas_makeConstraints { make in
            make?.right.offset()(-18)
            make?.centerY.equalTo()(nameView)
            make?.height.equalTo()(18)
            make?.width.equalTo()(18)
        }
        
        self.nameTextfield = UITextField()
        self.nameTextfield.text = self.cardInfoModel?.successful ?? ""
        self.nameTextfield.textColor = UIColor(hex: "000000")
        self.nameTextfield.font = UIFont.boldSystemFont(ofSize: 14)
        nameView.addSubview(self.nameTextfield)
        self.nameTextfield.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.right.equalTo()(nameIcon.mas_left)?.offset()(-12)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.buildCardNumberUI()
        self.buildBirthdateUI()
    }
    
    func buildCardNumberUI(){
        let numberTitleLabel : UILabel = UILabel()
        numberTitleLabel.text = String(format: "%@ number", self.cardTypeStr!)
        numberTitleLabel.textColor = UIColor(hex: "FCAA74")
        numberTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(numberTitleLabel)
        numberTitleLabel.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.top.equalTo()(self.nameView.mas_bottom)?.offset()(24)
        }
        
        self.numberView = UIView()
        self.numberView.layer.borderWidth = 2.0
        self.numberView.layer.cornerRadius = 12
        self.numberView.layer.borderColor = UIColor(hex: "FCAA74").cgColor
        self.contentView.addSubview(self.numberView)
        self.numberView.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.height.equalTo()(50)
            make?.top.equalTo()(numberTitleLabel.mas_bottom)?.offset()(8)
        }
        
        let numberIcon : UIImageView = UIImageView()
        numberIcon.image = UIImage(named: "alertViewEnterIcon01")
        numberView.addSubview(numberIcon)
        numberIcon.mas_makeConstraints { make in
            make?.right.offset()(-18)
            make?.centerY.equalTo()(numberView)
            make?.height.equalTo()(18)
            make?.width.equalTo()(18)
        }
        
        self.numberTextfield = UITextField()
        self.numberTextfield.text = self.cardInfoModel?.abedroom ?? ""
        self.numberTextfield.textColor = UIColor(hex: "000000")
        self.numberTextfield.font = UIFont.boldSystemFont(ofSize: 14)
        numberView.addSubview(self.numberTextfield)
        self.numberTextfield.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.right.equalTo()(numberIcon.mas_left)?.offset()(-12)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
    }
    
    func buildBirthdateUI(){
        let birthTitleLabel : UILabel = UILabel()
        birthTitleLabel.text = "UMID Date"
        birthTitleLabel.textColor = UIColor(hex: "FCAA74")
        birthTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(birthTitleLabel)
        birthTitleLabel.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.top.equalTo()(self.numberView.mas_bottom)?.offset()(24)
        }
        
        self.dateBirthView = UIView()
        self.dateBirthView.layer.borderWidth = 2.0
        self.dateBirthView.layer.cornerRadius = 12
        self.dateBirthView.layer.borderColor = UIColor(hex: "FCAA74").cgColor
        self.contentView.addSubview(self.dateBirthView)
        self.dateBirthView.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.height.equalTo()(50)
            make?.top.equalTo()(birthTitleLabel.mas_bottom)?.offset()(8)
        }
        self.dateBirthView.isUserInteractionEnabled = true
        let dateChooseTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseDateAction))
        self.dateBirthView.addGestureRecognizer(dateChooseTap)
        
        let birthIcon : UIImageView = UIImageView()
        birthIcon.image = UIImage(named: "alertViewPullDownIcon01")
        self.dateBirthView.addSubview(birthIcon)
        birthIcon.mas_makeConstraints { make in
            make?.right.offset()(-18)
            make?.centerY.equalTo()(dateBirthView)
            make?.height.equalTo()(18)
            make?.width.equalTo()(18)
        }
        
        self.dateBirthTextfield = UITextField()
        self.dateBirthTextfield.isUserInteractionEnabled = false
        self.dateBirthTextfield.text = String(format: "%@/%@/%@", self.cardInfoModel?.inhis ?? "",self.cardInfoModel?.pretended ?? "",self.cardInfoModel?.horrid ?? "")
        self.dateBirthTextfield.textColor = UIColor(hex: "000000")
        self.dateBirthTextfield.font = UIFont.boldSystemFont(ofSize: 14)
        dateBirthView.addSubview(self.dateBirthTextfield)
        self.dateBirthTextfield.mas_makeConstraints { make in
            make?.left.offset()(12)
            make?.right.equalTo()(birthIcon.mas_left)?.offset()(-12)
            make?.top.offset()(0)
            make?.bottom.offset()(0)
        }
        
        self.confirmBtn = UIButton(type: .custom)
        self.confirmBtn.layer.cornerRadius = 12
        self.confirmBtn.backgroundColor = UIColor(hex: "FCAA74")
        self.confirmBtn.setTitle("Confirm", for: .normal)
        self.confirmBtn.setTitleColor(UIColor.black, for: .normal)
        self.confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.contentView.addSubview(self.confirmBtn)
        self.confirmBtn.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.height.equalTo()(58)
            make?.top.equalTo()(self.dateBirthView.mas_bottom)?.offset()(30)
        }
        self.confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
    }
    
    func buildStyle05View(){
        self.confirmBtn = UIButton(type: .custom)
        self.confirmBtn.layer.cornerRadius = 12
        self.confirmBtn.backgroundColor = UIColor(hex: "FCAA74")
        self.confirmBtn.setTitle("Confirm", for: .normal)
        self.confirmBtn.setTitleColor(UIColor.black, for: .normal)
        self.confirmBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.contentView.addSubview(self.confirmBtn)
        self.confirmBtn.mas_makeConstraints { make in
            make?.left.offset()(38)
            make?.right.offset()(-38)
            make?.height.equalTo()(58)
            make?.bottom.offset()(-24)
        }
        self.confirmBtn.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        self.contentView.addSubview(self.pickerview)
        self.pickerview.mas_makeConstraints { make in
            make?.left.offset()(0)
            make?.right.offset()(0)
            make?.top.equalTo()(self.topIconImageView.mas_bottom)?.offset()(18)
            make?.bottom.equalTo()(self.confirmBtn.mas_top)?.offset()(-10)
        }
        
        self.getDateArr()
    }
    
    func getDateArr() {
        if dateStr == nil {
            return
        }
        let timeArr = dateStr!.components(separatedBy: "/")
        currentYear = timeArr[2]
        currentMonth = timeArr[1]
        currentDay = timeArr[0]
        let currentYearInt = Int(currentYear)!
        
        for i in 0..<81 {
            yearArr.insert("\(currentYearInt - i)", at: 0)
        }
        for i in 1..<81 {
            yearArr.append("\(currentYearInt + i)")
        }
        
        monthArr = ["01","02","03","04","05","06","07","08","09","10","11","12"]
        monthEnglishArr = ["January","February","March","April","May","June","July","August","September","October","November","December"]
       
        let currentYeadAndMonth = String(format: "%@-%@", currentYear,currentMonth)
        let selectedDate : NSDate = NSDate.jk_date(with: currentYeadAndMonth, format: "yyyy-MM")! as NSDate
        let daylength = selectedDate.jk_daysInMonth()
        for i in 1...daylength {
            var dayStr: String
            if i < 10 {
                dayStr = "0\(i)"
            } else {
                dayStr = "\(i)"
            }
            dayArr.append(dayStr)
        }
        
        pickerview.reloadAllComponents()
        
        for i in 0..<dayArr.count {
            let day = dayArr[i]
            if currentDay == day {
                selectedDayRow = i
                pickerview.selectRow(i, inComponent: 0, animated: true)
            }
        }
        
        for i in 0..<monthArr.count {
            let month = monthArr[i]
            if currentMonth == month {
                selectedMonthRow = i
                pickerview.selectRow(i, inComponent: 1, animated: true)
            }
        }
        
        for i in 0..<yearArr.count {
            let year = yearArr[i]
            if currentYearInt == Int(year)! {
                selectedYearRow = i
                pickerview.selectRow(i, inComponent: 2, animated: true)
            }
        }
    }
    
    @objc func confirmAction(){
        if self.currentStyle == .selectDate {
            self.removeFromSuperview()
            let dateStr = String(format: "%@/%@/%@", self.dayArr[selectedDayRow],self.monthArr[selectedMonthRow],self.yearArr[selectedYearRow])
            self.confirmDateBlock?(dateStr)
        }else{
            if self.nameTextfield.text?.count == 0 || self.numberTextfield.text?.count == 0 || self.dateBirthTextfield.text?.count == 0 {
                SMCustomActivityIndicatorView.showErrorProcessView(errorStr: "Incomplete identification information")
                return
            }
            self.removeFromSuperview()
            self.confirmCardInfoBlock?(self.nameTextfield.text!,self.numberTextfield.text!,self.dateBirthTextfield.text!)
        }
    }
    
    @objc func selectCardTypeAction(ges : UIGestureRecognizer){
        self.removeFromSuperview()
        guard let currentIndex = ges.view?.tag else { return }
        let firstCardArr = self.cardArr[0].rawValue as! [String]
        let cardTypeStr = firstCardArr[currentIndex]
        delegate?.didSelectCardType(cardTypeName: cardTypeStr)
    }
    
    @objc func chooseDateAction(){
        self.selectDateBlock?(self.dateBirthTextfield.text!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SMBottomSelectInfoView : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.currentStyle == .singleLevel {
            let cell : SM_BottomSelectInfoViewCell = tableView.dequeueReusableCell(withIdentifier: "SM_BottomSelectInfoViewCell") as! SM_BottomSelectInfoViewCell
            cell.itemTitleLabel.text = self.itemArr[indexPath.row]
            if self.itemArr[indexPath.row] == self.currentSelectStr {
                cell.tickIcon.isHidden = false
            }else{
                cell.tickIcon.isHidden = true
            }
            if self.currentStep == 2 {
                cell.configData(tickIconImageStr: "alertViewSelected02")
            }else if self.currentStep == 3 {
                cell.configData(tickIconImageStr: "alertViewSelected03")
            }else if self.currentStep == 4 {
                cell.configData(tickIconImageStr: "alertViewSelected04")
            }else {
                cell.configData(tickIconImageStr: "alertViewSelected05")
            }
            return cell
        }else{
            let cell : SM_BottomSelectInfoViewCell01 = tableView.dequeueReusableCell(withIdentifier: "SM_BottomSelectInfoViewCell01") as! SM_BottomSelectInfoViewCell01
            cell.itemTitleLabel.text = self.itemArr[indexPath.row]
            cell.tickIcon.isHidden = true
            if self.currentStep == 2 {
                cell.configData(tickIconImageStr: "alertViewSelected02")
            }else if self.currentStep == 3 {
                cell.configData(tickIconImageStr: "alertViewSelected03")
            }else if self.currentStep == 4 {
                cell.configData(tickIconImageStr: "alertViewSelected04")
            }else {
                cell.configData(tickIconImageStr: "alertViewSelected05")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.currentStyle == .singleLevel {
            self.removeFromSuperview()
            self.selectItemBlock?(self.itemArr[indexPath.row])
        }else if self.currentStyle == .multiLevel {
            if self.selectResultLabel.text == "Please choose"{
                self.selectResultLabel.text = self.itemArr[indexPath.row]
            }else{
                self.selectResultLabel.text = self.selectResultLabel.text! + "-" + self.itemArr[indexPath.row]
            }
            self.selectItemBlock?(self.itemArr[indexPath.row])
        }
    }
}

extension SMBottomSelectInfoView : UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dayArr.count
        } else if component == 1 {
            return monthEnglishArr.count
        } else {
            return yearArr.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dayArr[row]
        } else if component == 1 {
            return monthEnglishArr[row]
        } else {
            return yearArr[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel
        if let view = view as? UILabel {
            pickerLabel = view
        } else {
            pickerLabel = UILabel()
            pickerLabel.adjustsFontSizeToFitWidth = true
            pickerLabel.backgroundColor = .clear
            pickerLabel.textAlignment = .center
            pickerLabel.font = UIFont.systemFont(ofSize: 14)
            pickerLabel.textColor = UIColor(hex: "888888")
        }
        
        if (component == 2 && row == selectedYearRow) || (component == 1 && row == selectedMonthRow) || (component == 0 && row == selectedDayRow) {
            pickerLabel.font = UIFont.boldSystemFont(ofSize: 15)
            pickerLabel.textColor = UIColor(hex: "000000")
        }
        
        pickerLabel.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return pickerLabel
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let piketLabel = pickerView.view(forRow: row, forComponent: component) as? UILabel {
            piketLabel.textColor = UIColor(hex: "FFC100")
        }
        
        if component == 0 {
            selectedDayRow = row
        } else if component == 1 {
            selectedMonthRow = row
            currentMonth = monthArr[row]
        } else if component == 2 {
            selectedYearRow = row
            currentYear = yearArr[row]
        }
        
        dayArr.removeAll()
        let currentYeadAndMonth = String(format: "%@-%@", currentYear,currentMonth)
        if let selectedDate : NSDate = NSDate.jk_date(with: currentYeadAndMonth, format: "yyyy-MM") as NSDate? {
            let daylength = selectedDate.jk_daysInMonth()
            for i in 1...daylength {
                let dayStr = (i < 10) ? "0\(i)" : "\(i)"
                dayArr.append(dayStr)
            }
        }
        
        if dayArr.count - 1 < selectedDayRow {
            selectedDayRow = dayArr.count - 1
        }
        
        pickerView.reloadAllComponents()
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (UIScreen.main.bounds.width - 30) / 3
    }
    
    
}
