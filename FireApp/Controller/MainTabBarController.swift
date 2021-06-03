//
//  MainTabBarController.swift
//  FireApp
//
//  Created by Ayuki Nishioka on 2021/06/02.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.delegate = self
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 現在配置されているUITabBarからUIImageViewを取得して配列にする
        let targetClass: AnyClass = NSClassFromString("UITabBarButton")!
        let tabBarViews = tabBar.subviews.filter{ $0.isKind(of: targetClass) }
        let tabBarImageViews = tabBarViews.map{ $0.subviews.first as! UIImageView }
        // アイコン画像をバウンドさせるようなアニメーション
        UIView.animateKeyframes(withDuration: 0.18, delay: 0.0, options: [.autoreverse], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1.0, animations: {
                // tabBarImageViewsのサイズを1.2倍にする
                tabBarImageViews[item.tag].transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })
            UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 1.0, animations: {
                // tabBarImageViewsのサイズを元に戻す
                tabBarImageViews[item.tag].transform = CGAffineTransform.identity
            })
        })
    }
        
}

private extension MainTabBarController {
    // タブバーのセットアップ
    func setup() {
        var viewControllers = [UIViewController]()
        
        if let fireViewController = UIStoryboard(name: "Fire", bundle: nil).instantiateInitialViewController() {
            fireViewController.tabBarItem = UITabBarItem(title: "FIRE", image: UIImage(named: "fire"), tag: 0)
            viewControllers.append(fireViewController)
        }
        
        if let lifeViewController = UIStoryboard(name: "Life", bundle: nil).instantiateInitialViewController() {
            lifeViewController.tabBarItem =  UITabBarItem(title: "生活費", image: UIImage(named: "life"), tag: 1)
            viewControllers.append(lifeViewController)
        }
        
        if let investmentViewController = UIStoryboard(name: "Investment", bundle: nil).instantiateInitialViewController() {
            investmentViewController.tabBarItem =  UITabBarItem(title: "投資金額", image: UIImage(named: "investment"), tag: 2)
            viewControllers.append(investmentViewController)
        }
        
        self.setViewControllers(viewControllers, animated: false)
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 現在選択されているViewController、指定されたViewControllerを取得
        guard let fromView = selectedViewController?.view,
              let toView = viewController.view else {
            return false
        }
        // ViewControllerの切り替えアニメーション
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }

}
