//
//  Box.swift
//  iGet
//
//  Created by rigo on 12/06/2019.
//  Copyright © 2019 dev. All rights reserved.
//

class Box<T> {
    
    typealias Listener = (T) -> ()
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}
