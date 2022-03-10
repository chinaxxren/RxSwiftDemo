//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 赵江明 on 2022/1/11.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    var tableView: UITableView!
    let dataVM =  MainVM()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView!.register(UITableViewCell.self, forCellReuseIdentifier: "MainCell")
        view.addSubview(tableView)
        
        dataVM.data.bind(to: tableView.rx.items(cellIdentifier: "MainCell")) { _,item,cell in
            cell.textLabel?.text = item.title
        }.disposed(by: disposeBag)
        

        tableView.rx.modelSelected(MainItem.self).subscribe { item in
            guard let elem = item.element else {
                return
            }
        
            guard let clsType = elem.clazz as? UIViewController.Type else {
                print("Can not append")
                return;
            }

            let vc = clsType.init()
            
            self.navigationController?.pushViewController(vc, animated:true)
        }.disposed(by: disposeBag)
    }
}

