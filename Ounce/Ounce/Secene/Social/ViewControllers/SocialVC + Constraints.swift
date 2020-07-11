//
//  SocialVC + Constraints.swift
//  Ounce
//
//  Created by psychehose on 2020/07/11.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

extension SocialVC {
    
    
    func set() {
        self.view.addSubview(contentView)
        self.contentView.addSubview(tabCV)
        self.contentView.addSubview(catNameLabel)
        self.contentView.addSubview(pageCV)
        
        tabCV.delegate = self
        tabCV.dataSource = self
        pageCV.delegate = self
        pageCV.dataSource = self
        
        contentView.snp.makeConstraints{( make ) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        catNameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(contentView.snp.top).inset(9)
            make.leading.equalTo(contentView.snp.leading).inset(165)
            make.trailing.equalTo(contentView.snp.trailing).inset(165)
            make.height.equalTo(24)
        }
        tabCV.snp.makeConstraints{ ( make ) in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.height.equalTo(48)
            make.top.equalTo(catNameLabel.snp.bottom).inset(-10)
        }
        pageCV.snp.makeConstraints{ ( make ) in
            make.top.equalTo(tabCV.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
}