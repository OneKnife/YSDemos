//
//  YSWatermarkController.swift
//  YSDemos
//
//  Created by 赵一超 on 2018/12/19.
//  Copyright © 2018年 melody. All rights reserved.
//

import UIKit

class YSWaterMarkController: UIViewController {
    var originImage: UIImage!
    var tapTime: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        let imagePath = Bundle.main.path(forResource: "bg_image", ofType: "jpeg")
        originImage = UIImage.init(contentsOfFile: imagePath!)!
        
        imageView.image = originImage
        self.view.addSubview(imageView)
        
        let rightBarButton = UIBarButtonItem.init(title: "点我", style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func rightButtonTapped(){
        if tapTime == 0 {
            waterText()
            tapTime = 1
        }else if tapTime == 1 {
            waterImage()
            tapTime = 0
        }
    }
    
    // 水印字符串
    func waterText() {
        // 为保证显示出的字体大小不变
        let fontSize = originImage.size.width / 375 * 14
        let attrStr = NSAttributedString.init(string: "powered by ysir", attributes: [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize),
            NSAttributedStringKey.foregroundColor: UIColor.white
            ])
        let waterImage = originImage.waterTextImage(with: attrStr, position: YSWaterMarkPosition.bottomRight(bottom: 10, right: 10))
        imageView.image = waterImage
    }
    
    // 水印图片
    func waterImage() {
        let logoPath = Bundle.main.path(forResource: "water_image", ofType: "png")!
        let logoImage = UIImage.init(contentsOfFile: logoPath)!
        let waterImage = originImage.waterIconImage(waterImage: logoImage, position: YSWaterMarkPosition.bottomLeft(bottom: 10, left: 10))
        imageView.image = waterImage
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}
