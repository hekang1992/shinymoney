//
//  SM_LaunchViewController.swift
//  ShinyMoney
//
//  Created by 李青 on 2024/5/29.
//

import UIKit

class SM_LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
