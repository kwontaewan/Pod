//
//  SettingViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/30.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController, StoryboardInstantiable {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBOutlet weak var eventNotificationSwitch: UISwitch!
    
    static func create() -> SettingViewController {
        let view = SettingViewController.instantiateViewController()
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupRx()
    }
    
    private func initView() {
        self.setupWhiteNavigationBar()
        self.navigationItem.title = "setting_title".localized
        notificationSwitch.isOn = UserDefaultsManagement.getNotification()
        eventNotificationSwitch.isOn = UserDefaultsManagement.getEventNotification()
    }
    
    private func setupRx() {
        
        notificationSwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(notificationSwitch.rx.value)
            .subscribe(onNext: { (isOn) in
                log.debug(isOn)
                UserDefaultsManagement.setNotification(isOn)
            }).disposed(by: disposeBag)
        
        eventNotificationSwitch.rx.controlEvent(.valueChanged)
            .withLatestFrom(eventNotificationSwitch.rx.value)
            .subscribe(onNext: { (isOn) in
                log.debug(isOn)
                UserDefaultsManagement.setEventNotification(isOn)
            }).disposed(by: disposeBag)
        
    }
    
}
