//
//  FlipAnimationController.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 09.10.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    private let originFrame: CGRect

    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        // 1
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        toVC.view.frame = originFrame
        toVC.view.layer.masksToBounds = true

        containerView.addSubview(toVC.view)
        AnimationHelper.perspectiveTransform(for: containerView)
        toVC.view.layer.transform = AnimationHelper.yRotation(.pi / 2)
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic,
            animations: {

                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1 / 2) {
                    fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
                }

                UIView.addKeyframe(withRelativeStartTime: 1 / 2, relativeDuration: 1 / 2) {
                    toVC.view.layer.transform = AnimationHelper.yRotation(0.0)
                }

            },
            completion: { _ in
                toVC.view.isHidden = false
                fromVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
    }
}
