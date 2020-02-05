import Foundation

class Board{
    
    var cells:Cells<Cell>
    var game:Game
    var currentPlayer:Player
    var state:State
    var winner:Player?
    
    init(){
        cells = Cells(rows: 3, columns: 3)
        game = Game()
        currentPlayer = Player.X
        state = State.InProgress
        winner = nil
    }
    
    func clearCells(){
        cells = Cells(rows: 3, columns: 3)
    }
    
    func restart(){
        clearCells()
        game = Game()
        currentPlayer = Player.X
        state = State.InProgress
        winner = nil
    }
    
    func isWinningMove(player:Player, row:Int, column:Int)->Bool{
            cells[0, column]?.player == player
            && cells[1, column]?.player == player
            && cells[2, column]?.player == player
        ||  cells[row, 0]?.player == player
            && cells[row, 1]?.player == player
            && cells[row, 2]?.player == player
        ||  cells[0, 0]?.player == player
            && cells[1, 1]?.player == player
            && cells[2, 2]?.player == player
        ||  cells[0, 2]?.player == player
            && cells[1, 1]?.player == player
            && cells[2, 0]?.player == player
    }
    
    func isCoordValid(coord:Int)->Bool{
        coord >= 0 && coord <= 2
    }
    
    func isCellEmpty(row:Int, column:Int)->Bool{
        cells[row, column] == nil
    }
    
    func isCellValidForPlayed(row:Int, column:Int)->Bool{
        state == State.InProgress
            && isCoordValid(coord: row)
            && isCoordValid(coord: column)
            && isCellEmpty(row: row, column: column)
    }
    
    func isBoardFull()->Bool{
        for i in 0..<3{
            for j in 0..<3{
                if cells[i, j] == nil{
                    return false
                }
            }
        }
        return true
    }
    
    func flipSide(){
        currentPlayer = (currentPlayer == Player.X) ? Player.O : Player.X
    }
    
    func makeOneMove(player:Player, row:Int, column:Int)->Player?{
        var player:Player? = nil
        if isCellValidForPlayed(row: row, column: column){
            game.deleteMovesAfterCurrentMove()
            cells[row, column] = Cell(player: currentPlayer)
            player = currentPlayer
            if isWinningMove(player: currentPlayer, row: row, column: column){
                state = State.HasResult
                winner = currentPlayer
            }else if state == State.InProgress && isBoardFull(){
                state = State.Draw
            }
            game.addMove(move: Move(player: currentPlayer, row: row, column: column, state: state))
            flipSide()
        }
        return player
    }
    
    func clearOneCell(row:Int, column:Int){
        cells[row, column] = nil
    }
    
    func fillOneCell(player:Player, row:Int, column:Int){
        if isCellValidForPlayed(row: row, column: column){
            cells[row, column] = Cell(player: player)
        }
    }
    
    func saveGame(){
        guard let data = try? JSONEncoder().encode(game) else {return}
        UserDefaults.standard.set(data, forKey: "save")
    }
    
    func loadGame(){
        guard let data = UserDefaults.standard.data(forKey: "save") else {return}
        game = (try? JSONDecoder().decode(Game.self, from: data)) ?? Game()
    }
    
}


















