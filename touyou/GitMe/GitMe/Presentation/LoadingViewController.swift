//
//  LoadingViewController.swift
//  GitMe
//
//  Created by 藤井陽介 on 2018/02/09.
//  Copyright © 2018 touyou. All rights reserved.
//

import UIKit
import Nuke

// MARK: - LoadingViewController

class LoadingViewController: UIViewController {

    // MARK: Internal

    var userInfo: UserInfoViewModel!

    // MARK: Life Cycle

    override func viewDidAppear(_ animated: Bool) {

        loginNameLabel.text = "\(userInfo.userName ?? "unknown")でログインします"
        let options = ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "placeholder"))
        Nuke.loadImage(with: userInfo.iconUrl, options: options, into: loginIconImageView)
    }

    // MARK: Private

    @IBOutlet weak var loginNameLabel: UILabel!
    @IBOutlet weak var loginIconImageView: UIImageView! {

        didSet {

            loginIconImageView.cornerRadius = loginIconImageView.frame.width / 2
            loginIconImageView.clipsToBounds = true
        }
    }
}

// MARK: - Storyboard Instantiable

extension LoadingViewController: StoryboardInstantiable {}

