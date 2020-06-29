//
//  BookmarkViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxCocoa
import RxSwift

final class BookmarkViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        
        let viewDidAppaer: Driver<Bool>
        
    }
    
    struct Output {
        
        let bookmarkList: Driver<[BookmarkListItemViewModel]>
        
    }
    
    private let realmUseCases: RealmUseCaseProtocol
    
    private let coordinator: BookmarkCoordinator
    
    init(
        realmUseCases: RealmUseCaseProtocol,
        coordinator: BookmarkCoordinator
    ) {
        self.realmUseCases = realmUseCases
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        let bookmarkList = input.viewDidAppaer
            .flatMapLatest { (_) -> Driver<[BookmarkListItemViewModel]> in
                return self.realmUseCases
                .fetchBookmark()
                .map { $0.map { BookmarkListItemViewModel(with: $0) } }
                .asDriver(onErrorJustReturn: [])
            }
        
        return Output(bookmarkList: bookmarkList)
    }
    
}
