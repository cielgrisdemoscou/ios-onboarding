//
//  OnboardingItem.swift
//  onboarding-1
//
//  Created by Ted on 2021/03/08.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let bgImage: UIImage?
    
    static let placeholderItems: [OnboardingItem] = [
        .init(title: "Travel Your Way",
              detail: "Travel the world by air, rail or the most competitve prices",
              bgImage: UIImage(named: "plane")),
        .init(title: "Stay Your Way",
              detail: "With over millions of hotels worldwide, find the perfect accomodation in the most amazing places",
              bgImage: UIImage(named: "hotel")),
        .init(title: "Discover Your Way",
              detail: "Explore exotic destination with our new features that link you want to like-minded travaillers",
              bgImage: UIImage(named: "travel")),
        .init(title: "Feast Your Ways",
              detail: "We recommend your local cuisines that are safe and highly recommended by the locals",
              bgImage: UIImage(named: "food"))
    ]
}
