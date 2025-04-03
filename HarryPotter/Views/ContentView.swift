//
//  ContentView.swift
//  HarryPotter
//
//  Created by 권순욱 on 4/1/25.
//

import UIKit
import SnapKit

class ContentView: UIView {
    // Labels
    let bookTitle = UILabel() // 책 제목
    let smallBookTitle = UILabel() // 책 정보 스택 뷰 내 제목
    let authorTitle = UILabel() // "Author"
    let authorLabel = UILabel() // 저자 이름
    let releaseDateTitle = UILabel() // "Released"
    let releaseDateLabel = UILabel() // 출판일
    let pagesTitle = UILabel() // "Pages"
    let pagesLabel = UILabel() // 총 페이지
    let dedicationTitle = UILabel() // "Dedication"
    let dedicationLabel = UILabel() // 헌정사
    let summaryTitle = UILabel() // "Summary"
    let summaryLabel = UILabel() // 책 요약
    let chapterTitle = UILabel() // "Chapter"
    let chapterLabel = UILabel() // 목차
    
    // Buttons
    let showMoreButton = UIButton() // 더 보기
    let showLessButton = UIButton() // 접기
    
    // Image View
    let bookImageView = UIImageView() // 책 이미지
    
    // Stack Views
    let bookNumberStackView = UIStackView() // 책 번호
    
    let containerStackView = UIStackView() // 전체(이미지 + 책 정보)
    let bookInformationStackView = UIStackView() // 책 정보(제목, 저자, 출판일, 총 페이지)
    let authorStackView = UIStackView() // 저자
    let releaseDateStackView = UIStackView() // 출판일
    let pagesStackView = UIStackView() // 총 페이지
    
    let dedicationStackView = UIStackView() // 헌정사
    let summaryStackView = UIStackView() // 요약
    let summaryButtonStackView = UIStackView() // 더 보기 버튼, 접기 버튼
    let chapterStackView = UIStackView() // 목차
    
    // Scroll View
    let scrollView = UIScrollView() // 책 번호 버튼 밑으로 스크롤 뷰 적용
    
    var book: Book?
    var onChange: (Int) -> Void = { _ in } // 현재 선택된 책 번호 바인딩
    
    private var previousButton: BookNumberButton? // 사용자가 다른 책 선택 시, 이전 책 번호 저장
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func prepareSubviews() {
        backgroundColor = .white
        
        bookTitle.textAlignment = .center
        bookTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        bookTitle.numberOfLines = 0
        addSubview(bookTitle)
        
        for index in 0..<7 {
            let button = BookNumberButton(number: index)
            button.addTarget(self, action: #selector(bookNumberButtonTapped), for: .touchUpInside)
            if index == 0 {
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .systemBlue
                previousButton = button
            }
            bookNumberStackView.addArrangedSubview(button)
        }
        
        bookNumberStackView.axis = .horizontal
        bookNumberStackView.spacing = 20
        addSubview(bookNumberStackView)
        
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        
        bookImageView.contentMode = .scaleAspectFit
        
        smallBookTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        smallBookTitle.textColor = .black
        smallBookTitle.numberOfLines = 0
        
        authorTitle.text = "Author"
        authorTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorTitle.textColor = .black
        
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        authorLabel.textColor = .darkGray
        
        [authorTitle, authorLabel].forEach { authorStackView.addArrangedSubview($0) }
        authorStackView.axis = .horizontal
        authorStackView.spacing = 8
        authorStackView.alignment = .bottom
        
        releaseDateTitle.text = "Released"
        releaseDateTitle.textColor = .black
        releaseDateTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14)
        releaseDateLabel.textColor = .gray
        
        [releaseDateTitle, releaseDateLabel].forEach { releaseDateStackView.addArrangedSubview($0) }
        releaseDateStackView.axis = .horizontal
        releaseDateStackView.spacing = 8
        
        pagesTitle.text = "Pages"
        pagesTitle.textColor = .black
        pagesTitle.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        pagesLabel.font = UIFont.systemFont(ofSize: 14)
        pagesLabel.textColor = .gray
        
        [pagesTitle, pagesLabel].forEach { pagesStackView.addArrangedSubview($0) }
        pagesStackView.axis = .horizontal
        pagesStackView.spacing = 8
        
        [smallBookTitle, authorStackView, releaseDateStackView, pagesStackView].forEach { bookInformationStackView.addArrangedSubview($0) }
        bookInformationStackView.axis = .vertical
        bookInformationStackView.spacing = 8
        bookInformationStackView.alignment = .leading
        
        [bookImageView, bookInformationStackView].forEach { containerStackView.addArrangedSubview($0) }
        containerStackView.axis = .horizontal
        containerStackView.spacing = 16
        containerStackView.alignment = .top
        scrollView.addSubview(containerStackView)
        
        dedicationTitle.text = "Dedication"
        dedicationTitle.textColor = .black
        dedicationTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        dedicationLabel.font = UIFont.systemFont(ofSize: 14)
        dedicationLabel.textColor = .darkGray
        dedicationLabel.numberOfLines = 0
        
        [dedicationTitle, dedicationLabel].forEach { dedicationStackView.addArrangedSubview($0) }
        dedicationStackView.axis = .vertical
        dedicationStackView.spacing = 8
        scrollView.addSubview(dedicationStackView)
        
        summaryTitle.text = "Summary"
        summaryTitle.textColor = .black
        summaryTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        showMoreButton.setTitle("더 보기", for: .normal)
        showMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        showMoreButton.setTitleColor(.systemBlue, for: .normal)
        
        showLessButton.setTitle("접기", for: .normal)
        showLessButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        showLessButton.setTitleColor(.systemBlue, for: .normal)
        
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.textColor = .darkGray
        summaryLabel.numberOfLines = 0
        
        let spacer = UIView()
        [spacer, showMoreButton, showLessButton].forEach { summaryButtonStackView.addArrangedSubview($0) }
        [summaryTitle, summaryLabel, summaryButtonStackView].forEach { summaryStackView.addArrangedSubview($0) }
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 8
        scrollView.addSubview(summaryStackView)
        
        chapterTitle.text = "Chapters"
        chapterTitle.textColor = .black
        chapterTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        chapterLabel.font = UIFont.systemFont(ofSize: 14)
        chapterLabel.textColor = .darkGray
        chapterLabel.numberOfLines = 0
        
        [chapterTitle, chapterLabel].forEach { chapterStackView.addArrangedSubview($0) }
        chapterStackView.axis = .vertical
        chapterStackView.spacing = 8
        scrollView.addSubview(chapterStackView)
        
        // setConstraints() // 오토 레이아웃 설정
        setConstraintsBySnapKit() // 오토 레이아웃 설정(Snap Kit 이용)
    }
    
    func updateUI() {
        guard let book else { return }
        
        bookTitle.text = book.title
        
//        bookNumberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
//        for index in 0..<7 {
//            let button = BookNumberButton(number: index)
//            button.addTarget(self, action: #selector(bookNumberButtonTapped), for: .touchUpInside)
//            if book.number == index {
//                button.setTitleColor(.white, for: .normal)
//                button.backgroundColor = .systemBlue
//            }
//            bookNumberStackView.addArrangedSubview(button)
//        }
        
        bookImageView.image = UIImage(named: "harrypotter\(book.number + 1)")
        
        smallBookTitle.text = book.title
        
        authorLabel.text = book.author
        
        releaseDateLabel.text = releaseDateFormatter(date: book.releaseDate)
        
        pagesLabel.text = String(book.pages)
        
        dedicationLabel.text = book.dedication
                
        updateSummaryUI()
        
        let chapters = book.chapters.map { $0.title }.joined(separator: "\n")
        chapterLabel.attributedText = attributedString(text: chapters)
        
        scrollView.setContentOffset(.zero, animated: false) // 다른 책 선택 시 스크롤 맨 위로 이동
    }
    
    func updateSummaryUI() {
        guard let book else { return }
        
        if book.summary.count < 450 {
            summaryLabel.text = showSummary(isExpanded: true)
            showMoreButton.isHidden = true
            showLessButton.isHidden = true
        } else if book.isExpanded {
            summaryLabel.text = showSummary(isExpanded: true)
            showMoreButton.isHidden = true
            showLessButton.isHidden = false
        } else {
            summaryLabel.text = showSummary(isExpanded: false)
            showMoreButton.isHidden = false
            showLessButton.isHidden = true
        }
    }
    
    private func setConstraints() {
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        bookTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        bookTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        bookNumberStackView.translatesAutoresizingMaskIntoConstraints = false
        bookNumberStackView.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 16).isActive = true
        bookNumberStackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        bookNumberStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: bookNumberStackView.bottomAnchor, constant: 16).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        let width: CGFloat = 100
        bookImageView.heightAnchor.constraint(equalToConstant: width * 1.5).isActive = true
        bookImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        summaryStackView.topAnchor.constraint(equalTo: dedicationStackView.bottomAnchor, constant: 24).isActive = true
        summaryStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        summaryStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        summaryStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        chapterStackView.translatesAutoresizingMaskIntoConstraints = false
        chapterStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 24).isActive = true
        chapterStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        chapterStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        chapterStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        chapterStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
        
        dedicationStackView.translatesAutoresizingMaskIntoConstraints = false
        dedicationStackView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 24).isActive = true
        dedicationStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
        dedicationStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20).isActive = true
        dedicationStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40).isActive = true
    }
    
    private func setConstraintsBySnapKit() {
        bookTitle.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(safeAreaLayoutGuide).offset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        
        bookNumberStackView.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom).offset(16)
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(bookNumberStackView.snp.bottom).offset(16)
            $0.leading.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        let width: CGFloat = 100
        bookImageView.snp.makeConstraints {
            $0.height.equalTo(width * 1.5)
            $0.width.equalTo(width)
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(scrollView.snp.top)
            $0.leading.equalTo(scrollView.snp.leading).offset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-20)
            $0.width.equalTo(scrollView.snp.width).offset(-40)
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom).offset(24)
            $0.leading.equalTo(scrollView.snp.leading).offset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-20)
            $0.width.equalTo(scrollView.snp.width).offset(-40)
        }
        
        chapterStackView.snp.makeConstraints {
            $0.top.equalTo(summaryStackView.snp.bottom).offset(24)
            $0.leading.equalTo(scrollView.snp.leading).offset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-20)
            $0.bottom.equalTo(scrollView.snp.bottom)
            $0.width.equalTo(scrollView.snp.width).offset(-40)
        }
        
        dedicationStackView.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom).offset(24)
            $0.leading.equalTo(scrollView.snp.leading).offset(20)
            $0.trailing.equalTo(scrollView.snp.trailing).offset(-20)
            $0.width.equalTo(scrollView.snp.width).offset(-40)
        }
    }
    
    @objc private func bookNumberButtonTapped(_ sender: UIButton) {
        let button = sender as? BookNumberButton
        guard let number = button?.number else { return }
        
        // 사용자가 새로운 버튼을 탭했을 때,
        // 이전 버튼 정보가 있다면, 이전 버튼의 스타일을 unselected로 원복.
        // 새로운 버튼의 스타일을 selected로 변경하고, 이전 버튼에 저장.
        if let previousButton {
            previousButton.setTitleColor(.systemBlue, for: .normal)
            previousButton.backgroundColor = .systemGray5
        }
        
        button?.setTitleColor(.white, for: .normal)
        button?.backgroundColor = .systemBlue
        
        previousButton = button
        
        onChange(number)
        
        updateUI()
    }
    
    private func releaseDateFormatter(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.string(from: date)
        } else {
            return ""
        }
    }
    
    // summary 텍스트 제한 글자 수(450자) 반환
    private func showSummary(isExpanded: Bool) -> String {
        guard let book else { return "" }
        let text = book.summary
        if isExpanded || book.summary.count < 450 {
            return text
        } else {
            return String(text.prefix(450)) + "..."
        }
    }
    
    // chapters 줄 간격 8 설정
    private func attributedString(text: String) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
