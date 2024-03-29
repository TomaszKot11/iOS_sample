//
//  CustomTableViewCell.swift
//  HearthstoneCardView
//
//  Created by Tomasz Kot on 28/08/2019.
//  Copyright © 2019 Tomasz Kot. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    // this could be a separate subview
    let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
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
    
    let manaLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
         label.font = UIFont(name: "Helvetica-Bold", size: 30.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let classLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 20.0)
        return label
    }()
    
    let rarityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Helvetica", size: 15.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false // do we need this here?
        addSubviews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func feedWithCard(card: Card) {
        if let manaCost = card.manaCost {
            manaLabel.text = "\(manaCost)"
        }
        nameLabel.text = card.name["pl_PL"]
        classLabel.text = MetadataService.getClassNameFor(id: card.classId)
        let rarityTuple = MetadataService.getRarityNameAndColorFor(id: card.rarityId)
        
        rarityLabel.text = rarityTuple.name
        rarityLabel.textColor = rarityTuple.color
    }
    
    //MARK: private methods
    
    private func addSubviews() {
        self.addSubview(mainStackView)
        mainStackView.addArrangedSubview(classImageView)
        mainStackView.addArrangedSubview(detailsStackView)
        
            classImageView.addSubview(manaLabel)
        
        detailsStackView.addArrangedSubview(nameLabel)
        detailsStackView.addArrangedSubview(classLabel)
        detailsStackView.addArrangedSubview(rarityLabel)
    }

    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            manaLabel.centerXAnchor.constraint(equalTo: classImageView.centerXAnchor),
            manaLabel.centerYAnchor.constraint(equalTo: classImageView.centerYAnchor)
        ])
    }
}
