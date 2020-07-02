//
//  DataExtensions.swift
//  Todo
//
//  Created by kimdo2297 on 2020/07/02.
//  Copyright © 2020 Jason. All rights reserved.
//

import Foundation

extension Data {
    static func readJSON(bundle: Bundle = .main, for name: String) -> Data? {
        guard let url = bundle.url(
        forResource: name,
        withExtension: "json"
        ) else { return nil }
        
        return try? Data(contentsOf: url)
    }
}
