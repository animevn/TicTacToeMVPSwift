import Foundation

protocol PresenterDelegate:class{
    func onViewDidLoad()
    func onAppDidEnterBackGround()
    func onAppDidTerminate()
}
