//
//  RealmRepository.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxRealm
import RxSwift

protocol RealmRepository {
    
    associatedtype T
    func queryAll() -> Observable<[T]>
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor]) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
    
}
