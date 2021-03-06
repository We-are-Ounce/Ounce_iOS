//
//  SearchCollectVC.swift
//  Ounce
//
//  Created by 이윤진 on 2020/07/07.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit
import CoreData

import SwiftKeychainWrapper

class SearchCollectVC: UIViewController{
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //private var productInformations:[Product] = []
    private var product:[CatProduct] = []
    private var filteredProduct:[FilteredCatProduct] = []
    var pageIndex = [1,10]
    let profileIndex: Int = KeychainWrapper.standard.integer(forKey: "currentProfile") ?? 0
    var rootVC: UIViewController?
    var searchResult: String?
    var recodeObject: [NSManagedObject] = []
    let con = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(profileIndex)
        /*네비게이션 바 뒤로가기 버튼 타이틀 없애는 코드~~~참고하세요^^,,,왜 버튼아이템을 만들어줘야할까...존나빡쳐...개빡쳐...엑코 뒤져*/
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        searchProduct(profileIndex ?? 0, searchResult ?? "")
        self.navigationItem.title = "기록하기"
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchTextField.tintColor = .black
    }
    
    @IBAction func searchBtnTouched(_ sender: Any) {
        
        searchProduct(profileIndex ,searchTextField.text ?? "")
        save(searchTextField.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = "기록하기"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationItem.title = ""
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        //let backButton = UIBarButtonItem()
        //backButton.title = ""
        //self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
    }
    
    
    func save(_ inputRecode: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Recode",
                                       in: managedContext)!
        
        let recode = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        recode.setValue(inputRecode, forKeyPath: "recode")
        recode.setValue(Date(), forKey: "time")
        
        // 4
        do {
            try managedContext.save()
            recodeObject.append(recode)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        
    }
}

extension SearchCollectVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return productInformations.count
        filteredProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectCell.identfier, for: indexPath) as? SearchCollectCell else {return UICollectionViewCell()}
        //itemCell.set(productInformations[indexPath.row])
        itemCell.setCell(filteredProduct[indexPath.row])
        return itemCell
    }
}

extension SearchCollectVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt
        indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width) / 2 ,height: (collectionView.frame.height)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 16, bottom: 8, right:16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        _ = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! SearchCollectCell
        let PostStoryBoard: UIStoryboard = UIStoryboard(name: "Post", bundle: nil)
        let pvc = PostStoryBoard.instantiateViewController(identifier: "PostVC") as PostVC
        //pvc.modalPresentationStyle = .fullScreen
        
        //pvc.product = product[indexPath.row]
        //pvc.foodMeat1 = product[indexPath.row].foodMeat
        pvc.foodIndexNumber = filteredProduct[indexPath.row].foodIdx
        pvc.foodDry = filteredProduct[indexPath.row].foodDry
        pvc.foodMeat1 = filteredProduct[indexPath.row].foodMeat1
        pvc.foodMeat2 = filteredProduct[indexPath.row].foodMeat2
        pvc.imageNameVC = filteredProduct[indexPath.row].foodImg
        pvc.companyNameVC = filteredProduct[indexPath.row].foodManu
        pvc.productNameVC = filteredProduct[indexPath.row].foodName
        
        self.navigationController?.pushViewController(pvc, animated: true)
        // 네비게이션 이동. pvc view로 이동
    }
    
    @objc func searchProduct(_ profileIdx: Int, _ result: String){
        print(#function)
        /*
         SearchService.shared.searchProduct(result, pageIndex[0], pageIndex[1])
         {(responseData) in switch responseData {
         case .success(let res) :
         let response = res as! [CatProduct]
         self.product = response
         print(self.product)
         DispatchQueue.main.async {
         self.searchCollectionView.reloadData()
         }
         self.searchCollectionView.reloadData()
         self.pageIndex[0] = self.pageIndex[1] + 1
         self.pageIndex[1] = self.pageIndex[1] + 10
         
         case .requestErr(_):
         print("requestErr")
         case .pathErr:
         print("pathErr")
         case .serverErr:
         print("serverErr")
         case .networkFail :
         print("networkFail")
         }
         
         
         }*/
        SearchService.shared.searchToWrite(profileIdx, result, pageIndex[0], pageIndex[1]){(responseData) in switch responseData {
        case.success(let res) :
            let response = res as! [FilteredCatProduct]
            self.filteredProduct = response
            print(self.filteredProduct)
            DispatchQueue.main.async{
                self.searchCollectionView.reloadData()
            }
            self.searchCollectionView.reloadData() // pageindex 값 바꾸기
            self.pageIndex[0] = self.pageIndex[1] + 1
            self.pageIndex[1] = self.pageIndex[1] + 10
        case.requestErr(_):
            print("requestErr")
        case .pathErr:
            print("pathErr")
            print("??")
        case .serverErr:
            print("serverErr")
        case .networkFail:
            print("networkFail")
            }
        }
    }
}

