//
//  MainVM.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//

import Foundation
import RxSwift

struct MainVM {
    let data = Observable.just([
        MainItem(title: "Obervable", clazz: ObservableController.self),
        MainItem(title: "Bind", clazz: BindController.self),
        MainItem(title: "Subjects", clazz: SubjectsCotroller.self),
        MainItem(title: "Transforming", clazz: TransformingController.self),
        MainItem(title: "title4", clazz: ObservableController.self),
        MainItem(title: "title5", clazz: ObservableController.self),
    ])
}
