//
//  TransformingController.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//


import UIKit
import RxSwift
import RxCocoa

class TransformingController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
    }
    
    /*
     buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。
     该方法简单来说就是缓存 Observable 中发出的新元素，当元素达到某个数量，或者经过了特定的时间，它就会将这个元素集合发送出来
     */
    func demo1() {
        let subject = PublishSubject<String>()
        
       //每缓存3个元素则组合起来一起发出。
       //如果1秒钟内不够3个也会发出（有几个发几个，一个都没有发空数组 []）
        subject
            .buffer(timeSpan: .seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")

        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    /*
     window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
     同时 buffer 要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
     */
    func demo2() {
        let subject = PublishSubject<String>()
              
        //每3个元素作为一个子Observable发出。
        subject
            .window(timeSpan: .seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                print("subscribe: \($0)")
                $0.asObservable()
                  .subscribe(onNext: { print($0) })
                  .disposed(by: self!.disposeBag)
         })
         .disposed(by: disposeBag)

        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")

        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }

    // 该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。
    func demo3() {
        let disposeBag = DisposeBag()
         
        Observable.of(1, 2, 3)
            .map { $0 * 10}
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)

    }
    
    /*
     map 在做转换的时候容易出现“升维”的情况。即转变之后，从一个序列变成了一个序列的序列。
     而 flatMap 操作符会对源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。即又将其 "拍扁"（降维）成一个 Observable 序列。
     这个操作符是非常有用的。比如当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来。
     */
    func demo4() {
        let disposeBag = DisposeBag()
         
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorRelay(value: subject1)
         
        variable.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        subject2.onNext("2")
        subject1.onNext("C")
    }
}
