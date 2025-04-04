//
//  ViewController.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    struct UserDefaultsKeys {
        static let expandedBookNumbers = "expandedBookNumbers"
    }
    
    private let contentView = ContentView()
    private let dataService = DataService()
    
    private var books: [Book] = []
    private var selectedBookNumber = 0 // 현재 선택된 책 번호
    private var expandedBookNumbers: Set<Int> = [] // summary 더보기/접기 정보 저장
    
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
        // JSON 파싱
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
        
        // 각 버튼 summary 더보기/접기 상태 로드
        if let saved = UserDefaults.standard.array(forKey: UserDefaultsKeys.expandedBookNumbers) as? [Int] {
            expandedBookNumbers = Set(saved)
        }
        
        // 파싱된 데이터에 책 번호, 더보기/접기 상태 추가
        for index in books.indices {
            books[index].number = index
            if expandedBookNumbers.contains(index) {
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
        guard !books.isEmpty else { return }
        
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
        if books[selectedBookNumber].isExpanded {
            updateSummaryUI()
            
            expandedBookNumbers.remove(selectedBookNumber)
            UserDefaults.standard.set(Array(expandedBookNumbers), forKey: UserDefaultsKeys.expandedBookNumbers)
        } else {
            updateSummaryUI()
            
            expandedBookNumbers.insert(selectedBookNumber)
            UserDefaults.standard.set(Array(expandedBookNumbers), forKey: UserDefaultsKeys.expandedBookNumbers)
        }
    }
    
    private func updateSummaryUI() {
        books[selectedBookNumber].isExpanded.toggle()
        contentView.book = books[selectedBookNumber]
        contentView.updateSummaryUI()
    }
}
