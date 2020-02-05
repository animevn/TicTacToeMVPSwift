import Foundation

class Presenter{
    
    var board:Board = Board()
    var delegate:ViewDelegate?
    
    private func updateLabelInfo(){
        delegate?.updateLabel(string: "\(board.currentPlayer.description) to play")
    }
    
    func onButtonPressed(row:Int, column:Int){
        guard let player = board.makeOneMove(row: row, column: column) else {return}
        updateLabelInfo()
        delegate?.updateButton(string: player.description, row: row, column: column)
        if board.state == State.HasResult{
            delegate?.updateLabel(string: board.winner!.description + " win!!!")
        }else if board.state == State.Draw{
            delegate?.updateLabel(string: "Draws!!!")
        }
    }
    
    func onButtonNewGamePressed(){
        board.restart()
        updateLabelInfo()
        delegate?.clearAllButtons()
    }
    
    func moveFirst(){
        let currentMove = board.game.currentMove
        if currentMove > 0{
            board.game.setCurentMove(currentMove: 0)
            board.currentPlayer = board.game.moves[0].player
            updateLabelInfo()
            delegate?.clearAllButtons()
        }
    }
    
    func moveBack(){
        let currentMove = board.game.currentMove
        if currentMove > 0{
            let move = board.game.moves[currentMove - 1]
            delegate?.updateButton(string: "", row: move.row, column: move.column)
            board.clearOneCell(row: move.row, column: move.column)
            board.game.setCurentMove(currentMove: currentMove - 1)
            board.state = move.state
            board.flipSide()
            updateLabelInfo()
        }
    }
    
    private func handleMoveState(move:Move){
        if move.state == State.HasResult{
            delegate?.updateLabel(string: "\(move.player.description) wins!!!")
        }else if move.state == State.Draw{
            delegate?.updateLabel(string: "Draws!!!")
        }else{
            updateLabelInfo()
        }
    }
    
    func moveNext(){
        let currentMove = board.game.currentMove
        if currentMove < board.game.moves.count{
            let move = board.game.moves[currentMove]
            delegate?.updateButton(string: move.player.description,
                                   row: move.row, column: move.column)
            board.fillOneCell(player: move.player, row: move.row, column: move.column)
            board.game.setCurentMove(currentMove: currentMove + 1)
            board.state = move.state
            board.flipSide()
            handleMoveState(move: move)
        }
    }
    
    func moveLast(){
        let currentMove = board.game.currentMove
        let size = board.game.moves.count
        if currentMove < size{
            for i in currentMove..<size{
                let move = board.game.moves[i]
                delegate?.updateButton(string: move.player.description,
                                       row: move.row, column: move.column)
                board.fillOneCell(player: move.player, row: move.row, column: move.column)
                board.state = move.state
                board.flipSide()
                handleMoveState(move: move)
            }
            board.game.setCurentMove(currentMove: size)
        }
    }
    
}

extension Presenter:PresenterDelegate{
    
    private func moveToCurrentMove(){
        let currentMove = board.game.currentMove
        for i in 0..<currentMove{
            let move = board.game.moves[i]
            delegate?.updateButton(string: move.player.description,
                                   row: move.row, column: move.column)
            board.fillOneCell(player: move.player, row: move.row, column: move.column)
            board.state = move.state
            board.flipSide()
            handleMoveState(move: move)
        }
        board.game.setCurentMove(currentMove: currentMove)
    }
    
    func onViewDidLoad() {
        board = Board()
        updateLabelInfo()
        delegate?.clearAllButtons()
        board.loadGame()
        moveToCurrentMove()
    }
    
    func onAppDidEnterBackGround() {
        board.saveGame()
    }
    
    func onAppDidTerminate() {
        board.saveGame()
    }
    
    
}
