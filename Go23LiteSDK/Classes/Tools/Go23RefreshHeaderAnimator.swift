//
//  Go23RefreshHeaderAnimator.swift
//  Go23WalletSDKDemo
//
//  Created by luming on 2023/2/14.
//

import UIKit

class Go23RefreshHeaderAnimator: UIView , ESRefreshProtocol, ESRefreshAnimatorProtocol {
    
    public var insets: UIEdgeInsets = UIEdgeInsets.zero
    public var view: UIView { return self }
    public var trigger: CGFloat = 60.0
    public var executeIncremental: CGFloat = 60.0
    public var state: ESRefreshViewState = .pullToRefresh
    
    private var timer: Timer?
    private var timerProgress: Double = 0.0

    private let imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.image = Go23Helper.image(named: "headerRefresh")
        imageView.sizeToFit()
        let size = imageView.image?.size ?? CGSize.zero
        imageView.center = CGPoint.init(x: (UIScreen.main.bounds.size.width) / 4.0 - 40, y: -size.height)
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshAnimationBegin(view: ESRefreshComponent) {
        self.startAnimating()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            let size = self.imageView.image?.size ?? CGSize.zero
            self.imageView.center = CGPoint.init(x: (UIScreen.main.bounds.size.width) / 4.0 - 40, y: 16.0 + size.height / 2.0)
            }, completion: { (finished) in })
    }
    
    public func refreshAnimationEnd(view: ESRefreshComponent) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.imageView.transform = CGAffineTransform.identity
            self.imageView.center = CGPoint.init(x: (UIScreen.main.bounds.size.width) / 4.0 - 40, y: self.imageView.center.y + 10.0)
        }, completion: { (finished) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                let size = self.imageView.image?.size ?? CGSize.zero
                self.imageView.transform = CGAffineTransform.identity
                self.imageView.center = CGPoint.init(x: (UIScreen.main.bounds.size.width) / 4.0 - 40, y: -size.height)
            }, completion: { (finished) in
                self.stopAnimating()
            })
        })
    }
    
    public func refresh(view: ESRefreshComponent, progressDidChange progress: CGFloat) {
        let size = imageView.image?.size ?? CGSize.zero
        let p = min(1.0, max(0.0, progress))
        let y = (-self.trigger * progress) + 16.0 - (size.height + 16.0) * (1 - p)
        let center = CGPoint.init(x: (UIScreen.main.bounds.size.width) / 4.0 - 40, y: y + (size.height / 2.0))
        self.imageView.center = center
        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * progress)
    }
    
    public func refresh(view: ESRefreshComponent, stateDidChange state: ESRefreshViewState) {
        guard self.state != state else {
            return
        }
        self.state = state
    }

    @objc func timerAction() {
        timerProgress += 0.01
        self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) * CGFloat(timerProgress))
    }
    
    func startAnimating() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(Go23RefreshHeaderAnimator.timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    func stopAnimating() {
        if timer != nil {
            timerProgress = 0.0
            timer?.invalidate()
            timer = nil
        }
    }
    
}

