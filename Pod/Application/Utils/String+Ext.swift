//
//  String+Ext.swift
//  Pod
//
//  Created by Gunter on 2020/06/23.
//  Copyright © 2020 Gunter. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
