//
//  SortingVC.swift
//  Ounce
//
//  Created by 박주연 on 2020/07/10.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

class SortingVC: UIViewController {
    
    @IBOutlet var backView: UIView!
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var sortingTV: UITableView!
    @IBOutlet weak var touchView: UIView!
    @IBOutlet weak var tableViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var sortingList = ["날짜순", "기호도순", "총점순"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortingTV.delegate = self
        sortingTV.dataSource = self
        
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.backgroundDismiss()
        
        self.sortingTV.separatorStyle = UITableViewCell.SeparatorStyle.none
        if sortingList.count == 2 {
            tableViewHeightLayoutConstraint.constant = 155
        }
    }
    
    // MARK: - 아래서 위로 올라오는 그런 뷰,,
    func backgroundDismiss(){
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.backgroundTap(_:))))
    }
    
    
    @IBAction func backgroundTap(_ sender: UITapGestureRecognizer){
        self.dismiss(animated: false, completion: nil)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }

}


extension SortingVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sortingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sortingCell = sortingTV.dequeueReusableCell(withIdentifier: "SortingCell", for: indexPath) as! SortingCell
        sortingCell.constraint()
        sortingCell.sortLabel.text = sortingList[indexPath.row]
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        sortingCell.selectedBackgroundView = bgColorView

//        if sortingList[indexPath.row] == "날짜 순" {
//            sortingCell.backgroundColor = .black
//            sortingCell.textLabel?.textColor = .putty
//        }
//        else if sortingList[indexPath.row] == "기호도 순" {
//
//            sortingCell.backgroundColor = .white
//            sortingCell.textLabel?.textColor = .putty
//
//        }
//        else {
//
//            sortingCell.backgroundColor = .white
//            sortingCell.textLabel?.textColor = .putty
//        }
        return sortingCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         return 44
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // indexPath row 별로 데이터 보내기
    }
    
}

