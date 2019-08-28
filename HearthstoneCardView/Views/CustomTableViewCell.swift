//
//  CustomTableViewCell.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 28/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let classImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mana_crystal.png")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
//    let
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false // do we need this here?
//        self.heightAnchor.constraint(equalToConstant: 300)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: private methods
    
    private func addSubviews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(classImageView)
        mainStackView.addArrangedSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(classImageView)
    }

    
    private func addConstraints() {
//        self.heightAnchor.constraint(equalTo: mainStackView.heightAnchor)
//        classImageView.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 18)
//        classImageView.topAnchor.constraint(equalTo: mainStackView.topAnchor)
//        classImageView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
//        self.contentView.heightAnchor.constraint(equalToConstant: 300)
//        classImageView.heightAnchor.constraint(equalTo:  self.contentView.heightAnchor)
    }
}
