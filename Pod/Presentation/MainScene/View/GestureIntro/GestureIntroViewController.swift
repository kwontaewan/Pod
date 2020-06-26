//
//  GestureIntroViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/25.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit
import RxCocoa

class GestureIntroViewController: BaseViewController, StoryboardInstantiable {

    @IBOutlet weak var startButton: BorderUIButton!
    
    static func create() -> GestureIntroViewController {
        let view = GestureIntroViewController.instantiateViewController()
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
    }
    
    private func setupRx() {
        startButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] (_) in
                UserDefaultsManagement.setSkipIntro()
                self?.dismiss(animated: false, completion: nil)
            }).disposed(by: disposeBag)
    }
    
}
