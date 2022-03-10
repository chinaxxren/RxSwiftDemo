//
//  BindCotronller.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//


import UIKit
import RxSwift
import RxCocoa

class BindController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.demo5()
    }
    
    func demo1() {
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        observable.map { "当前索引数：\($0 )"}
                  .bind { [weak self](text) in
                      //收到发出的索引数后显示到label上
                      print("\(text)")
                  }
                  .disposed(by: disposeBag)
    }
    
    func demo2() {
        //观察者
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed...")
            }
        }
         
        let observable = Observable.of("A", "B", "C")
        observable.subscribe(observer)
    }
    
    func demo3() {
        //观察者
        let observer: AnyObserver<String> = AnyObserver { [weak self] (event) in
            switch event {
            case .next(let text):
                //收到发出的索引数后显示到label上
                print(text)
            default:
                break
            }
        }
         
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    func demo4() {
        let label = UILabel(frame: view.frame);
        label.text = "123"
        label.font = UIFont.systemFont(ofSize: 0)
        label.textAlignment = .center
        view .addSubview(label)
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
        observable
           .map { CGFloat($0) }
           .bind(to: label.fontSize) //根据索引数不断变放大字体
           .disposed(by: disposeBag)
    }
    
    func demo5(){
        let label = UILabel(frame: view.frame);
        label.textAlignment = .center
        view .addSubview(label)
        
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: label.rx.text) //收到发出的索引数后显示到label上
            .disposed(by: disposeBag)
        
    }
}

extension UILabel {

    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            if fontSize >= 100 {
                return
            }
            
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }

}

extension Reactive where Base: UILabel {

    /// Bindable sink for `text` property.
    public var text: Binder<String?> {
        return Binder(self.base) { label, text in
            label.text = text
        }
    }
 
    /// Bindable sink for `attributedText` property.
    public var attributedText: Binder<NSAttributedString?> {
        return Binder(self.base) { label, text in
            label.attributedText = text
        }
    }
    
}
