//
//  Password+Constraint.swift
//  Ounce
//
//  Created by Junhyeon on 2020/07/04.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

import SnapKit

extension PasswordVC {
    func constraint() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationItem.backBarButtonItem = nil
        
        self.view.addSubview(guideLabel)
        self.view.addSubview(pwGuideLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(pwUnderBarView)
        self.view.addSubview(pwErrorGuiedLabel)
        self.view.addSubview(pwCertificationGuideLabel)
        self.view.addSubview(pwCertificationTextField)
        self.view.addSubview(pwCertificationUnderBarView)
        self.view.addSubview(pwCertificationErrorGuiedLabel)

        guideLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(88)
            make.leading.equalToSuperview().offset(116)
            make.width.equalToSuperview()
            make.height.equalTo(80)
        }
        
        pwGuideLabel.snp.makeConstraints { (make) in
            make.top.equalTo(guideLabel.snp.bottom).offset(45)
            make.leading.equalTo(guideLabel.snp.leading)
            make.width.equalTo(210)
            make.height.equalTo(24)
        }

        pwTextField.snp.makeConstraints { (make) in
            make.top.equalTo(pwGuideLabel.snp.bottom).offset(8)
            make.leading.equalTo(guideLabel.snp.leading).offset(6)
            make.trailing.equalTo(pwUnderBarView.snp.trailing)
            make.height.equalTo(24)
        }
        
        pwUnderBarView.snp.makeConstraints { (make) in
            make.top.equalTo(pwTextField.snp.bottom).offset(4)
            make.leading.equalTo(guideLabel.snp.leading)
            make.trailing.equalToSuperview().offset(86)
            make.height.equalTo(1)
        }
        
        pwErrorGuiedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pwUnderBarView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(pwUnderBarView.snp.trailing)
            make.height.equalTo(18)
        }
        
        pwCertificationGuideLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pwUnderBarView.snp.bottom).offset(25)
            make.leading.equalTo(guideLabel.snp.leading)
            make.width.equalTo(210)
            make.height.equalTo(24)
        }
        
        pwCertificationTextField.snp.makeConstraints { (make) in
            make.top.equalTo(pwCertificationGuideLabel.snp.bottom).offset(8)
            make.leading.equalTo(guideLabel.snp.leading).offset(6)
            make.trailing.equalTo(pwUnderBarView.snp.trailing)
            make.height.equalTo(24)
        }
        
        pwCertificationUnderBarView.snp.makeConstraints { (make) in
            make.top.equalTo(pwCertificationTextField.snp.bottom).offset(4)
            make.leading.equalTo(guideLabel.snp.leading)
            make.trailing.equalToSuperview().offset(86)
            make.height.equalTo(1)
        }
        
        pwCertificationErrorGuiedLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pwCertificationUnderBarView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(pwUnderBarView.snp.trailing)
            make.height.equalTo(18)
        }


    }

}
