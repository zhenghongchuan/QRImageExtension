//
//  UIImage+QR.swift
//  QRWarehouse
//
//  Created by 郑鸿川 on 2017/2/6.
//  Copyright © 2017年 郑鸿川. All rights reserved.
//

import UIKit

extension String {
    func getQRImageWithString() -> UIImage {
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        
        let data = self.data(using: String.Encoding.utf8)
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        
        var image = filter?.outputImage
        
        let transform = CGAffineTransform(scaleX: 20, y: 20)
        image = image?.applying(transform)
        
        let resultImage = UIImage(ciImage: image!)
        
        return resultImage;
    }
    
    /// 拉大图片保证清晰度
    ///
    /// - Parameters:
    ///   - sourceImage: 源图片
    ///   - center: 图片中心
    /// - Returns: 拉大后的图片
    private func getNewImage(sourceImage: UIImage, center: UIImage) -> UIImage {
        
        let size = sourceImage.size
        UIGraphicsBeginImageContext(size)
        sourceImage.draw(in: CGRect.init(x: 0, y: 0, width: 20, height: 20))

        let width: CGFloat = 80
        let height: CGFloat = 80
        let x: CGFloat = (size.width - width) * 0.5
        let y: CGFloat = (size.height - height) * 0.5
        center.draw(in: CGRect.init(x: x, y: y, width: width, height: height))
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage!
    }


}
