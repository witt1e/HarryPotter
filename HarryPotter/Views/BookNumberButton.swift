//
//  BookNumberButton.swift
//  HarryPotter
//
//  Created by 권순욱 on 4/2/25.
//

import UIKit

class BookNumberButton: UIButton {
    let number: Int
    
    init(number: Int) {
        self.number = number
        super.init(frame: .zero)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        setTitle("\(number + 1)", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = .systemGray5
        layer.masksToBounds = true
        frame.size.width = 30
        frame.size.height = 30
        layer.cornerRadius = 15
    }
}
