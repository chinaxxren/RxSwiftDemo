//
//  ObservableController.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa

class ObservableController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white;
        
        self.demo2()
    }
    
    // （1）该方法通过传入一个默认值来初始化。
    // （2）下面样例我们显式地标注出了 observable 的类型为 Observable<Int>，即指定了这个 Observable 所发出的事件携带的数据类型必须是 Int 类型的。
    func demo1() {
        let observable = Observable<Int>.just(5)
        observable.subscribe { value in
            print(value)
        }
    }
    
    // （1）该方法可以接受可变数量的参数（必需要是同类型的）
    // （2）下面样例中我没有显式地声明出 Observable 的泛型类型，Swift 也会自动推断类型。
    func demo2() {
//        let observable = Observable.of("A", "B", "C")
//        observable.subscribe { value in
////            print(value)
//            print(value.element)
//        }
        
        let observable = Observable.of("A", "B", "C")
                 
        observable.subscribe(onNext: { element in
            print(element)
        })
    }
    
    //（1）该方法需要一个数组参数。
    //（2）下面样例中数据里的元素就会被当做这个 Observable 所发出 event 携带的数据内容，最终效果同上面饿 of() 样例是一样的。
    func demo3() {
        let observable = Observable.from(["A", "B", "C"])
        observable.subscribe { value in
            print(value)
        }
    }
    
    // 该方法创建一个空内容的 Observable 序列。
    func demo4() {
        let observable = Observable<Int>.empty()
        observable.subscribe { value in
            print(value)
        }
    }
    
    // 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
    func demo5() {
        let observable = Observable<Int>.never()
        observable.subscribe { value in
            print(value)
        }
    }
    
    // (1）这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
    //（2）下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
    func demo6() {
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
    }
    
    func demo7() {
        //延时5秒种后，每隔1秒钟发出一个元素
        //let observable = Observable<Int>.timer(5, period: 1, scheduler: MainScheduler.instance)
        
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
    }
}
