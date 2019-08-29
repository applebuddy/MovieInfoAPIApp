//
//  RatingPickerView.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class RatingAlertController: UIAlertController {
    // MARK: - UI

    let ratingPickerView: UIPickerView = {
        let ratingPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        return ratingPickerView
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        makeSubviews()
        makeConstraints()
        makeAlertAction()
    }

    // MARK: - Setting

    private func makeAlertAction() {
        let ratingAlertAction = UIAlertAction(title: "선택", style: .default, handler: nil)
        addAction(ratingAlertAction)
    }

    private func makeSubviews() {
        view.addSubview(ratingPickerView)
    }

    private func makeConstraints() {
        ratingPickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratingPickerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            ratingPickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            ratingPickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            ratingPickerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
        ])
    }
}
