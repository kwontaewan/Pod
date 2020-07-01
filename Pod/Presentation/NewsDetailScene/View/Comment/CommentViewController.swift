//
//  CommentViewController.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import PanModal

class CommentViewController: BaseViewController, StoryboardInstantiable {

    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentTextField: UITextField!
        
    @IBOutlet weak var commentTextFieldBottomConstraint: NSLayoutConstraint!
    
    private var activityView: UIActivityIndicatorView!
    
    private var viewModel: CommentViewModel!
        
    static func create(with viewModel: CommentViewModel) -> CommentViewController {
        let view = CommentViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
        initKeyboardEvent()
    }
    
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
    
         activityView.center = CGPoint(
            x: self.view.frame.size.width / 2,
            y: 480 / 2
         )
         
         self.view.addSubview(activityView)
     }
        
    private func initView() {
        activityView = UIActivityIndicatorView(style: .gray)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupRx() {
        assert(viewModel != nil)
        
        let viewDidAppear = rx.viewDidAppear
            .take(1)
            .map { _ in () }
            .asDriverOnErrorJustComplete()
        
        let shouldReturn = commentTextField
            .rx
            .shouldReturn
            .do(onNext: { [weak self] (_) in
                self?.activityView.startAnimating()
            })
        
        let text = commentTextField.rx.text.orEmpty
        
        let registerComment = shouldReturn.withLatestFrom(text).asDriverOnErrorJustComplete()

        let input = CommentViewModel.Input(
            viewDidAppear: viewDidAppear,
            registerComment: registerComment
        )
        
        let output = viewModel.transform(input: input)
        
        output.registerComplete
            .drive(onNext: { [weak self] (_) in
                self?.commentTextField.endEditing(true)
                self?.commentTextField.text = ""
                self?.activityView.stopAnimating()
            }).disposed(by: disposeBag)
        
        output.comments
            .do(onNext: { [weak self] (comments) in
                
                let count = comments.count
                
                if count <= 0 {
                    self?.tableView.setEmptyView(image: Image.emptyCommentTableView)
                } else {
                    self?.tableView.restoreCell()
                }
                
                self?.commentCountLabel.text = "댓글 \(count)개"
            }).drive(
                tableView.rx.items(
                    cellIdentifier: CommentCell.reuseIdentifier,
                    cellType: CommentCell.self
            )
        ) { _, model, cell in
            cell.contentsLabel.text = model.contents
            cell.timeAgoLabel.text = model.registerAgo
        }.disposed(by: disposeBag)
        
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
