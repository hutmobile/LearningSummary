//体会心得：在开始做这个之前，完全是什么都不知道，学长交给我们的任务就是做出来，时间还是比较宽松，大概有一两周时间，大概一周左右开始通过百度一些东西，基本已经形成了模样，过了一段时间，交给学长看了，有些问题。

/*主要问题： 1，命名不规范，没有采用正确的规范的命名格式（驼峰式命名法）
           2，代码没有规范，一些重复代码没有写成类。
           3，在主代码中，有大量相似代码，没有提前，比如有12个button全部放在了override func viewDidload（）中 

  总结：通过UI入门掌握了 基本的类，函数定义等基本知识点。对于纯代码写UI也有一定掌握。
*/


//关于我的swift UI入门的一个界面（工大助手界面）的源码

//
//  ViewController.swift
//  sy
//
//  Created by 张驰 on 2018/4/23.
//  Copyright © 2018年 张驰. All rights reserved.
//


import UIKit

public extension Double {
    var fitScreen: Double {
        return self/414.0 * Double(UIScreen.main.bounds.size.width)
    }
}

class PowerButton: UIButton {
    func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return min / 414 * float
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name:"#404040",size:CGFloatAutoFit(20))
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloatAutoFit(20))
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = UIColor.white
        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(95), CGFloatAutoFit(-105), CGFloatAutoFit(30), 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(20), CGFloatAutoFit(20), CGFloatAutoFit(35), CGFloatAutoFit(20));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PowerButton1: UIButton {
    func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return min / 414 * float
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name:"#404040",size:CGFloatAutoFit(20))
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloatAutoFit(20))
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = UIColor.white
        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(95), CGFloatAutoFit(-65), CGFloatAutoFit(30), 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(20), CGFloatAutoFit(30), CGFloatAutoFit(40), CGFloatAutoFit(30));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PowerButton2: UIButton {
    func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return min / 414 * float
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name:"#404040",size:CGFloatAutoFit(20))
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloatAutoFit(20))
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = UIColor.white
        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(95), CGFloatAutoFit(-75), CGFloatAutoFit(30), 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(20), CGFloatAutoFit(30), CGFloatAutoFit(40), CGFloatAutoFit(30));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PowerButton3: UIButton {
    func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return min / 414 * float
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont(name:"#404040",size:CGFloatAutoFit(20))
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloatAutoFit(20))
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = UIColor.white
        self.titleEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(95), CGFloatAutoFit(-80), CGFloatAutoFit(30), 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(CGFloatAutoFit(20), CGFloatAutoFit(30), CGFloatAutoFit(40), CGFloatAutoFit(30));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {

    func CGFloatAutoFit(_ float:CGFloat)->CGFloat {
        let min = UIScreen.main.bounds.height < UIScreen.main.bounds.width ? UIScreen.main.bounds.height :UIScreen.main.bounds.width
        return min / 414 * float
    }
    var bannerIv: UIImageView = {
        let v = UIImageView(image:UIImage(named:"banner"))
        v.frame = CGRect(x:0.fitScreen, y:-130.fitScreen, width:414.fitScreen, height:500.fitScreen)
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.autoresizingMask = .flexibleHeight
        return v
    }()
    
    var message1Iv: UIImageView = {
        let v = UIImageView(image:UIImage(named:"tongzhi"))
        v.frame = CGRect(x:15.fitScreen, y:285.fitScreen, width:30.fitScreen, height:30.fitScreen)
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.autoresizingMask = .flexibleHeight
        return v
    }()
    
    var newMenuIv: UIImageView = {
        let v = UIImageView(image:UIImage(named:"new-menu2"))
        v.frame = CGRect(x:15.fitScreen, y:20.fitScreen, width:20.fitScreen, height:20.fitScreen)
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.autoresizingMask = .flexibleHeight
        return v
    }()
    var textLa1: UILabel = {
        let l = UILabel();
        l.frame = CGRect.init(x: 60.fitScreen, y: 290.fitScreen, width: 150.fitScreen, height:50.fitScreen);
        l.adjustsFontSizeToFitWidth = true
        l.text = "这是一条通知......"
        l.textColor = UIColor.gray
        l.font = UIFont(name:"#adadad",size:24)
        return l
    }()
    
    var textLa2: UILabel = {
        let l = UILabel();
        l.frame = CGRect.init(x: 60.fitScreen, y: 265.fitScreen, width: 100.fitScreen, height:50.fitScreen);
        l.adjustsFontSizeToFitWidth = true
        l.text = "通知"
        l.font = UIFont(name:"#404040",size:28)
        return l
    }()
    var libraryBtn : PowerButton = {
        let  bt = PowerButton (type: .custom)
        bt.frame = CGRect(x: 7.fitScreen, y: 370.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("图书馆", for: .normal)
        bt.setImage(UIImage(named: "tushuguan"), for: .normal)
        return bt
    }()
    var curriculum1Btn : PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 107.fitScreen, y: 370.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("课程表", for: .normal)
        bt.setImage(UIImage(named: "kechengbiao"), for: .normal)
        return bt
    }()
    var examBtn : PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 207.fitScreen, y: 370.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("考试查询", for: .normal)
        bt.setImage(UIImage(named: "kaoshichaxun"), for: .normal)
        return bt
    }()
    var scoreBtn : PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 307.fitScreen, y: 370.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("成绩查询", for: .normal)
        bt.setImage(UIImage(named: "chengjichaxun"), for: .normal)
        return bt
    }()
    var onlineExerciseBtn : PowerButton3 = {
        let  bt = PowerButton3 (type: .custom)
        bt.frame = CGRect(x: 7.fitScreen, y: 470.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("网上作业", for: .normal)
        bt.setImage(UIImage(named: "wangshangzuoye"), for: .normal)
        return bt
    }()
    var secondaryMarketBtn : PowerButton2 = {
        let  bt = PowerButton2 (type: .custom)
        bt.frame = CGRect(x: 107.fitScreen, y: 470.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("二手市场", for: .normal)
        bt.setImage(UIImage(named: "ershoushichang"), for: .normal)
        return bt
    }()
    var socialBtn: PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 207.fitScreen, y: 470.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("校园说说", for: .normal)
        bt.setImage(UIImage(named: "shuoshuo"), for: .normal)
        return bt
    }()
    var electricityQueryBtn : PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 307.fitScreen, y: 470.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("电费查询", for: .normal)
        bt.setImage(UIImage(named: "dianfeichaxun"), for: .normal)
        return bt
    }()
    var lostAndFoundBtn : PowerButton2 = {
        let  bt = PowerButton2 (type: .custom)
        bt.frame = CGRect(x: 7.fitScreen, y: 570.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("失物招领", for: .normal)
        bt.setImage(UIImage(named: "shiwuzhaoling"), for: .normal)
        return bt
    }()
    var labBtn : PowerButton1 = {
        let  bt = PowerButton1 (type: .custom)
        bt.frame = CGRect(x: 107.fitScreen, y: 570.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("实验课表", for: .normal)
        bt.setImage(UIImage(named: "shiyankebiao"), for: .normal)
        return bt
    }()
    var videoBtn : PowerButton2 = {
        let  bt = PowerButton2 (type: .custom)
        bt.frame = CGRect(x: 207.fitScreen, y: 570.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("视频专栏", for: .normal)
        bt.setImage(UIImage(named: "shipinzhuanlan"), for: .normal)
        return bt
    }()
    var moreBtn : PowerButton2 = {
        let  bt = PowerButton2 (type: .custom)
        bt.frame = CGRect(x: 307.fitScreen, y: 570.fitScreen, width: 100.fitScreen, height: 100.fitScreen)
        bt.setTitle("更多", for: .normal)
        bt.setImage(UIImage(named: "more"), for: .normal)
        return bt
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bannerIv)
        view.addSubview(message1Iv)
        view.addSubview(newMenuIv)
        
        view.addSubview(textLa1)
        view.addSubview(textLa2)
        let blankLa = UILabel();
        blankLa.frame = CGRect.init(x: CGFloatAutoFit(0), y: CGFloatAutoFit(340), width: CGFloatAutoFit(414), height: CGFloatAutoFit(10));
        blankLa.backgroundColor = UIColor.gray
        view.addSubview(blankLa)
        
        let verbBtn = UIButton(type: .custom)
        verbBtn.frame = CGRect(x: 23
