//
//  RequestAPIDelegate.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 30/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

protocol RequestMovieAPIDelegate: class {
    func movieRequestDidBegin(_ requestAPI: RequestAPI)
    func movieRequestDidFinished(_ requestAPI: RequestAPI)
    func movieRequestDidError(_ requestAPI: RequestAPI, _ errorDescription: String)
}
