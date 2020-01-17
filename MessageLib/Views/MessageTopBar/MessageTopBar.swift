//
//  MessageTopBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

class MessageTopBar: UIView {
    
    private lazy var statusStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var viewForName: UIView = {
        let v = UIView()
        return v
    }()
    
    private lazy var viewForStatus: UIView = {
        let v = UIView()
        return v
    }()
    
    /// Back button outlet
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        return button
    }()
    
    /// Setup user name who are you talking to
    lazy var userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "Артем Власенко"
        return label
    }()
    
    /// Setup status conversation
    lazy var statusConversation: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = "Был(а) недавно"
        return label
    }()
    
    /// Setup photo for user who are you talking to
    lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "photo")
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        installViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        installViews()
    }
    
    private func installViews() {

        viewForName.addSubview(userName)
        viewForStatus.addSubview(statusConversation)
        statusStackView.addArrangedSubview(viewForName)
        statusStackView.addArrangedSubview(viewForStatus)

        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 2
        
        installConstraints()
    }
    
    private func installConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false

        installAvatarConstraints()
        installBackButtonConstraints()
        installStackViewConstraints()
    }
    
    private func installAvatarConstraints() {
        self.addSubview(userImage)
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        userImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 34).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
    private func installBackButtonConstraints() {
        self.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func installStackViewConstraints() {
        self.addSubview(statusStackView)
        
        statusStackView.translatesAutoresizingMaskIntoConstraints = false
        statusStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        statusStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.leadingAnchor.constraint(equalTo: viewForName.leadingAnchor).isActive = true
        userName.trailingAnchor.constraint(equalTo: viewForName.trailingAnchor).isActive = true
        userName.bottomAnchor.constraint(equalTo: viewForName.bottomAnchor).isActive = true
        userName.topAnchor.constraint(equalTo: viewForName.topAnchor).isActive = true

        statusConversation.translatesAutoresizingMaskIntoConstraints = false
        statusConversation.leadingAnchor.constraint(equalTo: viewForStatus.leadingAnchor).isActive = true
        statusConversation.trailingAnchor.constraint(equalTo: viewForStatus.trailingAnchor).isActive = true
        statusConversation.bottomAnchor.constraint(equalTo: viewForStatus.bottomAnchor).isActive = true
        statusConversation.topAnchor.constraint(equalTo: viewForStatus.topAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        userImage.layer.cornerRadius = 17
        userImage.clipsToBounds = true
    }
    
}
