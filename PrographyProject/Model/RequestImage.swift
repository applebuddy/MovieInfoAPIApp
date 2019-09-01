//
//  RequestThumbnailImage.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 01/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class RequestImage {
    static let shared = RequestImage()

    weak var delegate: RequestImageDelegate?

    func setImageFromCache(_ thumbnailImageURLString: String, placeHolder: UIImage) -> UIImage {
        if let cachedImage = MovieCommonData.shared.thumbnailImageCache.object(forKey: NSString(string: thumbnailImageURLString)) {
            // 이미지셋팅 후 작업을 마친다. 이미지캐시가 없다면 URL에 대한 데이터처리를 준비한다.
            return cachedImage
        } else {
            return placeHolder
        }
    }

    // UIImageView객체 내 추가로 URL에따른 데이터 요청 및 이미지 설정 메서드를 추가한다.
    // 인자값으로 URL값과 Default Image(placeHolder)값을 받는다.
    func setImageFromServerURL(_ thumbnailImageURLString: String, placeHolder: UIImage?, completion: @escaping (UIImage?) -> Void) {
        delegate?.imageRequestDidBegin()

        // 인자값으로 받은 URL에 대한 이미지가 이미 있다면,
        if let cachedImage = MovieCommonData.shared.thumbnailImageCache.object(forKey: NSString(string: thumbnailImageURLString)) {
            // 이미지셋팅 후 작업을 마친다. 이미지캐시가 없다면 URL에 대한 데이터처리를 준비한다.
            delegate?.imageRequestDidFinished(cachedImage)
            completion(cachedImage)
        }

        // 인자값으로 받은 URL에 URLSession을 통해 이미지를 요청한다.
        if let imageUrl = URL(string: thumbnailImageURLString) {
            URLSession.shared.dataTask(with: imageUrl, completionHandler: { data, _, error in

                // 4) 데이터요청간 에러가있다면 문구를 기록하고,
                //    => 처리할 이미지가 없으므로 Default이미지 값인 placeHolder값으로 이미지를 설정한다.
                if error != nil {
                    self.delegate?.imageRequestDidError("thumbnailImage URL Loading Error!: \(error?.localizedDescription ?? "")")
                    completion(placeHolder) // 이미지의 설정은 비동기 과정에서 진행한다.
                }

                // 5) 데이터요청 후 URL에 맞는 이미지데이터 요청이 성공하면 해당 이미지로 캐시이미지값을 설정하고 해당 imageView의 image로 셋팅한다.
                // 에러없이 thumbnailImageURL을 로딩했다면, 데이터 처리 후 이미지를 갱신한다.
                DispatchQueue.main.async {
                    // 처리할 데이터가 존재하면,
                    if let thumbnailImageData = data {
                        // 해당 데이터를 UIImage로 변환 후 이상이 없는지 확인한다.
                        if let thumbnailImage = UIImage(data: thumbnailImageData) {
                            // 이미지로 변환 후 문제가 없다면, 캐시이미지를 저장하는 thumbnailImageCache변수에 값으로 해당URL값(키)과 UIImage(값)을 저장한다.(이후 데이터요청에 앞서 저장된 이미지가 있는지 확인할때 사용한다.)
                            MovieCommonData.shared.thumbnailImageCache.setObject(thumbnailImage, forKey: NSString(string: thumbnailImageURLString))
                            // 캐시이미지저장 후 해당 이미지에 최종적으로 처리된 이미지를 셋팅한다.
                            self.delegate?.imageRequestDidFinished(thumbnailImage)
                            completion(thumbnailImage)
                        }
                    }
                }

            }).resume()
        }
    }
}
