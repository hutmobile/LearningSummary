//iphone5s~iphone8plus的适配
//下方代码置于ViewController之外，此后在x,y,width,height的数值后面添加.fitscreen即可
public extension Double {
    var fitScreen: Double {
        return self/414.0 * Double(UIScreen.main.bounds.size.width)
    }
}
//以下是示例
   var imgView: UIImageView = {
        let v = UIImageView(image: UIImage(named:"a7.jpg"))
        v.frame = CGRect(x:0.fitScreen, y:0.fitScreen, width:414.fitScreen, height:737.fitScreen)
        return v
    }()
