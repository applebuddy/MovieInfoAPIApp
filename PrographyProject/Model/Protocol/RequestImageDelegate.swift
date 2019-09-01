//
//  RequestImageDelegate.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 01/09/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

protocol RequestImageDelegate: class {
    func imageRequestDidBegin()
    func imageRequestDidFinished(_ requestImage: UIImage)
    func imageRequestDidError(_ errorDescription: String)
}
