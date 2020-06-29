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
        
    }
    
    struct Output {
        let news: News
    }
    
    private let news: News
    
    private let firestoreUseCases: FirestoreUseCaseProtocol
    
    init(news: News, firestoreUseCases: FirestoreUseCaseProtocol) {
        self.news = news
        self.firestoreUseCases = firestoreUseCases
    }
    
    func transform(input: Input) -> Output {
        return Output(news: news)
    }
    
}
