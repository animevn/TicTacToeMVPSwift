import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var lbInfo: UILabel!
    @IBOutlet weak var uvBoard: UIView!
    var presenter:Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.onViewDidLoad()
    }

    @IBAction func onButtonsPressed(_ sender: UIButton) {
        let tag = String(sender.tag)
        guard let row = Int(String(Array(tag)[0])),
            let column = Int(String(Array(tag)[1])) else {return}
        presenter.onButtonPressed(row: row - 1, column: column - 1)
    }
    
    @IBAction func onButtonFirst(_ sender: UIButton) {
        presenter.moveFirst()
    }
    
    @IBAction func onButtonBack(_ sender: UIButton) {
        presenter.moveBack()
    }
    
    @IBAction func onButtonNext(_ sender: UIButton) {
        presenter.moveNext()
    }
    
    @IBAction func onButtonLast(_ sender: UIButton) {
        presenter.moveLast()
    }
    
    @IBAction func onButtonNewGamePressed(_ sender: UIBarButtonItem) {
        presenter.onButtonNewGamePressed()
    }
}

extension ViewController:ViewDelegate{
    
    func updateLabel(string: String) {
        lbInfo.text = string
    }
    
    func updateButton(string: String, row: Int, column: Int) {
        guard let tag = Int("\(row + 1)\(column + 1)") else {return}
        let button = uvBoard.viewWithTag(tag) as! UIButton
        button.setTitle(string, for: .normal)
    }
    
    func clearAllButtons() {
        let subviews = uvBoard.subviews
        var buttons = [UIButton]()
        for subview in subviews{
            let temp = subview.subviews.filter{$0 is UIButton}
            temp.forEach{buttons.append($0 as! UIButton)}
        }
        buttons.forEach{$0.setTitle("", for: .normal)}
    }
    
    
}











