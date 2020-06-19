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
        
    }
    
    struct Output {
        
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
        
        return Output()
    }
    
}
