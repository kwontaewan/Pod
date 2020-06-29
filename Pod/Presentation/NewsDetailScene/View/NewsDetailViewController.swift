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
        let input = NewsDetailViewModel.Input()
        
        let ouput = viewModel.transform(input: input)
        
        if let url = URL(string: ouput.news.link) {
            let urlRequest = URLRequest(url: url)
            _ = webView.load(urlRequest)
        }
        
        self.navigationItem.title = ouput.news.title
        self.navigationController?.navigationBar.topItem?.title = "Profile Settings"
        
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)

        shareButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] _ in
                let vc = UIActivityViewController(activityItems: [ouput.news.title ,ouput.news.link], applicationActivities: [])
                self?.present(vc, animated: true, completion: nil)
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
    
}
