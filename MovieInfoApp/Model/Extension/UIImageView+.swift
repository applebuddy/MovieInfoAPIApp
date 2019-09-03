
//
//  UIImageView.swift
//  MovieInfoApp
//
//  Created by MinKyeongTae on 31/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

extension UIImageView {
    func setThumbnailImageFromCache(_ thumbnailImageURLString: String, placeHolder: UIImage) {
        image = RequestImage.shared.setImageFromCache(
            thumbnailImageURLString,
            placeHolder: placeHolder
        )
    }

    func setThumbnailImageFromServerURL(_ thumbnailImageURLString: String, placeHolder: UIImage) {
        RequestImage.shared.setImageFromServerURL(thumbnailImageURLString, placeHolder: placeHolder) { image in
            self.image = image
        }
    }
}
