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
    
    lazy var backTextView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        return v
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
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
        self.backTextView.layer.cornerRadius = 14
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
        self.addSubview(backTextView)
        backTextView.addSubview(textView)
        
        backTextView.translatesAutoresizingMaskIntoConstraints = false
        backTextView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10).isActive = true
        backTextView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -10).isActive = true
        backTextView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        backTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: backTextView.leadingAnchor, constant: 5).isActive = true
        textView.trailingAnchor.constraint(equalTo: backTextView.trailingAnchor, constant: -5).isActive = true
        textView.topAnchor.constraint(equalTo: self.backTextView.topAnchor, constant: 5).isActive = true
        textView.bottomAnchor.constraint(equalTo: self.backTextView.bottomAnchor, constant: -5).isActive = true
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
    
    func textViewDidChange(_ textView: UITextView) {

    }
    
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
