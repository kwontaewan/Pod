//
//  RealmDAO.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import RxRealm

final class RealmDAO<T:RealmRepresentable>: RealmRepository where T == T.RealmType.DomainType, T.RealmType: Object {
    private let configuration: Realm.Configuration
    private let scheduler: RunLoopThreadScheduler

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        let name = "com.CleanArchitectureRxSwift.RealmPlatform.Repository"
        self.scheduler = RunLoopThreadScheduler(threadName: name)
        print("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }

    func queryAll() -> Observable<[T]> {
        return Observable.deferred {
                    let realm = self.realm
                    let objects = realm.objects(T.RealmType.self)
                    return Observable.array(from: objects).mapToDomain()
                }
                .subscribeOn(scheduler)
    }

    func query(with predicate: NSPredicate,
                        sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        return Observable.deferred {
                    let realm = self.realm
                    let objects = realm.objects(T.RealmType.self)
//            The implementation is broken since we are not using predicate and sortDescriptors
//            but it cause compiler to crash with xcode 8.3 ¯\_(ツ)_/¯
//                            .filter(predicate)
//                            .sorted(by: sortDescriptors.map(SortDescriptor.init))

                    return Observable.array(from: objects)
                            .mapToDomain()
                }
                .subscribeOn(scheduler)
    }

    func save(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.save(entity: entity)
        }.subscribeOn(scheduler)
    }

    func delete(entity: T) -> Observable<Void> {
        return Observable.deferred {
            return self.realm.rx.delete(entity: entity)
        }.subscribeOn(scheduler)
    }

}
