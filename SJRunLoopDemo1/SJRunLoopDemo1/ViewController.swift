//
//  ViewController.swift
//  SJRunLoopDemo1
//
//  Created by SoulJa on 2017/6/30.
//  Copyright © 2017年 sdp. All rights reserved.
//  保证线程的长时间存活

import UIKit

class ViewController: UIViewController {
    var subThread = SJThread()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //测试线程的销毁
        self .threadTest()
    }
    
    //MARK:测试线程
    func threadTest() {
        subThread = SJThread.init(target: self, selector: #selector(subThreadEntryPoint), object: nil);
        subThread.name = "SJThread"
        subThread.start()
    }
    
    //启动RunLoop
    func subThreadEntryPoint() {
        let runloop:RunLoop = RunLoop.current
        runloop.add(NSMachPort(), forMode: .commonModes)
        runloop.run()
    }
    
    //MARK:执行线程操作
    func subThreadOperation() {
        print(String.init(format: "Runloop开启之后-----%@", RunLoop.current.currentMode! as CVarArg))
        print(String.init(format: "%@", Thread.current) + "-----开启子线程")
        Thread.sleep(forTimeInterval: 3.0)
        print(String.init(format: "%@", Thread.current) + "-----完成子线程")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.perform(#selector(subThreadOperation), on: subThread, with: nil, waitUntilDone: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

