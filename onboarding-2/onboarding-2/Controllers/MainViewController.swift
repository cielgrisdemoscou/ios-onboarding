//
//  MainViewController.swift
//  onboarding-2
//
//  Created by Ted on 2021/03/10.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

private var label: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 30)
    label.text = "MainViewController"
    return label
}()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(label)
    
    label.snp.makeConstraints { (make) -> Void in
        make.centerX.centerY.equalToSuperview()
    }
}

}
