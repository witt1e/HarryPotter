//
//  ViewController.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    private var books: [Book] = []
    
    private let titleLabel = UILabel() // 책 제목
    private let seriesNumberButton = UIButton() // 시리즈 순서
    
    // 책 정보 스택 뷰
    private var containerStackView = UIStackView() // 전체 스택 뷰(이미지 + 책 정보)
    private let bookImageView = UIImageView() // 책 이미지
    private var verticalStackView = UIStackView() // 책 정보 스택 뷰(제목, 저자, 출판일, 총 페이지)
    private let bookTitle = UILabel() // 제목
    private var authorStackView = UIStackView() // 저자
    private let authorTitle = UILabel()
    private let authorContent = UILabel()
    private var releaseDateStackView = UIStackView() // 출판일
    private let releaseDateTitle = UILabel()
    private let releaseDateContent = UILabel()
    private var pagesStackView = UIStackView() // 총 페이지
    private let pagesTitle = UILabel()
    private let pagesContent = UILabel()
    
    // 헌정사 스택 뷰
    private var dedicationStackView = UIStackView()
    private let dedicationTitle = UILabel()
    private let dedicationContent = UILabel()
    
    // 요약 스택 뷰
    private var summaryStackView = UIStackView()
    private let summaryTitle = UILabel()
    private let summaryContent = UILabel()
    
    private let dataService = DataService() // JSON 정보 로드
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        prepareSubviews()
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
    }
    
    private func prepareSubviews() {
        view.backgroundColor = .white
        
        // 책 제목
        titleLabel.text = books.isEmpty ? "Book data load failed." : books[0].title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        // 시리즈 순서
        seriesNumberButton.setTitle("1", for: .normal)
        seriesNumberButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        seriesNumberButton.backgroundColor = .systemBlue
        seriesNumberButton.layer.masksToBounds = true
        seriesNumberButton.frame.size.width = 30
        seriesNumberButton.layer.cornerRadius = seriesNumberButton.layer.frame.width / 2
        seriesNumberButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(seriesNumberButton)
        
        seriesNumberButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        seriesNumberButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        // layout 변경 필요: centerX -> leading, trailing 각각 super view로부터 20 이상
        
        // 책 정보 스택 뷰
        // 이미지
        bookImageView.image = UIImage(named: "harrypotter1")
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let width: CGFloat = 100
        bookImageView.heightAnchor.constraint(equalToConstant: width * 1.5).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        // 제목
        bookTitle.text = books[0].title
        bookTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        bookTitle.textColor = .black
        bookTitle.numberOfLines = 0
        
        // 저자
        authorTitle.text = "Author"
        authorTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorTitle.textColor = .black
        
        authorContent.text = books[0].author
        authorContent.font = UIFont.systemFont(ofSize: 18)
        authorContent.textColor = .darkGray
        
        authorStackView = UIStackView(arrangedSubviews: [authorTitle, authorContent])
        authorStackView.axis = .horizontal
        authorStackView.spacing = 8
        authorStackView.alignment = .bottom
        
        // 출판일
        releaseDateTitle.text = "Released"
        releaseDateTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        releaseDateTitle.textColor = .black
        
        let date = books.isEmpty ? "" : books[0].releaseDate
        releaseDateContent.text = releaseDateFormatter(input: date)
        releaseDateContent.font = UIFont.systemFont(ofSize: 14)
        releaseDateContent.textColor = .gray
        
        releaseDateStackView = UIStackView(arrangedSubviews: [releaseDateTitle, releaseDateContent])
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 8
        
        // 총 페이지
        pagesTitle.text = "Pages"
        pagesTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        pagesTitle.textColor = .black
        
        pagesContent.text = String(books[0].pages)
        pagesContent.font = UIFont.systemFont(ofSize: 14)
        pagesContent.textColor = .gray
        
        pagesStackView = UIStackView(arrangedSubviews: [pagesTitle, pagesContent])
        pagesStackView.axis = .horizontal
        pagesStackView.spacing = 8
        
        // 전체 책 정보 스택 뷰(이미지 제외)
        verticalStackView = UIStackView(arrangedSubviews: [bookTitle, authorStackView, releaseDateStackView, pagesStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.alignment = .leading
        
        // 이미지 포함 전체 스택 뷰
        containerStackView = UIStackView(arrangedSubviews: [bookImageView, verticalStackView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 16
        containerStackView.alignment = .top
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerStackView)
        
        containerStackView.topAnchor.constraint(equalTo: seriesNumberButton.bottomAnchor, constant: 16).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5).isActive = true
        
        // 헌정사
        dedicationTitle.text = "Dedication"
        dedicationTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dedicationTitle.textColor = .black
        
        dedicationContent.text = books.isEmpty ? "" : books[0].dedication
        dedicationContent.font = UIFont.systemFont(ofSize: 14)
        dedicationContent.textColor = .darkGray
        dedicationContent.numberOfLines = 0
        
        dedicationStackView = UIStackView(arrangedSubviews: [dedicationTitle, dedicationContent])
        dedicationStackView.axis = .vertical
        dedicationStackView.spacing = 8
        dedicationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(dedicationStackView)
        
        dedicationStackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 24).isActive = true
        dedicationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        dedicationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        // 요약
        summaryTitle.text = "Summary"
        summaryTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        summaryTitle.textColor = .black
        
        summaryContent.text = books.isEmpty ? "" : books[0].summary
        summaryContent.font = UIFont.systemFont(ofSize: 14)
        summaryContent.textColor = .darkGray
        summaryContent.numberOfLines = 0
        
        summaryStackView = UIStackView(arrangedSubviews: [summaryTitle, summaryContent])
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(summaryStackView)
        
        summaryStackView.topAnchor.constraint(equalTo: dedicationStackView.bottomAnchor, constant: 24).isActive = true
        summaryStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        summaryStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
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
    
    private func releaseDateFormatter(input: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: input) {
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
}
