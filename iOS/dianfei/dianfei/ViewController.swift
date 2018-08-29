//  Created by 604 on 2018/4/21. Copyright  2018年 zhangsaidong. All rights reserved.
import UIKit

class PowerLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.shadowColor = UIColor.lightGray
        self.shadowOffset = CGSize(width: 1,height:1)
        self.textAlignment = NSTextAlignment.center
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PowertextField: UITextField{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.alpha=1
        self.font = UIFont(name: "Arial",size:18)
        self.textColor = UIColor.white
        self.autocorrectionType = UITextAutocorrectionType.no
        self.returnKeyType = UIReturnKeyType.done
        self.clearButtonMode = UITextFieldViewMode.whileEditing
        self.keyboardType = UIKeyboardType.numberPad
        self.keyboardAppearance = UIKeyboardAppearance.light
        self.delegate = self as? UITextFieldDelegate
        self.textAlignment = NSTextAlignment.center
        self.backgroundColor = UIColor.clear
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PprogressView: UIProgressView{
    override init(frame: CGRect){
        super.init(frame: frame)
        self.progressViewStyle = UIProgressViewStyle.bar
        self.progressViewStyle = UIProgressViewStyle.default
        self.progress = 1
        self.progressTintColor = UIColor.black
        self.trackTintColor = UIColor.black
        self.progressImage = UIImage(named:"a10")
        self.trackImage = UIImage(named:"a10")
        self.setProgress(1, animated: true)
        self.contentMode = .scaleAspectFit
        self.transform = CGAffineTransform(scaleX: 1.0,y: 10.0)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 45
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PowerButton: UIButton  {
    override init(frame: CGRect){
        super.init(frame:frame)
        self.setTitleColor(UIColor.white, for:UIControlState())
        self.titleLabel?.font = UIFont(name: "Arial",size:24)
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Double {
    var fitScreen: Double {
        return self/414.0 * Double(UIScreen.main.bounds.size.width)
    }
}

class ViewController: UIViewController {
    var imgView: UIImageView = {
        let v = UIImageView(image: UIImage(named:"a7.jpg"))
        v.frame = CGRect(x:0.fitScreen, y:0.fitScreen, width:414.fitScreen, height:737.fitScreen)
        return v
    }()
    var btn: PowerButton = {
        let bt = PowerButton(type:UIButtonType.roundedRect)
        bt.frame = CGRect (x:0.fitScreen, y:0.fitScreen, width:414.fitScreen,height:737.fitScreen)
        let image3 = UIImage(named:"a7.jpg")
        bt.setBackgroundImage(image3,for:UIControlState())
        bt.setTitle(" ",for: UIControlState())
        bt.setTitleColor(UIColor.white, for:UIControlState())
        bt.titleLabel?.font = UIFont(name: "Arial",size:24)
        bt.addTarget(self,action: #selector(ViewController.buttonTap4(_:)),for: UIControlEvents.touchUpInside)
        return bt
    }()
    var btn1: UIButton = {
        let bt1 = UIButton(type: UIButtonType.roundedRect)
        bt1.frame = CGRect(x:0.fitScreen,y:30.fitScreen,width:20.fitScreen,height:25.fitScreen)
        bt1.setBackgroundImage(UIImage(named: "a11"), for: UIControlState())
        bt1.setTitle(" ",for: UIControlState())
        bt1.setTitleColor(UIColor.white, for:UIControlState())
        bt1.titleLabel?.font = UIFont(name: "Arial",size:24)
        bt1.addTarget(self,action: #selector(ViewController.buttonTap(_:)),for: UIControlEvents.touchUpInside)
        return bt1
    }()
    var btn2: PowerButton = {
        let bt2 = PowerButton(type: UIButtonType.roundedRect)
        let rect8 = CGRect (x:333.fitScreen,y:543.fitScreen,width:25.fitScreen,height:25.fitScreen)
        bt2.frame = rect8
        let image1 = UIImage(named: "a9")
        bt2.setBackgroundImage(image1, for: UIControlState())
        bt2.setTitle(" ",for: UIControlState())
        bt2.setTitleColor(UIColor.white, for:UIControlState())
        bt2.titleLabel?.font = UIFont(name: "Arial",size:22)
        bt2.addTarget(self,action: #selector(ViewController.buttonTap1(_:)),for: UIControlEvents.touchUpInside)
        return bt2
    }()
    var btn3: PowerButton = {
        let bt3 = PowerButton(type: UIButtonType.roundedRect)
        
        bt3.frame = CGRect (x:333.fitScreen,y:508.fitScreen,width:25.fitScreen,height:25.fitScreen)
        let image2 = UIImage(named: "a9")
        bt3.setBackgroundImage(image2, for: UIControlState())
        bt3.setTitle(" ",for: UIControlState())
        bt3.titleLabel?.font = UIFont(name: "Arial",size:22)
        bt3.addTarget(self,action: #selector(ViewController.buttonTap2(_:)),for: UIControlEvents.touchUpInside)
        return bt3
    }()
    var btn4: PowerButton = {
        let bt4 = PowerButton(type: UIButtonType.roundedRect)
        bt4.frame = CGRect (x:95.fitScreen,y:420.fitScreen,width:250.fitScreen,height:30.fitScreen)
        bt4.backgroundColor = UIColor.clear
        bt4.setTitle("查询",for: UIControlState())
        bt4.titleLabel?.font = UIFont(name: "Arial",size:23)
        bt4.addTarget(self,action: #selector(ViewController.buttonTap3(_:)),for: UIControlEvents.touchUpInside)
        bt4.layer.masksToBounds = true
        bt4.layer.cornerRadius = 16
        bt4.layer.borderWidth = 2
        bt4.layer.borderColor = UIColor.lightText.cgColor
        return bt4
    }()
    
    
    var Label: PowerLabel = {
        let label = PowerLabel(frame: CGRect(x: 160.fitScreen,y: 25.fitScreen,width: 100, height: 40))
        label.text = "电费查询"
        label.alpha = 0.8
        label.font = UIFont (name: "Arial",size: 24)
        return label
    }()
    var Label2: PowerLabel = {
        let label2 = PowerLabel(frame: CGRect(x: 20.fitScreen,y:500.fitScreen,width:100.fitScreen,height:40.fitScreen))
        label2.text = "今天"
        label2.alpha = 0.7
        label2.font = UIFont (name: "Arial",size:20)
        return label2
    }()
    var Label3: PowerLabel = {
        let label3 = PowerLabel (frame:CGRect(x: 20.fitScreen,y: 535.fitScreen,width: 200.fitScreen,height: 40.fitScreen))
        label3.text = "宿舍开空调了吗"
        label3.alpha = 0.7
        label3.font = UIFont (name: "Arial",size:20)
        return label3
    }()
    var Label4: PowerLabel = {
        let label4 = PowerLabel(frame: CGRect(x: 250.fitScreen,y:500.fitScreen,width:100.fitScreen,height:40.fitScreen))
        label4.text = "开了"
        label4.alpha = 0.8
        label4.font = UIFont(name: "Arial",size:22)
        return label4
    }()
    var Label5: PowerLabel = {
        let label5 = PowerLabel(frame: CGRect(x: 250.fitScreen,y: 535.fitScreen,width: 100.fitScreen,height: 40.fitScreen))
        label5.text = "没开"
        label5.alpha = 0.8
        label5.font = UIFont (name: "Arial",size:22)
        return label5
    }()
    var Label6: PowerLabel = {
        let label6 = PowerLabel(frame: CGRect(x: 20.fitScreen,y:600.fitScreen,width:100.fitScreen,height:40.fitScreen))
        label6.text = "开了"
        label6.alpha = 0.8
        label6.font = UIFont (name: "Arial",size:22)
        return label6
    }()
    var Label7: PowerLabel = {
        let label7 = PowerLabel(frame: CGRect(x: 20.fitScreen,y: 635.fitScreen,width: 100.fitScreen,height: 40.fitScreen))
        label7.text = "没开"
        label7.alpha = 0.8
        label7.font = UIFont (name: "Arial",size:22)
        return label7
    }()
    var Label8: PowerLabel = {
        let label8 = PowerLabel(frame: CGRect(x: 95.fitScreen,y: 294.fitScreen,width: 250.fitScreen, height: 30.fitScreen))
        label8.text = "______________"
        label8.alpha = 0.7
        label8.font = UIFont (name: "Arial",size: 24)
        label8.shadowColor = UIColor.white
        return label8
    }()
    var Label9: PowerLabel = {
        let label9 = PowerLabel(frame: CGRect(x: 95.fitScreen,y: 350.fitScreen,width: 250.fitScreen, height: 30.fitScreen))
        label9.text = "______________"
        label9.alpha = 0.7
        label9.font = UIFont (name: "Arial",size: 24)
        label9.shadowColor = UIColor.white
        return label9
    }()
    
    
    var TextField: PowertextField = {
        let textField = PowertextField(frame: CGRect(x: 120.fitScreen,y: 280.fitScreen,width: 200.fitScreen,height: 30.fitScreen))
        textField.attributedPlaceholder = NSAttributedString.init(string:"宿舍楼栋", attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize:15)])
        textField.attributedPlaceholder = NSAttributedString.init(string:"宿舍楼栋", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey: UIColor.white])
        textField.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 31))
        textField.rightViewMode = .always
        return textField
    }()
    var TextField1: PowertextField = {
        let textField1 = PowertextField(frame: CGRect(x: 120.fitScreen,y: 340.fitScreen,width:200.fitScreen,height:30.fitScreen))
        textField1.attributedPlaceholder = NSAttributedString.init(string:"寝室号", attributes: [kCTFontAttributeName as NSAttributedStringKey:UIFont.systemFont(ofSize:15)])
        textField1.attributedPlaceholder = NSAttributedString.init(string:"寝室号", attributes: [kCTForegroundColorAttributeName as NSAttributedStringKey:UIColor.white])
        textField1.setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        textField1.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 31))
        textField1.rightViewMode = .always
        return textField1
    }()
    
    
    var ProgressView: PprogressView = {
        let progressView = PprogressView(frame: CGRect(x: 55.fitScreen,y: 619.fitScreen,width: 260.fitScreen,height: 500.fitScreen))
        return progressView
    }()
    var ProgressView1: PprogressView = {
        let progressView1 = PprogressView(frame: CGRect(x: 55.fitScreen,y: 654.fitScreen,width: 260.fitScreen,height: 500.fitScreen))
        return progressView1
    }()
    
    
    var Alert: UIAlertController = {
        let alert = UIAlertController(title: "信息",message: "您确认要离开本界面吗？",preferredStyle: UIAlertControllerStyle.alert)
        let yes = UIAlertAction(title: "确认",style: UIAlertActionStyle.default,handler:{(alerts: UIAlertAction) -> Void in print("离开")})
        let no = UIAlertAction(title: "取消",style: UIAlertActionStyle.default,handler:{(alerts: UIAlertAction) -> Void in print("留下")})
        
        alert.addAction(yes)
        alert.addAction(no)
        return alert
    }()
    var Alert3: UIAlertController = {
        let alert = UIAlertController(title: "查询失败",message: "输入的信息有误",preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "确认",style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(OKAction)
        return alert
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imgView)
        self.view.addSubview(btn)
        self.view.addSubview(btn1)
        self.view.addSubview(btn2)
        self.view.addSubview(btn3)
        self.view.addSubview(btn4)
        self.view.addSubview(Label)
        self.view.addSubview(Label2)
        self.view.addSubview(Label3)
        self.view.addSubview(Label4)
        self.view.addSubview(Label5)
        self.view.addSubview(Label6)
        self.view.addSubview(Label7)
        self.view.addSubview(Label8)
        self.view.addSubview(Label9)
        self.view.addSubview(TextField)
        self.view.addSubview(TextField1)
        self.view.addSubview(ProgressView)
        self.view.addSubview(ProgressView1)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    @objc func buttonTap(_ button:UIButton)
    {
        self.present(Alert, animated: true, completion: nil)
    }
    @objc func buttonTap1(_ button: UIButton)
    {
        let Alert : UIAlertController = {
            let alert = UIAlertController(title: "没开空调(提交后点击屏幕可查看结果)",message:"您确认要提交了吗?",preferredStyle: UIAlertControllerStyle.actionSheet)
            let Queren: UIAlertAction = {
                let queren = UIAlertAction(title:"确认",style: UIAlertActionStyle.default,handler: {(alerts: UIAlertAction) -> Void in print ("提交")
                    let img = UIImage(named:"a8")
                    let imgView = UIImageView (image: img)
                    imgView.alpha=1
                    imgView.frame = CGRect(x:333.fitScreen, y:543.fitScreen, width:25.fitScreen, height:25.fitScreen)
                    imgView.contentMode = .scaleAspectFit
                    self.view.addSubview(imgView)
                    let bt = PowerButton(type: UIButtonType.roundedRect)
                    bt.frame = CGRect (x:333.fitScreen,y:508.fitScreen,width:25.fitScreen,height:25.fitScreen)
                    let image = UIImage(named: "a9")
                    bt.setBackgroundImage(image, for: UIControlState())
                    bt.alpha = 1
                    self.view.addSubview(bt)
                    let bt1 = PowerButton(type: UIButtonType.roundedRect)
                    bt1.frame = CGRect (x:333.fitScreen,y:543.fitScreen,width:25.fitScreen,height:25.fitScreen)
                    let image1 = UIImage(named: "a9")
                    bt1.setBackgroundImage(image1, for: UIControlState())
                    bt1.alpha = 1
                    self.view.addSubview(bt1)
                })
                return queren
            }()
            let quxiao = UIAlertAction(title:"取消",style: UIAlertActionStyle.default,handler: {(alerts: UIAlertAction) -> Void in print ("不提交")})
            let likai = UIAlertAction(title: "离开",style: UIAlertActionStyle.cancel,handler:{(alerts: UIAlertAction) ->Void in print("离开")})
            alert.addAction(Queren)
            alert.addAction(quxiao)
            alert.addAction(likai)
            return alert
        }()
        self.present(Alert,animated: true, completion: nil)
    }
    @objc func buttonTap2(_ button: UIButton)
    {
        let Alert1 : UIAlertController = {
            let alert = UIAlertController(title: "开空调了(提交后点击屏幕可查看结果)",message:"您确认要提交了吗?",preferredStyle: UIAlertControllerStyle.actionSheet)
            let Queren: UIAlertAction = {
                let queren = UIAlertAction(title:"确认",style: UIAlertActionStyle.default,handler: {(alerts: UIAlertAction) -> Void in print ("提交")
                    let img = UIImage(named:"a8")
                    let imgView = UIImageView (image: img)
                    imgView.alpha=1
                    imgView.frame = CGRect(x:333.fitScreen, y:508.fitScreen, width:25.fitScreen, height:25.fitScreen)
                    imgView.contentMode = .scaleAspectFit
                    self.view.addSubview(imgView)
                    let bt = PowerButton(type: UIButtonType.roundedRect)
                    bt.frame = CGRect (x:333.fitScreen,y:508.fitScreen,width:25.fitScreen,height:25.fitScreen)
                    let image = UIImage(named: "a9")
                    bt.setBackgroundImage(image, for: UIControlState())
                    bt.alpha = 1
                    self.view.addSubview(bt)
                    let bt1 = PowerButton(type: UIButtonType.roundedRect)
                    bt1.frame = CGRect (x:333.fitScreen,y:543.fitScreen,width:25.fitScreen,height:25.fitScreen)
                    let image1 = UIImage(named: "a9")
                    bt1.setBackgroundImage(image1, for: UIControlState())
                    bt1.alpha = 1
                    self.view.addSubview(bt1)
                })
                return queren
            }()
            let quxiao = UIAlertAction(title:"取消",style: UIAlertActionStyle.default,handler: {(alerts: UIAlertAction) -> Void in print ("不提交")})
            let likai = UIAlertAction(title: "离开",style: UIAlertActionStyle.cancel,handler:{(alerts: UIAlertAction) ->Void in print("离开")})
            alert.addAction(Queren)
            alert.addAction(quxiao)
            alert.addAction(likai)
            return alert
        }()
        self.present(Alert1,animated: true, completion: nil)
    }
    @objc func buttonTap3(_ button: UIButton)
    {
        self.present(Alert3,animated:true,completion:nil)
    }
    @objc func buttonTap4(_ button: UIButton)
    {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
