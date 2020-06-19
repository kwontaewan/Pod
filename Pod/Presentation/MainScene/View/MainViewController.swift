//
//  MainViewController.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, StoryboardInstantiable {
    
    private var viewModel: MainViewModel!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    static func create(with viewModel: MainViewModel) -> MainViewController {
        let view = MainViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
