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

    // MARK: - UI

    private let ratingAlertController: RatingAlertController = {
        let ratingAlertController = RatingAlertController(title: "평점 선택", message: "평점을 선택해주시기 바랍니다.", preferredStyle: .actionSheet)
        return ratingAlertController
    }()

    // MARK: - Property

    fileprivate struct RatingPickerViewData {
        static let componentCount: Int = 1
        static let rowCount: Int = 10
        static let defaultRowIndex: Int = 5
    }

    private var ratingPickerViewRowIndex: Int = 0
    private var selectedRatingPickerViewRowIndex: Int {
        get {
            return ratingPickerViewRowIndex
        }

        set {
            ratingPickerViewRowIndex = newValue
            ratingSelectButton.setTitle(" \(newValue)점", for: .normal)
            ratingSelectButton.setTitleColor(UIColor.black, for: .normal)
        }
    }

    private var isAPIDataRequested: Bool = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.presentToMovieListButton.isEnabled = false
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.presentToMovieListButton.isEnabled = true
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setRequestAPIDelegate()
        setRatingAlertController()
        setPresentToMovieListButton()
        setRatingSelectButton()
    }

    // MARK: - Method

    // MARK: Setting

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
        ratingAlertController.ratingPickerView.selectRow(RatingPickerViewData.defaultRowIndex, inComponent: 0, animated: false)
    }

    private func setPresentToMovieListButton() {
        presentToMovieListButton.layer.cornerRadius = 10
        presentToMovieListButton.layer.shadowRadius = 3
        presentToMovieListButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        presentToMovieListButton.layer.shadowOpacity = 1
    }

    // MARK: Event

    // MARK: Present

    private func presentRatingPickerView() {
        present(ratingAlertController, animated: true, completion: {
            self.selectedRatingPickerViewRowIndex = RatingPickerViewData.defaultRowIndex
        })
    }

    // MARK: Check

    private func isRatingSelectButtonSelected() -> Bool {
        if ratingSelectButton.titleColor(for: .normal) == .black {
            return true
        } else {
            return false
        }
    }

    // MARK: IBAction

    @IBAction private func ratingSelectButtonPressed(_: UIButton) {
        presentRatingPickerView()
    }

    @IBAction private func presentToMovieListView(_: UIButton) {
        if isRatingSelectButtonSelected() {
            RequestAPI.shared.requestMovieData(rating: selectedRatingPickerViewRowIndex) { movieData in
                guard let movieData = movieData else { return }

                MovieCommonData.shared.setMovieAPIData(movieData: movieData)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: SegueIdentifier.goToMovieList, sender: nil)
                }
            }
        } else {
            /// present AlertController requesting setting
            presentDefaultAlertController(title: "최소 평점 미설정", message: "최소 평점을 설정해주세요.")
        }
    }
}

// MARK: - Extension

// MARK: UIPickerViewDelegate

extension MainViewController: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        selectedRatingPickerViewRowIndex = row
    }
}

// MARK: UIPickerViewDataSource

extension MainViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return RatingPickerViewData.componentCount
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return RatingPickerViewData.rowCount
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return "\(row)점"
    }
}

// MARK: RequestMovieAPIDelegate

extension MainViewController: RequestMovieAPIDelegate {
    func movieRequestDidBegin() {
        isAPIDataRequested = true
    }

    func movieRequestDidFinished() {
        isAPIDataRequested = false
    }

    func movieRequestDidError(_ errorDescription: String) {
        isAPIDataRequested = false
        /// present AlertController about Error
        presentDefaultAlertController(title: "데이터 요청 실패", message: "데이터 요청에 실패했습니다. \(errorDescription)")
    }
}
