//
//  UILabel+.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

extension UILabel {
    func adjustFontSizeWhenTruncated() {
        if adjustsFontSizeToFitWidth == false {
            adjustsFontSizeToFitWidth.toggle()
        }
    }
}
