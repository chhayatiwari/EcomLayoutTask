//
//  GCDBlackBox.swift
//  EcomLayoutTask
//
//  Created by Chhaya Tiwari on 9/11/18.
//  Copyright © 2018 chhayatiwari. All rights reserved.
//

import Foundation
func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
