//
//  MessageBottomBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 16.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit


final class MessageBottomBar: UIView {
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cameraIcon"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "sendButtonIcon"), for: .normal)
        button.addTarget(self, action: #selector(sendDidTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        tv.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        tv.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()

    public var placeholder = "Write a message..."
    public var placeholderColor = UIColor.lightGray
    public var textMessageColor = UIColor.black
    
    /// - Default value is 44
    public var bottomBarHeight: CGFloat = 44
    var messageDidSend: ((Message)->())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
       
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
       
    private func setupViews() {
        textView.text = placeholder
        textView.textColor = placeholderColor
        textView.layer.cornerRadius = 14
        textView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
        textView.layer.borderWidth = 1
        textView.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(textView)
        
        let heightView = bottomBarHeight + MessageHelper.isDeviceHaveBrow()
        
        let constraints = [
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            leftButton.heightAnchor.constraint(equalToConstant: 28),
            leftButton.widthAnchor.constraint(equalToConstant: 30),
            
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rightButton.heightAnchor.constraint(equalToConstant: 26),
            rightButton.widthAnchor.constraint(equalToConstant: 26),
            
            textView.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor, constant: -10),
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            heightAnchor.constraint(equalToConstant: heightView)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func sendDidTapped(_ sender: UIButton) {
        sender.tapAnimation()
        var message = Message()
        message.text = textView.text
        textView.text = ""
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
