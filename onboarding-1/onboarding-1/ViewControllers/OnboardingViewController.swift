//
//  OnboardingViewController.swift
//  onboarding-1
//
//  Created by Ted on 2021/03/08.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    
    private var currentPage: Int = 0
    private var items: [OnboardingItem] = []
    
    private var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 0.5)
        return view
    }()
    
    private var pageControl: UIPageControl = {
        let page = UIPageControl()
        return page
    }()
    
    private var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.font = UIFont(name: "Bangla Sangam MN", size: 30)
        return label
    }()
    
    private var detailLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.font = UIFont(name: "Bangla Sangam MN", size: 20)
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupPlaceholderItems()
        setupPageControl()
        setupScreen(index: currentPage)
        setupGestures()
    }
    
    //MARK: - Selectors
    
    @objc private func handleTapAnimation() {
        self.view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.mainLabel.alpha = 0.5
            self.mainLabel.transform = CGAffineTransform(translationX: -20, y: 0)
            self.detailLabel.alpha = 0.5
            self.detailLabel.transform = CGAffineTransform(translationX: -20, y: 0)
        }, completion: { _ in
            self.currentPage += 1
            
            if self.isOverLastItem() {
                self.showMainApp()
            } else {
                self.setupScreen(index: self.currentPage)
            }
            
            self.view.isUserInteractionEnabled = true
        })
    }
    
    //MARK: - Helpers
    
    private func showMainApp() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    private func isOverLastItem() -> Bool {
        return currentPage == self.items.count
    }
    
    private func setupPlaceholderItems() {
        items = OnboardingItem.placeholderItems
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapAnimation))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupScreen(index: Int) {
        mainLabel.text = items[index].title
        detailLabel.text = items[index].detail
        updateBackgroundImage(index: index)
        pageControl.currentPage = index
        mainLabel.alpha = 1.0
        detailLabel.alpha = 1.0
        mainLabel.transform = .identity
        detailLabel.transform = .identity
    }
    
    private func updateBackgroundImage(index: Int) {
        let image = items[index].bgImage
        
        UIView.transition(with: bgImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.bgImageView.image = image
        }, completion: nil)
        
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
    private func configureUI() {
        view.addSubview(bgImageView)
        
        bgImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(darkView)
        
        darkView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
        }
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(pageControl.snp.top)
            make.leading.trailing.top.equalToSuperview()
        }
        
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        view.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
        }
        
        
//        let stack = UIStackView(arrangedSubviews: [mainLabel, detailLabel])
//        stack.axis = .vertical
//        stack.distribution = .fillEqually
//        stack.spacing = -20
//
//        view.addSubview(stack)
//
//        stack.snp.makeConstraints { (make) -> Void in
//            make.top.equalToSuperview().offset(100)
//            make.height.equalTo(250)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//        }
    }
}

