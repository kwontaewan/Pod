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
        
    }
    
    struct Output {
        
        let tags: Driver<[Tag]>
        
        let news: Observable<[MainNewsListViewModel]>
                
    }
    
    private let firestoreUseCases: FirestoreUseCaseProtocol
    
    private let coordinator: MainFlowCoordinator
    
    init(
        firestoreUseCases: FirestoreUseCaseProtocol,
        coordinator: MainFlowCoordinator
    ) {
        self.firestoreUseCases = firestoreUseCases
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
        
        return Output(tags: tags, news: news)
    }
    
}
