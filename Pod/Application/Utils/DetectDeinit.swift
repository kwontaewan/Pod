//
//  DetectDeinit.swift
//  Pod
//
//  Created by Gunter on 2020/06/19.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

class DetectDeinit: NSObject {
    
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
      log.verbose("DEINIT: \(self.className)")
    }
    
}
