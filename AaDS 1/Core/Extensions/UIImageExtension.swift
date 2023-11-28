//
//  UIImageExtension.swift
//  AaDS 1
//
//  Created by Влад Тимчук on 23.11.2023.
//

import UIKit

extension UIImage {
    
    func addWatermark() -> UIImage {
        let image = self
        let size = image.size
        
        let mergedImage = UIGraphicsImageRenderer(size: size).image { context in
            let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            image.draw(in: areaSize)
            
            let watermarkImage = UIImage(named: "watermark")
            watermarkImage?.draw(in: areaSize, blendMode: .normal, alpha: 0.4)
        }
        
        return mergedImage
    }
}
