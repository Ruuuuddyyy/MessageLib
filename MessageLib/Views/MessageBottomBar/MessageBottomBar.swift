//
//  MessageBottomBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 16.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit


class MessageBottomBar: UIView {
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cameraIcon"), for: .normal)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendButtonIcon"), for: .normal)
        button.addTarget(self, action: #selector(sendDidTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        return tv
    }()

    public var placeholder = "Write a message..."
    public var placeholderColor = UIColor.lightGray
    public var textMessageColor = UIColor.black
    var messageDidSend: ((Message)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        installViews()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        installViews()
    }
       
    private func installViews() {
        self.textView.text = placeholder
        self.textView.textColor = placeholderColor
        self.textView.layer.cornerRadius = 14
        self.textView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        self.textView.layer.borderWidth = 1
        self.textView.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false

        instalLeftButtonConstraints()
        installRightButtonConstraints()
        installtextViewConstraints()
    }
    
    private func instalLeftButtonConstraints() {
        self.addSubview(leftButton)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func installRightButtonConstraints() {
        self.addSubview(rightButton)
           
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        rightButton.heightAnchor.constraint(equalToConstant: 26).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 26).isActive = true
    }
    
    private func installtextViewConstraints() {
        self.addSubview(textView)
        textView.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10).isActive = true
        textView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc func sendDidTapped(_ sender: UIButton) {
        sender.tapAnimation()
        var message = Message()
        message.text = self.textView.text
        self.textView.text = ""
        messageDidSend?(message)
    }
}

extension MessageBottomBar: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholderColor {
            textView.text = nil
            textView.textColor = textMessageColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder
            textView.textColor = placeholderColor
        }
    }
    
}
