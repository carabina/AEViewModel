//
//  SettingsProfileCell.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import AEViewModel

class SettingsProfileCell: TableCell.Basic {
    
    // MARK: Outlets
    
    let mainStack = UIStackView()
    let textStack = UIStackView()
    
    let profileImageView = UIImageView()
    let name = UILabel()
    let subtitle = UILabel()
    
    // MARK: - TableCell
    
    override func customize() {
        configureSubviews()
        configureHierarchy()
        configureLayout()
        configureAppearance()
    }
    
    override func update(with item: Item) {
        name.text = item.data?.title
        subtitle.text = item.data?.detail
        
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        profileImageView.loadImage(from: url)
    }
    
    // MARK: Helpers
    
    private func configureSubviews() {
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        
        textStack.axis = .vertical
    }
    
    private func configureHierarchy() {
        textStack.addArrangedSubview(name)
        textStack.addArrangedSubview(subtitle)
        
        mainStack.addArrangedSubview(profileImageView)
        mainStack.addArrangedSubview(textStack)
        
        contentView.addSubview(mainStack)
    }
    
    private func configureLayout() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        profileImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        let spacing: CGFloat = 12
        mainStack.isLayoutMarginsRelativeArrangement = true
        mainStack.layoutMargins = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        mainStack.spacing = spacing
    }
    
    private func configureAppearance() {
        profileImageView.layer.cornerRadius = 28
        profileImageView.layer.masksToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .title2)
        subtitle.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
    
}
