//
//  SearchCollectCell.swift
//  Ounce
//
//  Created by 이윤진 on 2020/07/07.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

class SearchCollectCell: UICollectionViewCell{
    
    
    static let identfier = "productCell"
    
    var rootVC: UIViewController?
    var catproduct: CatProduct?
   
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var manufacturerName: UILabel!
    
    
    func setCell(_ productInfo:CatProduct ){
        
        productImageView.setImage(from: productInfo.foodImg )
        manufacturerName.text = productInfo.foodManu
        productName.text = productInfo.foodName
        
    }
    
    
    
    
}
