//
//  OnboardingViewController.swift
//  onboarding-2
//
//  Created by Ted on 2021/03/09.
//

import UIKit
import SnapKit

private let cellId = "collectionCell"

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    
    private var items: [OnboardingItem] = []
    private var imageViews = [UIImageView]()
    
    private var collectionView: UICollectionView!
    
    private var collectionViewWidth: CGFloat {
        return collectionView.frame.size.width
    }
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var nextButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = UIFont(name: "Bangla Sangam MN", size: 17)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var pageControl: UIPageControl = {
        let page = UIPageControl()
        return page
    }()
    
    private var exploreButton: UIButton = {
        var button = UIButton()
        button.titleLabel?.font = UIFont(name: "Bangla Sangam MN", size: 17)
        button.setTitle("Explore", for: .normal)
        button.setTitleColor(.init(white: 1, alpha: 0.8), for: .normal)
        button.backgroundColor = .black
        button.alpha = 0.8
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(explorebuttonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        configureUI()
        setupPlaceholderItems()
        setupPageControl()
        setupImageViews()
    }
    
    //MARK: - Selectors
    
    @objc func nextButtonTapped() {
        let nextRow = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        showItem(at: nextRow)
    }
    
    @objc func explorebuttonTapped() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Helpers
    
    private func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    
    private func setupImageViews() {
        items.forEach { item in
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            imageView.clipsToBounds = true
            
            containerView.addSubview(imageView)
            
            imageView.snp.makeConstraints { (make) -> Void in
                make.leading.trailing.bottom.equalTo(containerView).inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
                make.height.equalToSuperview().multipliedBy(0.8)
            }
            
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(collectionView)
    }
    
    private func showItem(at index: Int) {
        pageControl.currentPage = index
        let shouldShow = index == items.count - 1
        nextButton.isHidden = shouldShow
        exploreButton.isHidden = !shouldShow
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    private func setupPlaceholderItems() {
        items = OnboardingItem.placeholderItems
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: view.frame.width, height: 700)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nextButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(exploreButton)
        
        exploreButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(containerView.snp.bottom).offset(-40)
            make.size.equalTo(CGSize(width: 250, height: 50))
            make.centerX.equalToSuperview()
        }
        
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CollectionViewCell
        let item = items[indexPath.item]
        cell.titleLabel.text = item.title
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(index)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        let canShow = (index < items.count - 1)
        
        guard canShow else { return }
        
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
    
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
