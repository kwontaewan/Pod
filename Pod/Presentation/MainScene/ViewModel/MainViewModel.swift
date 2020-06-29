//
//  MainViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxCocoa
import RxSwift
import FirebaseFirestore

final class MainViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        
        let viewDidAppear: Driver<Bool>
        
        let tag: PublishSubject<String> = PublishSubject<String>()
        
        let bookmark: PublishSubject<News> = PublishSubject<News>()
        
    }
    
    struct Output {
        
        let tags: Driver<[Tag]>
        
        let news: Observable<[MainNewsListViewModel]>
        
        let showIntro: Driver<Void>
        
        let bookmark: Observable<Void>
                
    }
    
    private let firestoreUseCases: FirestoreUseCaseProtocol
    
    private let realmUseCases: RealmUseCaseProtocol
    
    private let coordinator: MainFlowCoordinator
    
    init(
        firestoreUseCases: FirestoreUseCaseProtocol,
        realmUseCases: RealmUseCaseProtocol,
        coordinator: MainFlowCoordinator
    ) {
        self.firestoreUseCases = firestoreUseCases
        self.realmUseCases = realmUseCases
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
                
        let tags = input.viewDidAppear
            .flatMapLatest { (_) -> Driver<[Tag]> in
                return self.firestoreUseCases
                 .fetchTags()
                 .asDriver(onErrorJustReturn: [])
            }
        
        let news = input.tag.flatMapLatest { (tag) -> Observable<[MainNewsListViewModel]> in
            self.firestoreUseCases
                .fetchNewsList(tag: tag)
                .map { $0.map { MainNewsListViewModel(with: $0) } }
        }
        
        let showIntro = input.viewDidAppear
            .map { _ in Void() }
            .filter { (_) -> Bool in
                return !UserDefaultsManagement.getSkipIntro()
            }.do(onNext: { [weak self] _ in
                self?.coordinator.presentGuideView()
            })
        
        let bookmark = input.bookmark
            .flatMapLatest { (news) -> Observable<Void> in
                return self.realmUseCases.saveBookmark(news: news)
            }
        
        return Output(tags: tags, news: news, showIntro: showIntro, bookmark: bookmark)
    }
    
}
