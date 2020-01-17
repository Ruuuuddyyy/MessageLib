//
//  MessageBottomBar.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 16.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit


class MessageBottomBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    
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
        Bundle.main.loadNibNamed("MessageBottomBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        self.textView.text = placeholder
        self.textView.textColor = placeholderColor
        self.textView.layer.cornerRadius = 14
        self.textView.delegate = self
    }
    
    @IBAction func sendDidTapped(_ sender: UIButton) {
        
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
