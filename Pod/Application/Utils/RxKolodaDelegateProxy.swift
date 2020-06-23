//
//  RxKolodaDelegateProxy.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import RxSwift
import RxCocoa
import Koloda

class RxKolodaDelegateProxy:
DelegateProxy<KolodaView, KolodaViewDelegate>,
DelegateProxyType,
KolodaViewDelegate {
    
    static func registerKnownImplementations() {
        self.register { (kolodaView) -> RxKolodaDelegateProxy in
            RxKolodaDelegateProxy(parentObject: kolodaView, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: KolodaView) -> KolodaViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: KolodaViewDelegate?, to object: KolodaView) {
        object.delegate = delegate
    }
    
    // MARK: - Proxy Subject
    internal lazy var didSelectCardAt = PublishSubject<Int>()
    
    // MARK: - KolodaViewDelegate
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        didSelectCardAt.onNext(index)
    }
    
    deinit {
        log.verbose("RxKolodaDelegateProxy deinit")
        didSelectCardAt.onCompleted()
    }
    
}

extension Reactive where Base: KolodaView {
    public var didSelectCardAt: Observable<Int> {
        return RxKolodaDelegateProxy.proxy(for: base)
            .didSelectCardAt
            .asObservable()
    }
}
