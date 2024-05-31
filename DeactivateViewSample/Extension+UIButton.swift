//
//  Extension+UIButton.swift
//  DeactivateViewSample
//
//  Created by Davidyoon on 5/31/24.
//

import UIKit

extension UIButton {
    private func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.setBackgroundImage(image(withColor: color), for: forState)
    }
}
