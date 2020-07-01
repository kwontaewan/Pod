//
//  CommnetViewModel.swift
//  Pod
//
//  Created by Gunter on 2020/07/01.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxCocoa
import RxSwift

final class CommentViewModel: DetectDeinit, ViewModelType {
    
    struct Input {
        
        let viewDidAppear: Driver<Void>
        
        let registerComment: Driver<String>
    }
    
    struct Output {
        
        let comments: Driver<[CommentListItemViewModel]>
        
        let registerComplete: Driver<Void>
        
    }
    
    private let news: News
    
    private let firebaseUseCases: FirestoreUseCaseProtocol
    
    init(
        news: News,
        firebaseUseCases: FirestoreUseCaseProtocol
    ) {
        self.news = news
        self.firebaseUseCases = firebaseUseCases
    }
    
    func transform(input: Input) -> Output {
        
        let registerComplete = input.registerComment
            .flatMapLatest { [unowned self] (comment) -> Driver<Void> in
                return self.firebaseUseCases
                    .registerComment(
                        documentId: self.news.documentID,
                        authKey: UserDefaultsManagement.getUserAuth(),
                        contents: comment
                ).asDriverOnErrorJustComplete()
            }
    
        let comments = Driver.merge(input.viewDidAppear, registerComplete)
            .flatMapLatest { [unowned self] (_) -> Driver<[CommentListItemViewModel]> in
                return self.firebaseUseCases
                    .fetchComments(documentId: self.news.documentID)
                    .map { $0.map { CommentListItemViewModel(with: $0) } }
                    .asDriver(onErrorJustReturn: [])
            }
            
        return Output(comments: comments, registerComplete: registerComplete)
        
    }
    
}
