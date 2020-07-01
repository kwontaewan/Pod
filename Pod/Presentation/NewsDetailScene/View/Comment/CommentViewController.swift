//
//  CommentViewController.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import PanModal

class CommentViewController: BaseViewController, StoryboardInstantiable {

    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
        
    @IBOutlet weak var commentTextFieldBottomConstraint: NSLayoutConstraint!
    
    var viewType: ViewType?
    
    static func create() -> CommentViewController {
        let view = CommentViewController.instantiateViewController()
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initKeyboardEvent()
    }
        
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func initKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    @objc func keyBoardWillShow(notification: NSNotification) {

        let userInfo = notification.userInfo! as NSDictionary
        let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height - UIView.insetSafeAreaBottom
        let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animDuration) {
            self.commentTextFieldBottomConstraint.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
        
    }

    @objc func keyBoardWillHide(notification: NSNotification) {
        let userInfo = notification.userInfo! as NSDictionary
        let animDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        UIView.animate(withDuration: animDuration) {
            self.commentTextFieldBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension CommentViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseIdentifier, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        
        cell.contentsLabel.text = "asdfas"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}

extension CommentViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(480)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(480)
    }

    var anchorModalToLongForm: Bool {
        return false
    }
    
    var showDragIndicator: Bool {
        return true
    }
    
    var panModalBackgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.8)
    }
    
    func panModalDidDismiss() {
        log.debug("\(#function)")
    }
    
}
