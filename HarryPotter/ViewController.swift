//
//  ViewController.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import UIKit

class ViewController: UIViewController {
    private var books: [Book] = []
    private var seriesNumber = 0
    private var shouldShowFullText: Set<Int> = [] // summary 펼치기/접기 정보 저장
    
    private let titleLabel = UILabel() // 책 제목
    private var seriesNumberButton = UIButton() // 시리즈 순서
    private var seriesNumberStackView = UIStackView()
    private let scrollView = UIScrollView() // 시리즈 순서 버튼 밑으로 스크롤 뷰 적용
    
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
    private var pageStackView = UIStackView() // 총 페이지
    private let pageTitle = UILabel()
    private let pageContent = UILabel()
    
    // 헌정사 스택 뷰
    private var dedicationStackView = UIStackView()
    private let dedicationTitle = UILabel()
    private let dedicationContent = UILabel()
    
    // 요약 스택 뷰
    private var summaryStackView = UIStackView()
    private let summaryTitle = UILabel()
    private let summaryContent = UILabel()
    
    // 더 보기 버튼, 접기 버튼
    private let seeMoreButton = UIButton()
    private let foldButton = UIButton()
    private var summaryButtonStackView = UIStackView()
    
    // 목차 스택 뷰
    private var chapterStackView = UIStackView()
    private let chapterTitle = UILabel()
    private let chapterContent = UILabel()
    
    private let dataService = DataService() // JSON 정보 로드
    
//    private var isFullText: Bool {
//        UserDefaults.standard.bool(forKey: "isFullText") // 주의: nil이면 false임.
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        
        if let saved = UserDefaults.standard.array(forKey: "shouldShowFullText") as? [Int] {
            shouldShowFullText = Set(saved)
        }
        
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
        titleLabel.text = books.isEmpty ? "Book data load failed." : books[seriesNumber].title
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        // 시리즈 순서
//        seriesNumberButton.setTitle("\(seriesNumber + 1)", for: .normal)
//        seriesNumberButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        seriesNumberButton.backgroundColor = .systemBlue
//        seriesNumberButton.layer.masksToBounds = true
//        seriesNumberButton.frame.size.width = 30
//        seriesNumberButton.layer.cornerRadius = seriesNumberButton.layer.frame.width / 2
//        seriesNumberButton.translatesAutoresizingMaskIntoConstraints = false
        
//        seriesNumberButton = makeSeriesNumberButton(seriesNumber: seriesNumber)
        
        for index in 0..<books.count {
            let button = makeSeriesNumberButton(seriesNumber: index)
            seriesNumberStackView.addArrangedSubview(button)
            if seriesNumber != index {
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
            }
        }
        
        seriesNumberStackView.axis = .horizontal
        seriesNumberStackView.spacing = 20
        seriesNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // view.addSubview(seriesNumberButton)
        view.addSubview(seriesNumberStackView)
        
//        seriesNumberButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
//        seriesNumberButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        // layout 변경 필요: centerX -> leading, trailing 각각 super view로부터 20 이상
        
        seriesNumberStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        seriesNumberStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
//        seriesNumberStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//        seriesNumberStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        // 스크롤 뷰
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        
//        scrollView.topAnchor.constraint(equalTo: seriesNumberButton.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: seriesNumberStackView.bottomAnchor).isActive = true
        // scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        // scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // 책 정보 스택 뷰
        // 이미지
        bookImageView.image = UIImage(named: "harrypotter\(seriesNumber + 1)")
        bookImageView.contentMode = .scaleAspectFit
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let width: CGFloat = 100
        bookImageView.heightAnchor.constraint(equalToConstant: width * 1.5).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        // 제목
        bookTitle.text = books.isEmpty ? "" : books[seriesNumber].title
        bookTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        bookTitle.textColor = .black
        bookTitle.numberOfLines = 0
        
        // 저자
        authorTitle.text = "Author"
        authorTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorTitle.textColor = .black
        
        authorContent.text = books.isEmpty ? "" : books[seriesNumber].author
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
        
        let date = books.isEmpty ? "" : books[seriesNumber].releaseDate
        releaseDateContent.text = releaseDateFormatter(input: date)
        releaseDateContent.font = UIFont.systemFont(ofSize: 14)
        releaseDateContent.textColor = .gray
        
        releaseDateStackView = UIStackView(arrangedSubviews: [releaseDateTitle, releaseDateContent])
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 8
        
        // 총 페이지
        pageTitle.text = "Pages"
        pageTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        pageTitle.textColor = .black
        
        pageContent.text = books.isEmpty ? "" : String(books[seriesNumber].pages)
        pageContent.font = UIFont.systemFont(ofSize: 14)
        pageContent.textColor = .gray
        
        pageStackView = UIStackView(arrangedSubviews: [pageTitle, pageContent])
        pageStackView.axis = .horizontal
        pageStackView.spacing = 8
        
        // 전체 책 정보 스택 뷰(이미지 제외)
        verticalStackView = UIStackView(arrangedSubviews: [bookTitle, authorStackView, releaseDateStackView, pageStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.alignment = .leading
        
        // 이미지 포함 전체 스택 뷰
        containerStackView = UIStackView(arrangedSubviews: [bookImageView, verticalStackView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 16
        containerStackView.alignment = .top
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // view.addSubview(containerStackView)
        scrollView.addSubview(containerStackView)
        
//        containerStackView.topAnchor.constraint(equalTo: seriesNumberButton.bottomAnchor, constant: 16).isActive = true
//        containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        // 헌정사
        dedicationTitle.text = "Dedication"
        dedicationTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        dedicationTitle.textColor = .black
        
        dedicationContent.text = books.isEmpty ? "" : books[seriesNumber].dedication
        dedicationContent.font = UIFont.systemFont(ofSize: 14)
        dedicationContent.textColor = .darkGray
        dedicationContent.numberOfLines = 0
        
        dedicationStackView = UIStackView(arrangedSubviews: [dedicationTitle, dedicationContent])
        dedicationStackView.axis = .vertical
        dedicationStackView.spacing = 8
        dedicationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // view.addSubview(dedicationStackView)
        scrollView.addSubview(dedicationStackView)
        
//        dedicationStackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 24).isActive = true
//        dedicationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        dedicationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        dedicationStackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 24).isActive = true
        dedicationStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        dedicationStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        dedicationStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        // 요약
        summaryTitle.text = "Summary"
        summaryTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        summaryTitle.textColor = .black
        
        summaryContent.font = UIFont.systemFont(ofSize: 14)
        summaryContent.textColor = .darkGray
        summaryContent.numberOfLines = 0
        
        // 요약 내 더 보기 버튼
        seeMoreButton.setTitle("더 보기", for: .normal)
        seeMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        seeMoreButton.setTitleColor(.systemBlue, for: .normal)
        seeMoreButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        foldButton.setTitle("접기", for: .normal)
        foldButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        foldButton.setTitleColor(.systemBlue, for: .normal)
        foldButton.addTarget(self, action: #selector(seeMoreButtonTapped), for: .touchUpInside)
        
        // 버튼 상태 설정
//        if books[seriesNumber].summary.count < 450 {
//            seeMoreButton.isHidden = true
//            foldButton.isHidden = true
//        }
        
//        if !isFullText {
//            summaryContent.text = showSummary(fullText: false)
//            foldButton.isHidden = true
//        } else {
//            summaryContent.text = showSummary(fullText: true)
//            seeMoreButton.isHidden = true
//        }
        
        if books[seriesNumber].summary.count < 450 {
            summaryContent.text = showSummary(fullText: true)
            seeMoreButton.isHidden = true
            foldButton.isHidden = true
        } else if shouldShowFullText.contains(seriesNumber) {
            summaryContent.text = showSummary(fullText: true)
            seeMoreButton.isHidden = true
        } else {
            summaryContent.text = showSummary(fullText: false)
            foldButton.isHidden = true
        }
        
        let spacer = UIView()
        summaryButtonStackView = UIStackView(arrangedSubviews: [spacer, seeMoreButton, foldButton])
        
        summaryStackView = UIStackView(arrangedSubviews: [summaryTitle, summaryContent, summaryButtonStackView])
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // view.addSubview(summaryStackView)
        scrollView.addSubview(summaryStackView)
        
//        summaryStackView.topAnchor.constraint(equalTo: dedicationStackView.bottomAnchor, constant: 24).isActive = true
//        summaryStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
//        summaryStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        summaryStackView.topAnchor.constraint(equalTo: dedicationStackView.bottomAnchor, constant: 24).isActive = true
        summaryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        summaryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        // summaryStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        summaryStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        // 목차
        chapterTitle.text = "Chapters"
        chapterTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        chapterTitle.textColor = .black
        
        // chapterContent.text = books.isEmpty ? "" : books[0].chapters.map { $0.title }.joined(separator: "\n")
        chapterContent.font = UIFont.systemFont(ofSize: 14)
        chapterContent.textColor = .darkGray
        chapterContent.numberOfLines = 0
        
        // 목차 줄 간격 설정(lineSpacing 8)
        let chapters = books.isEmpty ? "" : books[seriesNumber].chapters.map { $0.title }.joined(separator: "\n")
        let attributedString = NSMutableAttributedString(string: chapters)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        chapterContent.attributedText = attributedString
        
        chapterStackView = UIStackView(arrangedSubviews: [chapterTitle, chapterContent])
        chapterStackView.axis = .vertical
        chapterStackView.spacing = 8
        chapterStackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(chapterStackView)
        
        chapterStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 24).isActive = true
        chapterStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        chapterStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        chapterStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        chapterStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
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
    
    // 요약 텍스트 제한 글자 수(450자) 반환
    private func showSummary(fullText: Bool) -> String {
        let text = books.isEmpty ? "" : books[seriesNumber].summary
//        if fullText || text.count < 450 {
//            return text
//        } else {
//            return String(text.prefix(450)) + "..."
//        }
        
        if fullText {
            return text
        } else {
            return String(text.prefix(450)) + "..."
        }
    }
    
    @objc private func seeMoreButtonTapped() {
//        if !isFullText {
//            summaryContent.text = showSummary(fullText: true)
//            seeMoreButton.isHidden = true
//            foldButton.isHidden = false
//            UserDefaults.standard.set(true, forKey: "isFullText")
//        } else {
//            summaryContent.text = showSummary(fullText: false)
//            seeMoreButton.isHidden = false
//            foldButton.isHidden = true
//            UserDefaults.standard.set(false, forKey: "isFullText")
//        }
        
        if shouldShowFullText.contains(seriesNumber) {
            summaryContent.text = showSummary(fullText: false)
            seeMoreButton.isHidden = false
            foldButton.isHidden = true
            shouldShowFullText.remove(seriesNumber)
            UserDefaults.standard.set(Array(shouldShowFullText), forKey: "shouldShowFullText")
        } else {
            summaryContent.text = showSummary(fullText: true)
            seeMoreButton.isHidden = true
            foldButton.isHidden = false
            shouldShowFullText.insert(seriesNumber)
            UserDefaults.standard.set(Array(shouldShowFullText), forKey: "shouldShowFullText")
        }
    }
    
    private func makeSeriesNumberButton(seriesNumber: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("\(seriesNumber + 1)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.frame.size.width = 30
        button.layer.cornerRadius = button.layer.frame.width / 2
        // button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seriesNumberButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc private func seriesNumberButtonTapped(_ button: UIButton) {
        guard let number = Int((button.titleLabel?.text)!) else { return }
        seriesNumber = number - 1 // number는 +1 되어 있는 숫자이므로 원복.
        updateUI()
    }
    
    private func updateUI() {
//        if let saved = UserDefaults.standard.array(forKey: "shouldShowFullText") as? [Int] {
//            shouldShowFullText = Set(saved)
//        }
        
        titleLabel.text = books.isEmpty ? "Book data load failed." : books[seriesNumber].title
        
        seriesNumberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for index in 0..<books.count {
            let button = makeSeriesNumberButton(seriesNumber: index)
            seriesNumberStackView.addArrangedSubview(button)
            if seriesNumber != index {
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
            }
        }
        
        bookImageView.image = UIImage(named: "harrypotter\(seriesNumber + 1)")
        
        bookTitle.text = books.isEmpty ? "" : books[seriesNumber].title
        
        authorContent.text = books.isEmpty ? "" : books[seriesNumber].author
        
        let date = books.isEmpty ? "" : books[seriesNumber].releaseDate
        releaseDateContent.text = releaseDateFormatter(input: date)
        
        pageContent.text = books.isEmpty ? "" : String(books[seriesNumber].pages)
        
        dedicationContent.text = books.isEmpty ? "" : books[seriesNumber].dedication
        
//        if !isFullText {
//            summaryContent.text = showSummary(fullText: false)
//            foldButton.isHidden = true
//        } else {
//            summaryContent.text = showSummary(fullText: true)
//            seeMoreButton.isHidden = true
//        }
        
        if books[seriesNumber].summary.count < 450 {
            summaryContent.text = showSummary(fullText: true)
            seeMoreButton.isHidden = true
            foldButton.isHidden = true
        } else if shouldShowFullText.contains(seriesNumber) {
            summaryContent.text = showSummary(fullText: true)
            seeMoreButton.isHidden = true
            foldButton.isHidden = false
        } else {
            summaryContent.text = showSummary(fullText: false)
            seeMoreButton.isHidden = false
            foldButton.isHidden = true
        }
        
        let chapters = books.isEmpty ? "" : books[seriesNumber].chapters.map { $0.title }.joined(separator: "\n")
        let attributedString = NSMutableAttributedString(string: chapters)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        chapterContent.attributedText = attributedString
    }
}
