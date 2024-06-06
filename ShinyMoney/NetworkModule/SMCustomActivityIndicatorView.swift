//
//  BossCustomActivityIndicatorView.swift
//  H2RideBossProject
//
//  Created by 李青 on 2024/3/21.
//

import UIKit

class SMCustomActivityIndicatorView: UIView {
    var grayBgView : UIView!
    var activityIndicatorImageView : UIImageView!
    var activityIndicatorLabel : UILabel!
    var messageStr : String!
    static var activityIndicatorView : SMCustomActivityIndicatorView!
    static var errorIndicatorView : SMCustomActivityIndicatorView!
    static var successIndicatorView : SMCustomActivityIndicatorView!
    @objc static func showActivityInWindow(messageStr : String){
        let topViewController = UIViewController.getCurrentViewController()
        if topViewController == nil {
            return
        }
        if self.activityIndicatorView != nil {
            self.activityIndicatorView.removeFromSuperview()
        }
        self.activityIndicatorView = SMCustomActivityIndicatorView(frame: CGRectMake(0, 88, screenWidth, screenHeight - 88))
        self.activityIndicatorView.messageStr = messageStr
        self.activityIndicatorView.setUpView()
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(self.activityIndicatorView)
    }
    
    @objc static func showErrorProcessView(errorStr : String){
        let topViewController = UIViewController.getCurrentViewController()
        if topViewController == nil {
            return
        }
        if self.errorIndicatorView != nil {
            self.errorIndicatorView.removeFromSuperview()
        }
        self.errorIndicatorView = SMCustomActivityIndicatorView(frame: topViewController!.view.bounds)
        self.errorIndicatorView.messageStr = errorStr
        self.errorIndicatorView.setUpErrorView()
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(self.errorIndicatorView)
        
        self.dismissErrorActivityView(delayTime: 1.5)
    }
    
    @objc static func showSuccessProcessView(errorStr : String){
        let topViewController = UIViewController.getCurrentViewController()
        if topViewController == nil {
            return
        }
        if self.successIndicatorView != nil {
            self.successIndicatorView.removeFromSuperview()
        }
        self.successIndicatorView = SMCustomActivityIndicatorView(frame: topViewController!.view.bounds)
        self.successIndicatorView.messageStr = errorStr
        self.successIndicatorView.setUpSuccessView()
        
        let appdelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.addSubview(self.successIndicatorView)
        
        self.dismissSuccessActivityView(delayTime: 1.5)
    }
    
    @objc static func dismissActivityView(delayTime : CGFloat = 0.0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            if self.activityIndicatorView != nil {
                self.activityIndicatorView.removeFromSuperview()
            }
        }
    }

    @objc static func dismissSuccessActivityView(delayTime : CGFloat = 0.0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            self.successIndicatorView.removeFromSuperview()
        }
    }
    
    @objc static func dismissErrorActivityView(delayTime : CGFloat = 0.0){
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
            self.errorIndicatorView.removeFromSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
            
    }
        
    func setUpView(){
        self.backgroundColor = UIColor.clear
        
        self.grayBgView = UIView()
        self.grayBgView.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.5)
        self.grayBgView.layer.cornerRadius = 12
        self.addSubview(self.grayBgView)
        self.grayBgView.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            make?.centerY.equalTo()(self)?.offset()(-60)
        }
        
        self.activityIndicatorImageView = UIImageView()
        self.activityIndicatorImageView.image = UIImage(named: "activityIndicatorIcon")
        self.grayBgView.addSubview(self.activityIndicatorImageView)
        self.activityIndicatorImageView.mas_makeConstraints { make in
            make?.top.offset()(16)
            make?.width.equalTo()(20)
            make?.height.equalTo()(20)
            make?.centerX.equalTo()(self.grayBgView)
        }
        self.startRotationAnimation()
        
        self.activityIndicatorLabel = UILabel()
        self.activityIndicatorLabel.text = self.messageStr
        self.activityIndicatorLabel.textColor = UIColor.white
        self.activityIndicatorLabel.font = UIFont.systemFont(ofSize: 14)
        self.grayBgView.addSubview(self.activityIndicatorLabel)
        self.activityIndicatorLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.activityIndicatorImageView.mas_bottom)?.offset()(10)
            make?.left.offset()(14)
            make?.right.offset()(-14)
            make?.bottom.offset()(-16)
        }
    }
    
    func startRotationAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 0.5
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.activityIndicatorImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func setUpErrorView(){
        self.backgroundColor = UIColor.clear
        
        self.grayBgView = UIView()
        self.grayBgView.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.5)
        self.grayBgView.layer.cornerRadius = 12
        self.addSubview(self.grayBgView)
        self.grayBgView.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            make?.centerY.equalTo()(self)?.offset()(-60)
        }
        
        self.activityIndicatorImageView = UIImageView()
        self.activityIndicatorImageView.image = UIImage(named: "errorIcon")
        self.grayBgView.addSubview(self.activityIndicatorImageView)
        self.activityIndicatorImageView.mas_makeConstraints { make in
            make?.top.offset()(16)
            make?.width.equalTo()(20)
            make?.height.equalTo()(20)
            make?.centerX.equalTo()(self.grayBgView)
        }
        
        self.activityIndicatorLabel = UILabel()
        self.activityIndicatorLabel.numberOfLines = 0
        self.activityIndicatorLabel.textAlignment = .center
        self.activityIndicatorLabel.text = self.messageStr
        self.activityIndicatorLabel.textColor = UIColor.white
        self.activityIndicatorLabel.font = UIFont.systemFont(ofSize: 14)
        self.grayBgView.addSubview(self.activityIndicatorLabel)
        self.activityIndicatorLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.activityIndicatorImageView.mas_bottom)?.offset()(10)
            make?.left.offset()(14)
            make?.right.offset()(-14)
            make?.width.equalTo()(screenWidth / 2 + 40)
            make?.bottom.offset()(-16)
        }
    }
    
    func setUpSuccessView(){
        self.backgroundColor = UIColor.clear
        
        self.grayBgView = UIView()
        self.grayBgView.backgroundColor = UIColor(hex: "000000").withAlphaComponent(0.5)
        self.grayBgView.layer.cornerRadius = 12
        self.addSubview(self.grayBgView)
        self.grayBgView.mas_makeConstraints { make in
            make?.centerX.equalTo()(self)
            make?.centerY.equalTo()(self)?.offset()(-60)
        }
        
        self.activityIndicatorImageView = UIImageView()
        self.activityIndicatorImageView.image = UIImage(named: "correctIcon")
        self.grayBgView.addSubview(self.activityIndicatorImageView)
        self.activityIndicatorImageView.mas_makeConstraints { make in
            make?.top.offset()(16)
            make?.width.equalTo()(20)
            make?.height.equalTo()(20)
            make?.centerX.equalTo()(self.grayBgView)
        }
        
        self.activityIndicatorLabel = UILabel()
        self.activityIndicatorLabel.text = self.messageStr
        self.activityIndicatorLabel.textColor = UIColor.white
        self.activityIndicatorLabel.font = UIFont.systemFont(ofSize: 14)
        self.grayBgView.addSubview(self.activityIndicatorLabel)
        self.activityIndicatorLabel.mas_makeConstraints { make in
            make?.top.equalTo()(self.activityIndicatorImageView.mas_bottom)?.offset()(10)
            make?.left.offset()(14)
            make?.right.offset()(-14)
            make?.bottom.offset()(-16)
        }
    }
}
