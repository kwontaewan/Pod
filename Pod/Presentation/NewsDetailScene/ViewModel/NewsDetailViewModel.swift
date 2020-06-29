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
    }
    
    struct Output {
        let news: News
    }
    
    private let news: News
    
    private let firestoreUseCases: FirestoreUseCaseProtocol
    
    private let realmUseCases: RealmUseCaseProtocol
    
    init(
        news: News,
        realmUseCases: RealmUseCaseProtocol,
        firestoreUseCases: FirestoreUseCaseProtocol
    ) {
        self.news = news
        self.realmUseCases = realmUseCases
        self.firestoreUseCases = firestoreUseCases
    }
    
    func transform(input: Input) -> Output {
        return Output(news: news)
    }
    
}
