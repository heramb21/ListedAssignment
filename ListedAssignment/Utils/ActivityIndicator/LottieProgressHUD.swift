//
//  LottieProgressHUD.swift
//  ListedAssignment
//
//  Created by Heramb on 05/03/23.
//

import Foundation
import Lottie
import UIKit

class LottieProgressHUD: UIView {
    static let shared = LottieProgressHUD()
    let hudView: UIView
    var animationView: LottieAnimationView
    //options
    var hudWidth:CGFloat    = 150
    var hudHeight:CGFloat   = 150
    var hudBackgroundColor  = UIColor.white
    var animationFileName   = "splash"
    var borderWidth1:CGFloat = 1
    var borderColor1 = UIColor.white.withAlphaComponent(0.7).cgColor
    var borderRadius:CGFloat = 15
    override init(frame: CGRect) {
        self.hudView = UIView()
        self.animationView = LottieAnimationView()
        super.init(frame: frame)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        self.hudView = UIView()
        self.animationView = LottieAnimationView()
        super.init(coder: aDecoder)
        self.setup()
    }
    func setup() {
        self.addSubview(hudView)
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.animationView.removeFromSuperview()
            let width: CGFloat  = superview.frame.width
            let height: CGFloat = superview.frame.height
            self.frame = CGRect(x: (superview.frame.size.width / 2) - (width / 2),y: (superview.frame.height / 2) - (height / 2), width: width, height: height + 60)
            hudView.frame = self.bounds
            hudView.backgroundColor = self.hudBackgroundColor
            layer.borderColor = self.borderColor1
            layer.borderWidth = self.borderWidth1
            layer.cornerRadius  = self.borderRadius
            layer.masksToBounds = true
            self.animationView = LottieAnimationView(name: self.animationFileName)
            self.animationView.frame = CGRect(x:(superview.frame.size.width / 2 - 100),y: (superview.bounds.height / 2 - 100), width:200, height:200)
            self.animationView.contentMode = .scaleAspectFill
            self.hudView.addSubview(animationView)
            self.animationView.loopMode = .loop
            self.animationView.animationSpeed = 1.4
            self.animationView.play()
            self.hide()
        }
    }
    
    func show() {
        DispatchQueue.main.async {
            self.isHidden = false
        }
    }
    func hide() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isHidden = true
        }
    }
}

