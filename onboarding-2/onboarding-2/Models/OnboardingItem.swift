//
//  OnboardingItem.swift
//  onboarding-2
//
//  Created by Ted on 2021/03/09.
//

import UIKit

struct OnboardingItem {
    let title: String
    let detail: String
    let image: UIImage?
    
    static let placeholderItems: [OnboardingItem] = [
        .init(title: "Virgil Abloh",
              detail: "High and low isn't such a novelty thing, it's how young people interpret the life we've been given. It's how we look at luxury brands, it's how we look at heritage brands",
              image: UIImage(named: "1")),
        .init(title: "Lauren Hutton",
              detail: "Fashion is what you’re offered four times a year by designers. And style is what you choose.",
              image: UIImage(named: "2")),
        .init(title: "Karl Lagerfeld",
              detail: "One is never over-dressed or under-dressed with a Little Black Dress",
              image: UIImage(named: "3")),
        .init(title: "Christian Louboutin",
              detail: "Shoes transform your body language and attitude. They lift you physically and emotionally.",
              image: UIImage(named: "4")),
        .init(title: "Yves Saint Laurent",
              detail: "I have always believed that fashion was not only to make women more beautiful, but also to reassure them, give them confidence.",
              image: UIImage(named: "5"))
    ]
}
