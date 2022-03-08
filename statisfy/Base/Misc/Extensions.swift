//
//  Extensions.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import UIKit
import SwiftUI

let imageCache = NSCache<AnyObject, AnyObject>()



extension UIImage {
    
    func downSample(width: CGFloat) -> UIImage {
        let aspectRatio = self.size.height / self.size.width
        let newWidth = width
        let newHeight = newWidth * aspectRatio
        let newSize = CGSize(width: newWidth, height: newHeight)
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage ?? self
    }
}
