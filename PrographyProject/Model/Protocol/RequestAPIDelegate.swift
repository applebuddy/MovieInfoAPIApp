//
//  RequestAPIDelegate.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

protocol RequestMovieAPIDelegate: class {
    func movieRequestDidBegin()
    func movieRequestDidFinished()
    func movieRequestDidError(_ errorDescription: String)
}
