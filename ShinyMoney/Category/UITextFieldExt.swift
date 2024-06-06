//
//  UITextFieldExt.swift
//  LuckyPesoProject
//
//  Created by Apple on 2023/11/30.
//

import UIKit
private var TextFieldToolBarParamKey = "TextFieldToolBarParamKey"
extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    var toolBar: UIToolbar? {
        set(toolBar) {
            objc_setAssociatedObject(self, &TextFieldToolBarParamKey, toolBar, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &TextFieldToolBarParamKey) as? UIToolbar
        }
    }

    func showToolBar() {
        setupToolBar()
        self.inputAccessoryView = toolBar
    }

    func setupToolBar() {
        toolBar = UIToolbar()
        
        let spaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneItemDidClick))
        
        toolBar?.sizeToFit()
        toolBar?.items = [spaceItem, doneItem]
    }

    @objc func doneItemDidClick() {
        self.resignFirstResponder()
    }
}
