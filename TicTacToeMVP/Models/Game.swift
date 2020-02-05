import Foundation

enum Player:Int, CustomStringConvertible, Codable{
    case X = 1, O
    var description: String{
        switch self{
        case .X: return "X"
        case .O: return "O"
        }
    }
}

enum State:Int, Codable{
    case InProgress = 1, HasResult, Draw
}

struct Cell:Codable{
    let player:Player
}

struct Move:Codable{
    let player:Player
    let row:Int
    let column:Int
    let state:State
}

struct Game:Codable{
    var moves = [Move]()
    var currentMove:Int = 0
    
    mutating func setCurentMove(currentMove:Int){
        self.currentMove = currentMove
    }
    
    mutating func setMoves(moves:[Move]){
        self.moves = moves
    }
    
    mutating func addMove(move:Move){
        moves.append(move)
        currentMove += 1
    }
    
    //when users move back and forth with buttons, if they choose a new move
    //then the game will continue from that move, and all moves that come following
    //that move will be deleted.
    mutating func deleteMovesAfterCurrentMove(){
        moves = Array(moves[0..<currentMove])
    }
}

