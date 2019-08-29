//
//  UILabel+.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

extension UILabel {
    /// * 라벨 잘림 발생 시 폰트 조절
    func adjustFontSizeWhenTruncated() {
        if adjustsFontSizeToFitWidth == false {
            adjustsFontSizeToFitWidth.toggle()
        }
    }

    /// * 타이틀 라벨의 라인 수 정의
    func titleNumberOfLines() {
        numberOfLines = 2
    }
}
