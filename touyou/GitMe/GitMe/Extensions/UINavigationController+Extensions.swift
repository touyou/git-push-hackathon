//
//  UINavigationController+Extensions.swift
//  GitMe
//
//  Created by 藤井陽介 on 2018/02/09.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit

// MARK: - Project Layout

extension UINavigationController {

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setupBarColor() {

        self.navigationBar.barTintColor = UIColor.GitMe.darkGray
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "URWDIN-Light", size: 20.0) ?? UIFont.boldSystemFont(ofSize: 20.0)]
        self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "URWDIN-Light", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)]
        self.navigationBar.backgroundColor = UIColor.GitMe.darkGray
        self.navigationBar.prefersLargeTitles = true

        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor.GitMe.darkGray
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "URWDIN-Light", size: 20.0) ?? UIFont.boldSystemFont(ofSize: 20.0)]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont(name: "URWDIN-Light", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)]
            self.navigationBar.scrollEdgeAppearance = appearance
            self.navigationBar.standardAppearance = appearance
        }
    }
}
