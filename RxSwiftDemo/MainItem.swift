//
//  MainItem.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//

import Foundation

struct MainItem {
    let title: String
    let clazz: AnyClass
    
    init(title:String,clazz:AnyClass) {
        self.title = title;
        self.clazz = clazz;
    }
}

//实现 CustomStringConvertible 协议，方便输出调试
extension MainItem: CustomStringConvertible {
    var description: String {
        return "title：\(title), clazz：\(clazz)"
    }
}
