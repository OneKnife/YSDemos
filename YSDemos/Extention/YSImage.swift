//
//  YSImage.swift
//  YSDemos
//
//  Created by 赵一超 on 2018/12/19.
//  Copyright © 2018年 melody. All rights reserved.
//

import UIKit

enum YSWaterMarkPosition {
    case topLeft(top: CGFloat, left: CGFloat)
    case topRight(top: CGFloat, right: CGFloat)
    case bottomLeft(bottom: CGFloat, left: CGFloat)
    case bottomRight(bottom: CGFloat, right: CGFloat)
}

extension UIImage {
    
    /// 增加水印文字
    func waterTextImage(with attributedString: NSAttributedString, position: YSWaterMarkPosition) -> UIImage? {
        let textSize = attributedString.size()
        let textRect = getRect(withSize: textSize, position: position)
        return waterTextImage(with: attributedString, rect: textRect)
    }
    
    /// 增加水印图片
    func waterIconImage(waterImage: UIImage, position: YSWaterMarkPosition) -> UIImage? {
        let waterSize = waterImage.size
        let waterRect = getRect(withSize: waterSize, position: position)
        return waterIconImage(with: waterImage, rect: waterRect)
    }
    
    func waterTextImage(with attributedString: NSAttributedString, rect: CGRect) -> UIImage? {
        /*
         * 开启图像上下文
         * 参数一: 指定将来创建出来的bitmap的大小
         * 参数二: 设置透明YES代表透明，NO代表不透明
         * 参数三: 代表缩放,0代表不缩放
         */
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        self.draw(in: CGRect.init(origin: .init(x: 0, y: 0), size: self.size))
        attributedString.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func waterIconImage(with waterImage: UIImage, rect: CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        self.draw(in: CGRect.init(origin: .init(x: 0, y: 0), size: self.size))
        waterImage.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    private func getRect(withSize waterSize: CGSize, position: YSWaterMarkPosition) -> CGRect {
        var rect: CGRect = CGRect.zero
        if case let YSWaterMarkPosition.topLeft(top: top, left: left) = position {
            rect = CGRect.init(x: left, y: top, width: waterSize.width, height: waterSize.height)
        }else if case let YSWaterMarkPosition.topRight(top: top, right: right) = position {
            rect = CGRect.init(x: self.size.width - waterSize.width - right, y: top, width: waterSize.width, height: waterSize.height)
        }else if case let YSWaterMarkPosition.bottomLeft(bottom: bottom, left: left) = position {
            rect = CGRect.init(x: left, y: self.size.height - waterSize.height - bottom, width: waterSize.width, height: waterSize.height)
        }else if case let YSWaterMarkPosition.bottomRight(bottom: bottom, right: right) = position {
            rect = CGRect.init(x: self.size.width - waterSize.width - right, y: self.size.height - waterSize.height - bottom, width: waterSize.width, height: waterSize.height)
        }
        return rect
    }
    
}


