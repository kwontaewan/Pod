//
//  BookmarkViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: BaseViewController, StoryboardInstantiable {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: BookmarkViewModel!
    
    static func create(with viewModel: BookmarkViewModel) -> BookmarkViewController {
        let view = BookmarkViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    private func initView() {
        self.setupWhiteNavigationBar()
        self.navigationItem.title = "bookmark_title".localized
        self.tableView.backgroundColor = .white
    }
    
    private func setupRx() {
        assert( viewModel != nil )
        
        let viewDidAppear = rx.viewDidAppear.asDriver()
                
        let input = BookmarkViewModel.Input(viewDidAppaer: viewDidAppear)
        
        let output = viewModel.transform(input: input)
        
        output.bookmarkList.drive(
            tableView.rx.items(
                cellIdentifier: BookmarkCell.reuseIdentifier,
                cellType: BookmarkCell.self)
        ) { _, model, cell in
            
            cell.newsImageView.setImage(with: model.imageUrl)
            cell.titleLabel.text = model.title
            cell.linkLabel.text = model.link
            
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(BookmarkListItemViewModel.self)
            .asDriver()
            .drive(onNext: { [weak self] model in
                self?.appDelegate
                     .appFlowCoordinator?
                     .startNewsDetail(
                         news: model.news,
                         viewType: .bookmark,
                         navigationViewController: self?.navigationController
                 )
            }).disposed(by: disposeBag)
        
    }
    
}
