//
//  MainViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxViewController
import Koloda
import RealmSwift
import pop

class MainViewController: BaseViewController, StoryboardInstantiable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var swipeCardView: KolodaView!
    
    private var viewModel: MainViewModel!
    
    private var news: [MainNewsListViewModel]?
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private let frameAnimationSpringBounciness: CGFloat = 9
    
    private let frameAnimationSpringSpeed: CGFloat = 16
    
    private let kolodaCountOfVisibleCards = 2
    
    private let kolodaAlphaValueSemiTransparent: CGFloat = 0.1
    
    private var input: MainViewModel.Input!
    
    private var isTagLoading: Bool = false
    
    static func create(with viewModel: MainViewModel) -> MainViewController {
        let view = MainViewController.instantiateViewController()
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
        log.info(Realm.Configuration.defaultConfiguration.fileURL!)
    }
        
    override func viewDidLayoutSubviews() {
        activityIndicator = UIActivityIndicatorView(frame:
            CGRect(
                x: UIScreen.main.bounds.size.width * 0.5,
                y: UIScreen.main.bounds.size.height * 0.5,
                width: 20,
                height: 20
            )
        )
        
        activityIndicator.color = UIColor.lightGray
        
        view.addSubview(activityIndicator)
                
    }
    
    private func initView() {

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
         }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = .white
        self.setupWhiteNavigationBar()
        swipeCardView.alphaValueSemiTransparent = kolodaAlphaValueSemiTransparent
        swipeCardView.countOfVisibleCards = kolodaCountOfVisibleCards
        swipeCardView.appearanceAnimationDuration = TimeInterval(0.5)
        swipeCardView.swipe(.left)
        swipeCardView.swipe(.right)
        swipeCardView.delegate = self
        swipeCardView.dataSource = self
      
    }
    
    private func setupRx() {
        
        assert(viewModel != nil)
        
        let viewDidAppear = rx.viewDidAppear
            .do(onNext: { [weak self] (_) in
                self?.activityIndicator.startAnimating()
            })
            .take(1)
            .asDriverOnErrorJustComplete()
        
        input = MainViewModel.Input(viewDidAppear: viewDidAppear)
        
        collectionView.rx.modelSelected(Tag.self)
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] (tag) in
                self?.input.tag.onNext(tag.name)
                self?.activityIndicator.startAnimating()
            }).disposed(by: disposeBag)
                
        let output = viewModel.transform(input: input)
        
        output.tags.drive(
            collectionView.rx.items(
                cellIdentifier: TagCell.reuseIdentifier,
                cellType: TagCell.self
            )
        ) { [weak self] index, model, cell in
            
            self?.activityIndicator.stopAnimating()
            
            if index == 0 && !(self?.isTagLoading ?? false) {
                self?.isTagLoading = true
                let selectedIndexPath = IndexPath(item: 0, section: 0)
                self?.collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
                cell.isSelected = true
                self?.input.tag.onNext(model.name)
            }
            
            cell.tagLabel.text = model.name
            
        }.disposed(by: disposeBag)
        
        output.news
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] (model) in
                self?.activityIndicator.stopAnimating()
                self?.news = model
                self?.swipeCardView.resetCurrentCardIndex()
                self?.swipeCardView.reloadData()
            }).disposed(by: disposeBag)
        
        output.showIntro
            .drive()
            .disposed(by: disposeBag)
        
        output.bookmark
            .subscribe(onNext: { _ in
                log.debug("save bookmark success")
            }, onError: { (error) in
                log.error(error)
            }).disposed(by: disposeBag)
                
    }
        
}

// MARK: KolodaViewDelegate
extension MainViewController: KolodaViewDelegate {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        log.debug("\(#function)")
        koloda.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == .left {
            log.debug("left")
            
            guard let news = news?[index] else {
                return
            }
              
            input.bookmark.onNext(news.news)
            
        } else {
            log.debug("right")
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
     
        guard let news = news?[index] else {
            return
        }
        
        self.appDelegate
            .appFlowCoordinator?
            .startNewsDetail(
                news: news.news,
                viewType: .main,
                navigationViewController: self.navigationController
        )
            
    }
    
    func kolodaShouldApplyAppearAnimation(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func kolodaShouldMoveBackgroundCard(_ koloda: KolodaView) -> Bool {
        return false
    }
    
    func kolodaShouldTransparentizeNextCard(_ koloda: KolodaView) -> Bool {
        return true
    }
    
    func koloda(kolodaBackgroundCardAnimation koloda: KolodaView) -> POPPropertyAnimation? {
        let animation = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        animation?.springBounciness = frameAnimationSpringBounciness
        animation?.springSpeed = frameAnimationSpringSpeed
        return animation
    }
            
}

// MARK: KolodaViewDataSource
extension MainViewController: KolodaViewDataSource {
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return news?.count ?? 0
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        
        guard let newsCardView = NewsCardView.loadFromXib(withOwner: self, options: nil) as? NewsCardView else {
            return UIView()
        }
        
        guard let news = news?[index] else {
            return newsCardView
        }
        
        newsCardView.titleLabel.text = news.title
        newsCardView.linkLabel.text = news.link
        newsCardView.tagLabel.text = news.tag
        newsCardView.timeAgoLabel.text = news.registerAgo
        newsCardView.newsImageView.setImage(with: news.imageUrl)
        
        return newsCardView
    }
    
}
