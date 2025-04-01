//
//  ViewController.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    struct UserDefaultsKeys {
        static let shouldShowFullSummaryBookNumbers = "shouldShowFullSummaryBookNumbers"
    }
    
    private var books: [Book] = []
    private var selectedBookNumber = 0 // 현재 선택된 책 번호
    private var shouldShowFullSummaryBookNumbers: Set<Int> = [] // summary 더보기/접기 정보 저장
    
    private let contentView = ContentView()
    private let dataService = DataService() // JSON 정보 로드
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        loadUserPreference()
        
        contentView.showMoreButton.addTarget(self, action: #selector(summaryButtonTapped), for: .touchUpInside)
        contentView.showLessButton.addTarget(self, action: #selector(summaryButtonTapped), for: .touchUpInside)
        
        contentView.onChange = { [weak self] selectedNumber in
            guard let self else { return }
            self.selectedBookNumber = selectedNumber
            contentView.book = books[selectedNumber]
            contentView.bookNumber = selectedNumber
            if shouldShowFullSummaryBookNumbers.contains(selectedNumber) {
                contentView.isFullSummary = true
            } else {
                contentView.isFullSummary = false
            }
        }
        
        updateUI()
    }
    
    func updateUI() {
        contentView.book = books[selectedBookNumber]
        contentView.bookNumber = selectedBookNumber
        if shouldShowFullSummaryBookNumbers.contains(selectedBookNumber) {
            contentView.isFullSummary = true
        } else {
            contentView.isFullSummary = false
        }
        contentView.updateUI()
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
        }
    }
    
    func showError(_ error: Error) {
        let alertTitle = NSLocalizedString("Error", comment: "Error alert title")
        let alert = UIAlertController(
            title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("OK", comment: "Alert OK button title")
        alert.addAction(
            UIAlertAction(
                title: actionTitle, style: .default,
                handler: { [weak self] _ in
                    self?.dismiss(animated: true)
                }))
        present(alert, animated: true, completion: nil)
    }
    
    private func loadUserPreference() {
        if let saved = UserDefaults.standard.array(forKey: UserDefaultsKeys.shouldShowFullSummaryBookNumbers) as? [Int] {
            shouldShowFullSummaryBookNumbers = Set(saved)
        }
    }
    
    @objc func summaryButtonTapped() {
        if shouldShowFullSummaryBookNumbers.contains(selectedBookNumber) {
            contentView.summaryLabel.text = contentView.showSummary(isFullText: false)
            contentView.showMoreButton.isHidden = false
            contentView.showLessButton.isHidden = true
            contentView.isFullSummary = false
            shouldShowFullSummaryBookNumbers.remove(selectedBookNumber)
            UserDefaults.standard.set(Array(shouldShowFullSummaryBookNumbers), forKey: UserDefaultsKeys.shouldShowFullSummaryBookNumbers)
        } else {
            contentView.summaryLabel.text = contentView.showSummary(isFullText: true)
            contentView.showMoreButton.isHidden = true
            contentView.showLessButton.isHidden = false
            contentView.isFullSummary = true
            shouldShowFullSummaryBookNumbers.insert(selectedBookNumber)
            UserDefaults.standard.set(Array(shouldShowFullSummaryBookNumbers), forKey: UserDefaultsKeys.shouldShowFullSummaryBookNumbers)
        }
    }
}
