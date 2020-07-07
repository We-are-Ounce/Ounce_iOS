//
//  BrowseVC.swift
//  Ounce
//
//  Created by Junhyeon on 2020/07/05.
//  Copyright © 2020 박주연. All rights reserved.
//

import UIKit

class BrowseVC: UIViewController{
    
    var collectionView: UICollectionView?
    
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.collectionView?.collectionViewLayout as! UpCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    let searchField = UITextField().then {
        $0.text = "검색어를 입력해주세요"
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14)
        
    }
    let searchView = UIView().then {
        
        $0.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    let searchImg = UIImageView().then {
        $0.image = UIImage(named: "icLook")
        $0.tintColor = .brownGreyColor
    }
    
    let guideNameLabel = UILabel().then{
        $0.font = UIFont.systemFont(ofSize: 30.0)
        let attributedStr = NSMutableAttributedString(string: "겨울이와 \n입맛이 비슷해요.")
    }

    var colors : [UIColor] = [.white, .white, .white, .white, .white]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCollectionView()
        self.setupLayout()
        self.setupCollectionLayout()
        self.setNameLabel()
        self.collectionView?.backgroundColor = .brownGreyColor
        self.collectionView?.showsHorizontalScrollIndicator = false
    }
    
    func setupLayout(){
        
        self.view.addSubview(searchView)
        self.searchView.addSubview(searchField)
        self.searchView.addSubview(searchImg)
        self.view.addSubview(guideNameLabel)
        
        searchImg.snp.makeConstraints { (make) in
            make.leading.equalTo(searchView.snp.leading).inset(11)
            make.top.equalTo(searchView.snp.top).inset(13)
            make.width.equalTo(17.5)
            make.height.equalTo(17.5)
        }
        
        searchField.snp.makeConstraints{(make) in
            make.leading.equalTo(searchImg.snp.trailing).inset(5)
            make.top.equalTo(searchView.snp.top).inset(12)
            make.bottom.equalTo(searchView.snp.bottom).inset(12)
            make.trailing.equalTo(searchView.snp.trailing).inset(182)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(17)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        
        guideNameLabel.snp.makeConstraints{( make ) in
            make.leading.equalToSuperview().inset(28)
            make.top.equalTo(searchView.snp.bottom).inset(-self.view.frame.height * 0.0874)
        }
    }
    
    // MARK: - collectiovView 조정
    
    func setupCollectionLayout(){
    
        //let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)
        
        self.collectionView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.collectionView?.topAnchor.constraint(equalTo: self.guideNameLabel.bottomAnchor,
                                                  constant: self.view.frame.height * 0.065).isActive = true
        self.collectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.collectionView?.heightAnchor.constraint(equalToConstant: 270).isActive = true
        self.currentPage = 0
    }
    

    func setNameLabel(){
        let attributedStr = NSMutableAttributedString(string: "겨울이와 \n입맛이 비슷해요.")
        attributedStr.addAttribute(NSAttributedString.Key(rawValue: kCTFontAttributeName as String),
                                value: Font.signUpBigGuideLabel as Any, range: NSMakeRange(0, 2))
        guideNameLabel.attributedText = attributedStr
        guideNameLabel.numberOfLines = 2
    }
    
    // MARK: - contentView size 조정
    
    func addCollectionView(){

//        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: self.view.frame.size)

        
        let layout = UpCarouselFlowLayout()
        
        layout.itemSize = CGSize(width: 219, height: 270)
        
        layout.scrollDirection = .horizontal

        // MARK: - Collection view initialization, the collectionView must be
        // MARK: - initialized with a layout object.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // MARK: - This line if for able programmatic constrains.
        
        self.collectionView?.translatesAutoresizingMaskIntoConstraints = false
        

        
        // MARK: - CollectionView delegates and dataSource:
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        
        // MARK: - Registering the class for the collection view cells
        
        self.collectionView?.register(BrowseCVCell.self, forCellWithReuseIdentifier: "cellId")

        // Spacing between cells:
        let spacingLayout = self.collectionView?.collectionViewLayout as! UpCarouselFlowLayout
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60)

        self.collectionView?.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView!)
        
        
    }

    // MARK: - Card Collection Delegate & DataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! BrowseCVCell

        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    // MARK: - UIScrollViewDelegate

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.collectionView?.collectionViewLayout as! UpCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }

}

class RelativeLayoutUtilityClass {

    var heightFrame: CGFloat?
    var widthFrame: CGFloat?

    init(referenceFrameSize: CGSize){
        heightFrame = referenceFrameSize.height
        widthFrame = referenceFrameSize.width
    }

    func relativeHeight(multiplier: CGFloat) -> CGFloat{

        return multiplier * self.heightFrame!
    }

    func relativeWidth(multiplier: CGFloat) -> CGFloat{
        return multiplier * self.widthFrame!

    }



}


extension BrowseVC: UICollectionViewDelegate { }

extension BrowseVC: UICollectionViewDataSource {
    
}

