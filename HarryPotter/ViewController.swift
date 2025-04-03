//
//  ViewController.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    struct UserDefaultsKeys {
        static let shouldExpandBookNumbers = "shouldExpandBookNumbers"
    }
    
    private let contentView = ContentView()
    private let dataService = DataService() // JSON 정보 로드
    
    private var books: [Book] = []
    private var selectedBookNumber = 0 // 현재 선택된 책 번호
    private var shouldExpandBookNumbers: Set<Int> = [] // summary 더보기/접기 정보 저장
    
    override func loadView() {
        super.loadView()
        
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        configureContentView() // 더보기 버튼 타겟-액션, 클로저 설정
        
        updateUI()
    }
    
    private func loadBooks() {
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
        
        // summary 더보기/접기 버튼 정보 로드
        if let saved = UserDefaults.standard.array(forKey: UserDefaultsKeys.shouldExpandBookNumbers) as? [Int] {
            shouldExpandBookNumbers = Set(saved)
        }
        
        // 책 번호, 더보기/접기 버튼 정보 추가
        for index in books.indices {
            books[index].number = index
            if shouldExpandBookNumbers.contains(index) {
                books[index].isExpanded = true
            }
        }
    }
    
    private func configureContentView() {
        contentView.showMoreButton.addTarget(self, action: #selector(summaryButtonTapped), for: .touchUpInside)
        contentView.showLessButton.addTarget(self, action: #selector(summaryButtonTapped), for: .touchUpInside)
        
        contentView.onChange = { [weak self] selectedNumber in
            guard let self else { return }
            
            self.selectedBookNumber = selectedNumber
            updateUI()
        }
    }
    
    private func updateUI() {
        contentView.book = books[selectedBookNumber]
        
        contentView.updateUI()
    }
    
    private func showError(_ error: Error) {
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
    
    @objc private func summaryButtonTapped() {
        if shouldExpandBookNumbers.contains(selectedBookNumber) {
            books[selectedBookNumber].isExpanded = false
            contentView.book = books[selectedBookNumber]
            contentView.updateSummaryUI()
            
            shouldExpandBookNumbers.remove(selectedBookNumber)
            UserDefaults.standard.set(Array(shouldExpandBookNumbers), forKey: UserDefaultsKeys.shouldExpandBookNumbers)
        } else {
            books[selectedBookNumber].isExpanded = true
            contentView.book = books[selectedBookNumber]
            contentView.updateSummaryUI()
            
            shouldExpandBookNumbers.insert(selectedBookNumber)
            UserDefaults.standard.set(Array(shouldExpandBookNumbers), forKey: UserDefaultsKeys.shouldExpandBookNumbers)
        }
    }
}
