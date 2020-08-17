//
//  CustomLoader.swift
//  WisdomTechnical
//
//  Created by Bheem Sen Yadav on 17/08/20.
//  Copyright © 2020 Sandhya Yadav. All rights reserved.
//

import UIKit

class CustomLoader: UIView {
    static let instance = CustomLoader()

    var viewColor: UIColor = .black
    var setAlpha: CGFloat = 0.5
    var gifName: String = ""

    lazy var transparentView: UIView = {
        let transparentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        transparentView.backgroundColor = viewColor.withAlphaComponent(setAlpha)
        transparentView.isUserInteractionEnabled = false
        return transparentView
    }()

    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 40))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparentView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: gifName)
        return gifImage
    }()

    func showLoaderView() {
        addSubview(transparentView)
        transparentView.addSubview(gifImage)
        transparentView.bringSubviewToFront(gifImage)
        let keyWindow = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter { $0.isKeyWindow }.first
        keyWindow?.addSubview(transparentView)
    }

    func hideLoaderView() {
        transparentView.removeFromSuperview()
    }
}
