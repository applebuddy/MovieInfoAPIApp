//
//  ViewController.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: IBOutlet UI

    @IBOutlet private var ratingSelectButton: UIButton!
    @IBOutlet private var presentToMovieListButton: UIButton!

    // MARK: - UI

    private let ratingAlertController: RatingAlertController = {
        let ratingAlertController = RatingAlertController(title: "별점 선택", message: "별점을 선택해주시기 바랍니다.", preferredStyle: .actionSheet)
        return ratingAlertController
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureRatingAlertController()
        configurePresentToMovieListButton()
    }

    private func configureRatingAlertController() {
        ratingAlertController.ratingPickerView.delegate = self
        ratingAlertController.ratingPickerView.dataSource = self
        ratingAlertController.ratingPickerView.selectRow(5, inComponent: 0, animated: false)
    }

    private func configurePresentToMovieListButton() {
        presentToMovieListButton.layer.cornerRadius = 10
        presentToMovieListButton.layer.shadowRadius = 3
        presentToMovieListButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        presentToMovieListButton.layer.shadowOpacity = 1
    }

    // MARK: Present

    private func presentRatingPickerView() {
        present(ratingAlertController, animated: true, completion: nil)
    }

    // MARK: IBAction

    @IBAction private func ratingSelectButtonPressed(_: UIButton) {
        presentRatingPickerView()
    }

    @IBAction private func presentToMovieListView(_: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.goToMovieList, sender: nil)
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        ratingSelectButton.setTitleColor(UIColor.black, for: .normal)
        ratingSelectButton.setTitle("\(row)점", for: .normal)
    }
}

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return 10
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return "\(row)점"
    }
}
