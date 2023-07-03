//
//  FileManagerExtension.swift
//  Flashzilla
//
//  Created by Philipp Sanktjohanser on 10.02.23.
//

import Foundation

extension FileManager {
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
