//
//  Realm+Ext.swift
//  Pod
//
//  Created by Gunter on 2020/06/29.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension SortDescriptor {
    init(sortDescriptor: NSSortDescriptor) {
        self.init(keyPath: sortDescriptor.key ?? "", ascending: sortDescriptor.ascending)
    }
}

extension Reactive where Base == Realm {
    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<Void> where R.RealmType: Object  {
        return Observable.create { observer in
            do {
                try self.base.write {
                    self.base.add(entity.asRealm(), update: .all)
                }
                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            do {
                guard let object = self.base.object(ofType: R.RealmType.self, forPrimaryKey: entity.documentID) else { fatalError() }

                try self.base.write {
                    self.base.delete(object)
                }

                observer.onNext(())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}

protocol DomainConvertibleType {
    
    associatedtype DomainType

    func toDomain() -> DomainType

}

protocol RealmRepresentable {
    
    associatedtype RealmType: DomainConvertibleType

    var documentID: String {get}
    
    func asRealm() -> RealmType

}
