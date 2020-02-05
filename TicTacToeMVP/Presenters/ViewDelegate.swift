import Foundation
protocol ViewDelegate {
    func updateLabel(string:String)
    func updateButton(string:String, row:Int, column:Int)
    func clearAllButtons()
}
