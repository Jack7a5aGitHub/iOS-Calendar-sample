//
//  UIStoryboard+Instance.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Storyboardからインスタンスを取得する
    class func viewController <T: UIViewController> (storyboardName: String, identifier: String) -> T? {
        
        return UIStoryboard(name: storyboardName, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? T
    }
}
