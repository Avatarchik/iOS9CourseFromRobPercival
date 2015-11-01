//
//  ViewController.swift
//  Noughts And Crosses
//
//  Created by Jorge Bastos on 10/13/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1 = noughts, 2 = crosses
    var activePlayer = 1
    var noughtScore = 0
    var crossScore = 0
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var isGameActive = true

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var nextPlayerImage: UIImageView!
    @IBOutlet weak var noughtScoreLabel: UILabel!
    @IBOutlet weak var crossScoreLabel: UILabel!
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if gameState[sender.tag] == 0 && isGameActive == true {
        
            gameState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                
                sender.setImage(UIImage(named: "nought.png"), forState: UIControlState.Normal)
                activePlayer = 2
                nextPlayerImage.image = UIImage(named: "cross.png")
                
            } else {
                
                sender.setImage(UIImage(named: "cross.png"), forState: UIControlState.Normal)
                activePlayer = 1
                nextPlayerImage.image = UIImage(named: "nought.png")
                
            }
            
            for combination in winningCombinations {
                
                if (gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]]) {
                    
                    isGameActive = false
                    
                    if gameState[combination[0]] == 1 {
                        
                        nextPlayerImage.hidden = true
                        gameOverLabel.text = "Noughts has won!"
                        noughtScore++
                        noughtScoreLabel.text = ": \(noughtScore)"
                        
                    } else {
                        
                        nextPlayerImage.hidden = true
                        gameOverLabel.text = "Crosses has won!"
                        crossScore++
                        crossScoreLabel.text = ": \(crossScore)"
                        
                    }
                    
                  endGame()
                    
                }
             
            }
            
            if isGameActive == true {
            
                isGameActive = false
                
                for buttonState in gameState {
                    
                    if buttonState == 0 {
                        isGameActive = true
                    }
                }
                
                if isGameActive == false {
                    
                    nextPlayerImage.hidden = true23456
                    
                    gameOverLabel.text = "It's a draw!"
                    
                    endGame()
                }
            }
        }
        
    }
    
    @IBAction func playAgainButton(sender: AnyObject) {
        
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        activePlayer = 1
        isGameActive = true
        
        gameOverLabel.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgain.hidden = true
        nextPlayerImage.hidden = false
        nextPlayerImage.image = nil
        
        var buttonToClear : UIButton
        
        for var i = 0; i < 9; i++ {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, forState: UIControlState.Normal)
        }

        
    }
    
    func endGame() {
        
        gameOverLabel.hidden = false
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.gameOverLabel.center = CGPointMake(self.gameOverLabel.center.x + 500, self.gameOverLabel.center.y)
            
            
        })
        
        UIView.animateWithDuration(20, animations: { () -> Void in
            self.playAgain.hidden = false
        })

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameOverLabel.hidden = true
        gameOverLabel.center = CGPointMake(gameOverLabel.center.x - 500, gameOverLabel.center.y)
        
        playAgain.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

