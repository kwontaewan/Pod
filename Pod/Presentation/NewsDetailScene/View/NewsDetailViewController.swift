//
//  NewsDetailViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import WebKit

enum ViewType {
    case main
    case bookmark
}

class NewsDetailViewController: BaseViewController, StoryboardInstantiable, Alertable, UIGestureRecognizerDelegate {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var bottomNavigationView: UIView!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var commentButton: UIButton!
    
    private var webView: WKWebView!
    
    private var activityView: UIActivityIndicatorView!
    
    private var toastView: ToastView?
    
    private var viewModel: NewsDetailViewModel!
    
    var viewType: ViewType?
    
    static func create(with viewModel: NewsDetailViewModel) -> NewsDetailViewController {
        let view = NewsDetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let viewType = viewType, viewType == .main {
            navigationController?.navigationBar.isHidden = true
        }
    }
    
    private func initView() {
        
        toastView = ToastView()
        toastView?.inner(to: self.view)
        toastView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalTo(self.bottomNavigationView.snp.top).offset(-12)
        })
        
        if let viewType = viewType, viewType == .main {
            navigationController?.navigationBar.isHidden = false
        }
        
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        activityView = UIActivityIndicatorView(style: .gray)
        
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let confing = WKWebViewConfiguration()
        confing.preferences = preferences
        
        webView = WKWebView(frame: contentView.frame, configuration: confing)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            webView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        
    }
    
    private func setupRx() {
        
        let viewDidAppear = rx.viewDidAppear.asDriver()
        
        let deleteBookmarkTap = bookmarkButton.rx.tap
            .filter { [weak self] in
                return self?.bookmarkButton.isSelected ?? false
            }.asObservable()
        
        let bookmarkTap = bookmarkButton.rx.tap
            .filter { [weak self] in
                return !(self?.bookmarkButton.isSelected ?? false)
            }.asObservable()
        
        let input = NewsDetailViewModel.Input(viewDidAppear: viewDidAppear, tapDeleteBookmark: deleteBookmarkTap, tapBookmark: bookmarkTap)
        
        let ouput = viewModel.transform(input: input)
        
        if let url = URL(string: ouput.news.link) {
            let urlRequest = URLRequest(url: url)
            _ = webView.load(urlRequest)
        }
        
        self.navigationItem.title = ouput.news.title
        
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)

        shareButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let vc = UIActivityViewController(activityItems: [ouput.news.title, ouput.news.link], applicationActivities: [])
                self?.present(vc, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        ouput.isBookmark
            .drive(onNext: { [weak self] (isBookmark) in
                log.debug(isBookmark)
                self?.bookmarkButton.isSelected = isBookmark
            }).disposed(by: disposeBag)
        
        ouput.bookmark
            .subscribe(onNext: { [weak self] (_) in
                self?.toastView?.showToast(title: "bookmark_info".localized)
                self?.bookmarkButton.isSelected = true
            }, onError: { (error) in
                log.error(error)
            }).disposed(by: disposeBag)
        
        ouput.deleteBookmark
            .subscribe(onNext: { [weak self] (_) in
                self?.toastView?.showToast(title: "bookmark_cancel_info".localized)
                self?.bookmarkButton.isSelected = false
            }, onError: { (error) in
                log.error(error)
            }).disposed(by: disposeBag)
        
    }
    
     override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
    
         activityView.center = CGPoint(
             x: contentView.frame.size.width / 2,
             y: contentView.frame.size.height / 2
         )
         
         self.contentView.addSubview(activityView)
     }

}

extension NewsDetailViewController: WKNavigationDelegate {
 
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityView.stopAnimating()
        activityView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard navigationAction.navigationType == .other || navigationAction.navigationType == .reload  else {
             decisionHandler(.cancel)
             return
         }
         decisionHandler(.allow)
        
    }
    
}
