//
//  OnboardingViewController.swift
//  onboarding-3
//
//  Created by Ted on 2021/03/14.
//

import UIKit
import SnapKit
import AVFoundation
import Combine

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private let notificationCenter = NotificationCenter.default
    private var appEventSubsribers = [AnyCancellable]()
    
    private var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.1)
        return view
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        return view
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Life is either a daring adventure or nothing at all"
        return label
    }()
    
    private var startButton: UIButton = {
        var button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 58/255, green: 99/255, blue: 81/255, alpha: 1/1)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        observeAppEvents()
        setupPlayerIfNeeded()
        restartVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeAppEventsSubscribers()
        removePlayer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func startButtonTapped() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - Helpers
    
    private func buildPlayer() -> AVPlayer? {
        guard let filePath = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else { return nil }
        let url = URL(fileURLWithPath: filePath)
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        player.isMuted = true
        return player
    }
    
    private func buildPlayerLayer() -> AVPlayerLayer? {
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    private func playVideo() {
        player?.play()
    }
    
    private func restartVideo() {
        player?.seek(to: .zero)
        playVideo()
    }
    
    private func pauseVideo() {
        player?.pause()
    }
    
    private func setupPlayerIfNeeded() {
        player = buildPlayer()
        playerLayer = buildPlayerLayer()
        
        if let layer = self.playerLayer,
           view.layer.sublayers?.contains(layer) == false {
                view.layer.insertSublayer(layer, at: 0)
            }
            
    }
    
    private func observeAppEvents() {
        
        notificationCenter.publisher(for: .AVPlayerItemDidPlayToEndTime).sink { [weak self] _ in
            self?.restartVideo()
        }.store(in: &appEventSubsribers)
        
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification).sink { [weak self] _ in
            self?.pauseVideo()
        }.store(in: &appEventSubsribers)
        
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification).sink { [weak self] _ in
            self?.playVideo()
        }.store(in: &appEventSubsribers)
    }
    
    private func removeAppEventsSubscribers() {
        appEventSubsribers.forEach { subscriber in
            subscriber.cancel()
        }
    }
    
    private func removePlayer() {
        player?.pause()
        player = nil
        
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    private func configureUI() {
        view.addSubview(bgView)
        
        bgView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) -> Void in
            //make.centerX.equalToSuperview()
            make.center.equalToSuperview()
            //make.bottom.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 350, height: 150))
        }
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.bottom.equalTo(containerView).inset(UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15))
            make.height.equalTo(containerView).multipliedBy(0.3)
        }
        
        view.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.top.equalTo(containerView).inset(UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15))
        }
        
    }
    
}

