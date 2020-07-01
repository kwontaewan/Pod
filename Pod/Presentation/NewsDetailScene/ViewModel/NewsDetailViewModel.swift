//
//  NewsDetailViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/06/26.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxCocoa
import RxSwift
import FirebaseFirestore

final class NewsDetailViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
    
        let viewDidAppear: Driver<Bool>
        
        let tapDeleteBookmark: Observable<Void>
        
        let tapBookmark: Observable<Void>
        
        let tapComment: Driver<Void>
   
    }
    
    struct Output {
        
        let news: News
        
        let isBookmark: Driver<Bool>
        
        let bookmark: Observable<Void>
        
        let deleteBookmark: Observable<Void>
        
        let tapComment: Driver<Void>
        
    }
    
    private let news: News
    
    private let firestoreUseCases: FirestoreUseCaseProtocol
    
    private let realmUseCases: RealmUseCaseProtocol
    
    private let coordinator: NewsDetailFlowCoordinator
    
    init(
        news: News,
        realmUseCases: RealmUseCaseProtocol,
        firestoreUseCases: FirestoreUseCaseProtocol,
        coordinator: NewsDetailFlowCoordinator
    ) {
        self.news = news
        self.realmUseCases = realmUseCases
        self.firestoreUseCases = firestoreUseCases
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let isBookmark = input.viewDidAppear
            .flatMapLatest { [unowned self] _ -> Driver<Bool> in
                return self.realmUseCases
                    .isBookmark(documentId: self.news.documentID)
                    .asDriver(onErrorJustReturn: false)
            }
        
        let bookmark = input.tapBookmark
            .flatMapLatest { [unowned self] () -> Observable<Void> in
                return self.realmUseCases
                    .saveBookmark(news: self.news)
                    .observeOn(MainScheduler.instance)
            }
        
        let deleteBookmark = input.tapDeleteBookmark
            .flatMapLatest { [unowned self] () -> Observable<Void> in
                return self.realmUseCases
                    .deleteBookmark(news: self.news)
                    .observeOn(MainScheduler.instance)
                
            }
        
        let tapComment = input.tapComment
            .do(onNext: { [weak self] (_) in
                self?.coordinator.showCommentView()
            })
        
        return Output(news: news, isBookmark: isBookmark, bookmark: bookmark, deleteBookmark: deleteBookmark, tapComment: tapComment)
    }
    
}
