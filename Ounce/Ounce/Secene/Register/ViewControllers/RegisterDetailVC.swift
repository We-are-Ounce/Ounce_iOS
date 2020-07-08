//
//  RegisterDetailVC.swift
//  Ounce
//
//  Created by Junhyeon on 2020/07/07.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

class RegisterDetailVC: UIViewController {
    
    // MARK: - UI components
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var neutralizationRoundButton: UIButton!
    @IBOutlet weak var neutralizationButton: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightButton: UITextField!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    // MARK: - Variables and Properties
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        setGuideLabel()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
}

// MARK: - Helpers 메소드 모두 따로 작성해주세요
extension RegisterDetailVC {
    @objc func didTapNextButton(){
        let sb = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "TBC") as! TBC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    func setGuideLabel() {
        let attrString = NSMutableAttributedString(string: "고양이의 정보를\n입력해주세요.")
        attrString.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                value: Font.signUpBigGuideLabel as Any, range: NSMakeRange(0, 7))
        guideLabel.attributedText = attrString
        guideLabel.numberOfLines = 2
    }
    
    func setButton() {
        maleButton.setRounded(radius: 8)
        maleButton.borderColor = .battleshipGrey
        maleButton.borderWidth = 1.5
        femaleButton.setRounded(radius: 8)
        femaleButton.borderColor = .battleshipGrey
        femaleButton.borderWidth = 1.5
        neutralizationRoundButton.setRounded(radius: nil)
    }
}
