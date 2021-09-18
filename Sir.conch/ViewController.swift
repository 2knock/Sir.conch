//
//  ViewController.swift
//  Sir.conch
//
//  Created by In Ok Park on 2021/09/14.
//

import UIKit

class ViewController: UIViewController {
    enum SendState {
        case disable
        case question
        case reQuesstion
        case questionComplete
        
        func getString () -> String {
            switch self {
            case .disable:
                return "질문하기"
                
            case .question:
                return "질문하기"
                
            case .reQuesstion:
                return "질문하기"
                
            case .questionComplete:
                return "다시하기"
            }
        }
    }
    
    
    @IBOutlet weak var lbAnswer: UILabel!
    @IBOutlet weak var txtQuestion: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var imgConch: UIImageView!
    @IBOutlet weak var Answer: UIView!
    @IBOutlet weak var btnSendImgView: UIImageView!
    
    let animationDurationStartAlpha: CGFloat = 0.0
    let animationDurationEndAlpha: CGFloat = 1.0
    
    var sendState: SendState = .disable
    
    let array1 = ["당장 시작해.", "좋아.", "그래.", "나중에 해.", "다시 한번 물어봐.",
    "안돼.", "놉.", "하지마.", "최.악.", "가만히 있어.", "그것도 안돼."]
    let array2 = ["먹지마.", "먹어.", "굶어.", "둘다 먹지마.", "다시 한번 물어봐.",
    "그래."]
    
    // 자료형 string, char, bool, float, Int, Double
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Circle Button
        btnSend.layer.cornerRadius = btnSend.frame.width / 2
        btnSend.layer.masksToBounds = true
        
        // TextField Design
        txtQuestion.layer.cornerRadius = 7
        txtQuestion.layer.borderColor = UIColor.white.cgColor
        txtQuestion.layer.borderWidth = 1.0
        txtQuestion.addLeftPadding()
        
        // Answer
        self.Answer.alpha = 0.0
    }

    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        let txtStr: String = self.txtQuestion.text ?? ""
        
        guard !txtStr.isEmpty else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        guard self.sendState != .question else {
            return
        }
        
        self.sendState = .question
        self.changeSendState(state: self.sendState)
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        let txtStr = txtQuestion.text ?? ""
        
        guard !txtStr.isEmpty else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        guard self.sendState != .questionComplete else {
            self.sendState = .disable
            self.changeSendState(state: self.sendState)
            return
        }
        
        self.sendState = .question
        self.changeSendState(state: self.sendState)
        
        // Random array
        if txtStr.contains("먹어") {
            lbAnswer.text = array2.randomElement()
        }
        else if txtStr.contains("먹을") {
            lbAnswer.text = array2.randomElement()
        } else {
            lbAnswer.text = array1.randomElement()
        }

        self.imgConch.alpha = self.animationDurationStartAlpha
        self.Answer.alpha = self.animationDurationStartAlpha
        UIView.animate(withDuration: 1.0, animations: {
            self.imgConch.alpha = self.animationDurationEndAlpha
            self.Answer.alpha = self.animationDurationEndAlpha
        })
        
        self.sendState = .questionComplete
        self.changeSendState(state: self.sendState)
    }
    
    func getUIColorFromRGBThreeIntegers(red: Int, green: Int, blue: Int) -> UIColor {
        return UIColor(red: CGFloat(Float(red) / 255.0),
            green: CGFloat(Float(green) / 255.0),
            blue: CGFloat(Float(blue) / 255.0),
            alpha: CGFloat(1.0))
    }
    
    func changeSendState(state: SendState) {
        switch state {
        case .disable:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnRe")
            self.txtQuestion.text = ""
            self.Answer.isHidden = true
            
        case .question:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnSend")
            self.Answer.isHidden = true
            
        case .reQuesstion:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnRe")
            self.txtQuestion.text = ""
            self.Answer.isHidden = true
            
        case .questionComplete:
            self.btnSend.setTitle(state.getString(), for: .normal)
            self.btnSendImgView.image = UIImage(named: "btnRe")
            self.Answer.isHidden = false
        }
    }
}

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

extension UIView {
    @discardableResult
    func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.type = .radial
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

extension UIColor {
    convenience init(argb: UInt) {
        self.init(
            red: CGFloat((argb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((argb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(argb & 0x0000FF) / 255.0,
            alpha: CGFloat((argb & 0xFF000000) >> 24) / 255.0
        )
    }
}
