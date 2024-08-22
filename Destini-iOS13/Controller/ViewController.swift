//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var choice1Button: UIButton!
    @IBOutlet weak var choice2Button: UIButton!
    
    var storyBrain: StoryBrain = StoryBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.updatePage()
    }
    
    func setupUI() {
        self.setupLabel()
        self.setupButtons()
    }
    
    func setupLabel() {
        self.storyLabel.textAlignment = .center
    }
    
    func setupButtons() {
        let buttonsList: [UIButton] = [
            self.choice1Button,
            self.choice2Button,
        ]
        
        for index in 0..<buttonsList.count {
            let button = buttonsList[index]
            button.tag = index + 1
            button.addTarget(self,action:#selector(buttonClicked),
                             for:.touchUpInside)
        }
    }
    
    func updatePage() {
        
        let res = self.storyBrain.loadPage()
        let page = res.page
        let gameOver = res.gameOver
        
        if gameOver {
            self.gameOver()
            return
        }
        
        self.storyLabel.text = page.label
        self.choice1Button.setTitle(page.button1, for: .normal)
        self.choice2Button.setTitle(page.button2, for: .normal)
    }
    
    func gameOver() {
        self.storyLabel.text = "Game Over"
        self.choice1Button.isHidden = true
        self.choice2Button.isHidden = true
    }
    
    @objc func buttonClicked(sender:UIButton)
    {
        let choice = sender.tag
        self.storyBrain.choosePath(choice)
        self.updatePage()
    }

}
