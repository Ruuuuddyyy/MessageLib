//
//  MessageLibController.swift
//  MessageLib
//
//  Created by Artem Vlasenko on 14.11.2019.
//  Copyright © 2019 Artem Vlasenko. All rights reserved.
//

import UIKit

class MessageLibController: UIViewController {
    
    @IBOutlet weak var messageCollectionView: MessageCollectionView!
    @IBOutlet weak var messageTopBar: MessageTopBar!
    @IBOutlet weak var messageBottomBar: MessageBottomBar!
    @IBOutlet weak var topBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTopBarSeparator: UIView!
    @IBOutlet weak var messageBottomBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topBarTopConstraint: NSLayoutConstraint!
    
    private var messagesArray = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let message1 = Message(images: nil, text: "Привет, как у тебя дела? я кста прошел dark souls)))", date: Date(), chatRole: .mainUser)
        let message3 = Message(images: nil, text: "Привет, как у тебя дела? я кста прошел dark souls)))", date: Date(), chatRole: .mainUser)

        let message2 = Message(images: nil, text: "Нормас кста)))", date: Date(), chatRole: .minorUser)
        let message4 = Message(images: nil, text: "Привет, как у тебя дела? я кста прошел dark souls)))", date: Date(), chatRole: .mainUser)

        messagesArray.append(message1)
        messagesArray.append(message2)
        messagesArray.append(message3)
        messagesArray.append(message4)

        installViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        subscribeToNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        unsubcribeNotifications()
    }

    private func installViews() {
        topBarTopConstraint.constant = MessageHelper.isDeviceHaveBrow() ? -24 : 0
        topBarHeightConstraint.constant = MessageHelper.isDeviceHaveBrow() ? 88 : 64
        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self
       
        messageCollectionView.register(MessageCell.self, forCellWithReuseIdentifier: "MessageCell")
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
       
    private func unsubcribeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Foundation.Notification) {
        let keyboardSize = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        messageBottomBarBottomConstraint.constant = keyboardSize.height
    }
    
    @objc func keyboardWillHide(_ notification: Foundation.Notification) {
        messageBottomBarBottomConstraint.constant = 0
        if self.messageBottomBar.textView.text.isEmpty {
//            self.messageBottomBar.placeholderLabel.isHidden = false
        }
    }
    
}

extension MessageLibController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let data = self.messagesArray[indexPath.item]

        cell.fillCell(message: data)
        
        if let textString = self.messagesArray[indexPath.row].text {
            let font = UIFont.systemFont(ofSize: 17)
            let size = CGSize(width: view.bounds.width - 60, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let attributes = [NSAttributedString.Key.font : font]
            let estimatedFrame = NSString(string: textString).boundingRect(with: size,
                                                                            options: options,
                                                                            attributes: attributes,
                                                                            context: nil)
            cell.messageLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 60, height: estimatedFrame.height)
            cell.messageContentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 60, height: estimatedFrame.height + 10)
        }
              
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let textString = self.messagesArray[indexPath.row].text
        let font = UIFont.systemFont(ofSize: 17)
        let size = CGSize(width: view.bounds.width - 60, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedString.Key.font : font]
        let estimatedFrame = NSString(string: textString!).boundingRect(with: size, options: options, attributes: attributes, context: nil)

        return CGSize(width: view.frame.width, height: estimatedFrame.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
//     }
    
    func messageCollectionView(_ messages: [Message]) {
        self.messagesArray = messages
    }
    
}
