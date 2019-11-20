//
//  DelayedTask.swift
//  MiYouPin
//
//  Created by 赵锡光 on 2019/11/16.
//  Copyright © 2019 Mr.Zhao. All rights reserved.
//

import Foundation

class DelayedTask: NSObject {
    typealias Task = () -> Void
    private var tasks: [String: (TimeInterval,Task)] = [:]
    var isCancelled: [String: Bool] = [:]
    var isInvalidate = [String: Bool]()
    
    func addTask(withDelay: TimeInterval, id: String, task: @escaping ()->Void) {
        self.isCancelled[id] = false
        self.isInvalidate[id] = false
        tasks[id] = (withDelay, task)
        startTask(id)
    }
    
    func startTask(_ id: String) {
        if let taskInfo = tasks[id] {
            DispatchQueue.main.asyncAfter(deadline: .now() + taskInfo.0) {
                if let isCancelled = self.isCancelled[id], let isInvalidate = self.isInvalidate[id] {
                    if !isCancelled && !isInvalidate {
                        taskInfo.1()
                    } else {
                        self.isInvalidate[id] = true
                    }
                }
            }
        }
    }
    
    func cancel(_ id: String) {
        isCancelled[id] = true
    }
    
    func resume(_ id: String) {
        isCancelled[id] = false
        if isInvalidate[id]! {
            isInvalidate[id] = false
            startTask(id)
        }
    }
}
