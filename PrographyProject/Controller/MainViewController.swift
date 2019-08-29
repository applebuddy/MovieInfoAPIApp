//
//  ViewController.swift
//  PrographyProject
//
//  Created by MinKyeongTae on 29/08/2019.
//  Copyright © 2019 MinKyeongTae. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlet UI

    @IBOutlet private var ratingSelectButton: UIButton!
    @IBOutlet private var presentToMovieListButton: UIButton!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Property

    private var isAPIDataRequested: Bool = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.activityIndicatorView.isHidden = true
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.activityIndicatorView.isHidden = false
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }

    // MARK: - UI

    private let ratingAlertController: RatingAlertController = {
        let ratingAlertController = RatingAlertController(title: "별점 선택", message: "별점을 선택해주시기 바랍니다.", preferredStyle: .actionSheet)
        return ratingAlertController
    }()

    // MARK: - Property

    private var selectedRatingIndex: Int = 5

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setRequestAPIDelegate()
        setRatingAlertController()
        setPresentToMovieListButton()
        setRatingSelectButton()
    }

    // MARK: - Setting

    private func setRequestAPIDelegate() {
        RequestAPI.shared.delegate = self
    }

    private func setRatingSelectButton() {
        ratingSelectButton.layer.borderWidth = 1
        ratingSelectButton.layer.cornerRadius = 10
        ratingSelectButton.layer.borderColor = UIColor.lightGray.cgColor
    }

    private func setRatingAlertController() {
        ratingAlertController.ratingPickerView.delegate = self
        ratingAlertController.ratingPickerView.dataSource = self
        ratingAlertController.ratingPickerView.selectRow(selectedRatingIndex, inComponent: 0, animated: false)
    }

    private func setPresentToMovieListButton() {
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
        RequestAPI.shared.requestMovieData(rating: selectedRatingIndex) { movieData in
            guard let movieData = movieData else { return }

            MovieData.shared.setMovieAPIData(movieData: movieData)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: SegueIdentifier.goToMovieList, sender: nil)
            }
        }
    }
}

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        ratingSelectButton.setTitleColor(UIColor.black, for: .normal)
        selectedRatingIndex = row
        ratingSelectButton.setTitle(" \(row)점", for: .normal)
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

extension MainViewController: RequestMovieAPIDelegate {
    func movieRequestDidBegin(_: RequestAPI) {
        isAPIDataRequested = true
    }

    func movieRequestDidFinished(_: RequestAPI) {
        isAPIDataRequested = false
    }

    func movieRequestDidError(_: RequestAPI, _ errorDescription: String) {
        isAPIDataRequested = false
        debugPrint(errorDescription)
    }
}
