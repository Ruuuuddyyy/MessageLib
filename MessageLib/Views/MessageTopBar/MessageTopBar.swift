//
//  MessageTopBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

final class MessageTopBar: UIView {
    
    private lazy var statusStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var viewForName: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var viewForStatus: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    /// Back button outlet
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Setup user name who are you talking to
    lazy var userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Артем Власенко"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Setup status conversation
    lazy var statusConversation: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = "Был(а) недавно"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Setup photo for user who are you talking to
    lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "photo")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var heightBar: CGFloat = 64
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupViews()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        
        viewForName.addSubview(userName)
        viewForStatus.addSubview(statusConversation)
        statusStackView.addArrangedSubview(viewForName)
        statusStackView.addArrangedSubview(viewForStatus)
        
        addSubview(userImage)
        addSubview(backButton)
        addSubview(statusStackView)
        addSubview(statusConversation)
        
        let height = heightBar + MessageHelper.isDeviceHaveBrow()
        
        let constraints = [
        
            userImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            userImage.heightAnchor.constraint(equalToConstant: 34),
            userImage.widthAnchor.constraint(equalToConstant: 34),

            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 44),
            backButton.widthAnchor.constraint(equalToConstant: 44),
        
            statusStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            statusStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
          
            userName.leadingAnchor.constraint(equalTo: viewForName.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: viewForName.trailingAnchor),
            userName.bottomAnchor.constraint(equalTo: viewForName.bottomAnchor),
            userName.topAnchor.constraint(equalTo: viewForName.topAnchor),

            statusConversation.leadingAnchor.constraint(equalTo: viewForStatus.leadingAnchor),
            statusConversation.trailingAnchor.constraint(equalTo: viewForStatus.trailingAnchor),
            statusConversation.bottomAnchor.constraint(equalTo: viewForStatus.bottomAnchor),
            statusConversation.topAnchor.constraint(equalTo: viewForStatus.topAnchor),
            
            heightAnchor.constraint(equalToConstant: height)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    override func layoutSubviews() {
        userImage.layer.cornerRadius = 17
        userImage.clipsToBounds = true
    }
    
}
