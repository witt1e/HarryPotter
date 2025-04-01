//
//  ContentView.swift
//  HarryPotter
//
//  Created by 권순욱 on 4/1/25.
//

import UIKit

class ContentView: UIView {
    var book: Book?
    var bookNumber: Int?
    var isFullSummary: Bool = false
    var onChange: (Int) -> Void = { _ in }
    
    // Label
    let bookTitle = UILabel() // 책 제목
    let smallBookTitle = UILabel() // 책 정보 스택 뷰 내 제목
    let authorTitle = UILabel() // "Author"
    let authorLabel = UILabel() // 저자 이름
    var releaseDateTitle = UILabel() // "Released"
    var releaseDateLabel = UILabel() // 출판일
    var pagesTitle = UILabel() // "Pages"
    var pagesLabel = UILabel() // 총 페이지
    var dedicationTitle = UILabel() // "Dedication"
    var dedicationLabel = UILabel() // 헌정사
    var summaryTitle = UILabel() // "Summary"
    var summaryLabel = UILabel() // 책 요약
    var chapterTitle = UILabel() // "Chapter"
    let chapterLabel = UILabel() // 목차
    
    // Button
    var showMoreButton = UIButton() // 더 보기
    var showLessButton = UIButton() // 접기
    
    // Image View
    let bookImageView = UIImageView() // 책 이미지
    
    // Stack View
    var bookNumberStackView = UIStackView() // 책 번호
    
    var containerStackView = UIStackView() // 전체(이미지 + 책 정보)
    var bookInformationStackView = UIStackView() // 책 정보(제목, 저자, 출판일, 총 페이지)
    var authorStackView = UIStackView() // 저자
    var releaseDateStackView = UIStackView() // 출판일
    var pagesStackView = UIStackView() // 총 페이지
    
    var dedicationStackView = UIStackView() // 헌정사
    var summaryStackView = UIStackView() // 요약
    var summaryButtonStackView = UIStackView() // 더 보기 버튼, 접기 버튼
    var chapterStackView = UIStackView() // 목차
    
    // Scroll View
    let scrollView = UIScrollView() // 책 번호 버튼 밑으로 스크롤 뷰 적용
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareSubviews()
        
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareSubviews() {
        backgroundColor = .white
        
        setBookTitle()
        setBookNumberStackView()
        setScrollView()
        setImageView()
        setSmallBookTitle()
        setAuthorStackView()
        setReleaseDateStackView()
        setPagesStackView()
        setBookInformationStackView()
        setContainerStackView()
        setDedicationStackView()
        setSummaryStackView()
        setChapterStackView()
        
        setConstraints()
    }
    
    private func setBookTitle() {
        bookTitle.textAlignment = .center
        bookTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        bookTitle.numberOfLines = 0
        
        addSubview(bookTitle)
    }
    
    private func setBookNumberStackView() {
        bookNumberStackView.axis = .horizontal
        bookNumberStackView.spacing = 20
        
        addSubview(bookNumberStackView)
    }
    
    private func setScrollView() {
        scrollView.showsVerticalScrollIndicator = false
        
        addSubview(scrollView)
    }
    
    private func setImageView() {
        bookImageView.contentMode = .scaleAspectFit
    }
    
    private func setSmallBookTitle() {
        smallBookTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        smallBookTitle.textColor = .black
        smallBookTitle.numberOfLines = 0
    }
    
    private func setAuthorStackView() {
        authorTitle.text = "Author"
        authorTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        authorTitle.textColor = .black
        
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        authorLabel.textColor = .darkGray
        
        authorStackView = makeStackView(arrangedSubviews: [authorTitle, authorLabel], axis: .horizontal)
        authorStackView.alignment = .bottom
    }
    
    private func setReleaseDateStackView() {
        releaseDateTitle = makeTitle(title: "Released", size: .small)
        
        releaseDateStackView = makeStackView(arrangedSubviews: [releaseDateTitle, releaseDateLabel], axis: .horizontal)
    }
    
    func releaseDateFormatter(input: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: input) {
            formatter.dateFormat = "MMM dd, yyyy"
            return formatter.string(from: date)
        } else {
            return "Unknown"
        }
    }
    
    private func setPagesStackView() {
        pagesTitle = makeTitle(title: "Pages", size: .small)
        
        pagesStackView = makeStackView(arrangedSubviews: [pagesTitle, pagesLabel], axis: .horizontal)
    }
    
    private func setBookInformationStackView() {
        bookInformationStackView = makeStackView(arrangedSubviews: [smallBookTitle, authorStackView, releaseDateStackView, pagesStackView], axis: .vertical)
        bookInformationStackView.alignment = .leading
    }
    
    private func setContainerStackView() {
        containerStackView = UIStackView(arrangedSubviews: [bookImageView, bookInformationStackView])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 16
        containerStackView.alignment = .top
        
        scrollView.addSubview(containerStackView)
    }
    
    private func setDedicationStackView() {
        dedicationTitle = makeTitle(title: "Dedication", size: .medium)
        
        dedicationLabel.font = UIFont.systemFont(ofSize: 14)
        dedicationLabel.textColor = .darkGray
        dedicationLabel.numberOfLines = 0
        
        dedicationStackView = makeStackView(arrangedSubviews: [dedicationTitle, dedicationLabel], axis: .vertical)
        
        scrollView.addSubview(dedicationStackView)
    }
    
    private func setSummaryStackView() {
        summaryTitle = makeTitle(title: "Summary", size: .medium)
        
        showMoreButton = makeSummaryButton(title: "더 보기")
        showLessButton = makeSummaryButton(title: "접기")
        
        summaryLabel.font = UIFont.systemFont(ofSize: 14)
        summaryLabel.textColor = .darkGray
        summaryLabel.numberOfLines = 0
        
        let spacer = UIView()
        summaryButtonStackView = UIStackView(arrangedSubviews: [spacer, showMoreButton, showLessButton])
                
        summaryStackView = makeStackView(arrangedSubviews: [summaryTitle, summaryLabel, summaryButtonStackView], axis: .vertical)
        
        scrollView.addSubview(summaryStackView)
    }
    
    // 요약 텍스트 제한 글자 수(450자) 반환
    func showSummary(isFullText: Bool) -> String {
        guard let book else { return "" }
        let text = book.summary
        if isFullText || book.summary.count < 450 {
            return text
        } else {
            return String(text.prefix(450)) + "..."
        }
    }
    
    private func setChapterStackView() {
        chapterTitle = makeTitle(title: "Chapters", size: .medium)
        
        chapterLabel.font = UIFont.systemFont(ofSize: 14)
        chapterLabel.textColor = .darkGray
        chapterLabel.numberOfLines = 0
        
        chapterStackView = makeStackView(arrangedSubviews: [chapterTitle, chapterLabel], axis: .vertical)
        
        scrollView.addSubview(chapterStackView)
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
    
    private func makeBookNumberButton(bookNumber: Int) -> UIButton {
        let button = UIButton()
        button.setTitle("\(bookNumber + 1)", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.frame.size.width = 30
        button.frame.size.height = 30
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(bookNumberButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func bookNumberButtonTapped(_ button: UIButton) {
        guard let number = Int((button.titleLabel?.text)!) else { return }
        bookNumber = number - 1 // number는 +1 되어 있는 숫자이므로 원복.
        
        onChange(bookNumber!)
        
        updateUI()
    }
    
    func updateUI() {
        guard let book, let bookNumber else { return }
        
        bookTitle.text = book.title
        
        bookNumberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for index in 0..<7 { // books.count 등으로 구현할 수 없는지?
            let button = makeBookNumberButton(bookNumber: index)
            bookNumberStackView.addArrangedSubview(button)
            if bookNumber != index {
                button.setTitleColor(.systemBlue, for: .normal)
                button.backgroundColor = .systemGray5
            }
        }
        
        bookImageView.image = UIImage(named: "harrypotter\(bookNumber + 1)")
        
        smallBookTitle.text = book.title
        
        authorLabel.text = book.author
        
        let date = book.releaseDate
        releaseDateLabel.text = releaseDateFormatter(input: date)
        
        pagesLabel.text = String(book.pages)
        
        dedicationLabel.text = book.dedication
        
        if book.summary.count < 450 {
            summaryLabel.text = showSummary(isFullText: true)
            showMoreButton.isHidden = true
            showLessButton.isHidden = true
        } else if isFullSummary {
            summaryLabel.text = showSummary(isFullText: true)
            showMoreButton.isHidden = true
            showLessButton.isHidden = false
        } else {
            summaryLabel.text = showSummary(isFullText: false)
            showMoreButton.isHidden = false
            showLessButton.isHidden = true
        }
        
        let chapters = book.chapters.map { $0.title }.joined(separator: "\n")
        let attributedString = NSMutableAttributedString(string: chapters)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        chapterLabel.attributedText = attributedString
    }
    
    private enum TitleSize {
        case small, medium
    }
    
    private func makeTitle(title: String, size: TitleSize) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .black
        
        switch size {
        case .medium:
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        case .small:
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
        
        return label
    }
    
    private enum ContentSize {
        case short, long
    }
    
    private func makeContent(content: String, size: ContentSize) -> UILabel {
        let label = UILabel()
        label.text = content
        label.font = UIFont.systemFont(ofSize: 14)
        
        switch size {
        case .long:
            label.textColor = .darkGray
            label.numberOfLines = 0
        case .short:
            label.textColor = .gray
        }
        
        return label
    }
    
    private func makeStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.spacing = 8
        return stackView
    }
    
    private func makeSummaryButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }
}
