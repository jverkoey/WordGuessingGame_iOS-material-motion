//
//  ViewController.swift
//  WordMaker
//
//  Created by Eric on 9/12/16.
//  Copyright © 2016 Eric. All rights reserved.
//

import UIKit
import MaterialMotion
import IndefiniteObservable

class ViewController: UIViewController, BlockManagerDelegate {
    
    var runtime: MotionRuntime!
    var blockManager: BlockManager?
    var wordList: WordList = WordList()
    
    var subscription1: Subscription! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runtime = MotionRuntime(containerView: view)
        colorAndBorderButton()
        startOver()
    }
    
    @IBOutlet weak var newWordButton: UIButton!
    @IBOutlet weak var StartOverButton: UIButton!
    @IBOutlet weak var bucketImage: UIImageView!
    @IBOutlet weak var blockHolder: UIView!
    
    @IBAction func startOverAction(_ sender: AnyObject) {
        startOver()
    }
    
    @IBAction func newWordAction(_ sender: AnyObject) {
        newWord()
    }
    
    func colorAndBorderButton() {
        newWordButton.layer.cornerRadius = 10;
        newWordButton.layer.borderWidth = 2;
        newWordButton.layer.borderColor = UIColor.blue.cgColor
        
        StartOverButton.layer.cornerRadius = 10;
        StartOverButton.layer.borderWidth = 2;
        StartOverButton.layer.borderColor = UIColor.blue.cgColor
    }
    
    func newWord() {
        removeAllBlocks()
        wordList = WordList()
        initialize()
    }
    
    func startOver() {
        removeAllBlocks()
        initialize()
    }
    
    func initialize() {
        let word = wordList.getRandomWord()
        let wordArray = wordList.getRandomWordAsArray()
        
        blockManager = BlockManager(word: word, blockHolder: blockHolder)
        blockManager!.delegate = self
        let letterArray: [String] = wordArray
        
        for letter in letterArray {
            let block: BlockUIView = BlockUIView(letter: letter)
            runtime.add(Draggable(), to: block) {
                return $0._map(#function) {
                    let _ = self.didTouchBucket(block, origin: $0)
                    return .init(x: $0.x, y: $0.y)
                }
            }
            self.view.addSubview(block)
            
            subscription1 = runtime.get(block.layer).position.subscribeToValue {
                (p: CGPoint) in
                    print(p.x)
                    print(p.y)
            }
        }
    }
    
    func removeAllBlocks() {
        for block in self.view.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
        for block in blockHolder.subviews {
            if block is BlockUIView {
                block.removeFromSuperview()
            }
        }
    }
    
    func didTouchBucket(_ block: BlockUIView, origin: CGPoint) -> Bool {
        if origin.x >= bucketImage.frame.origin.x &&
            origin.x <= bucketImage.frame.origin.x + bucketImage.frame.size.width &&
            origin.y >= bucketImage.frame.origin.y &&
            origin.y <= bucketImage.frame.origin.y + bucketImage.frame.size.height
        {
            blockManager!.add(block);
            block.removeFromSuperview()
            return true;
        }
        return false;
    }
    
    func wordMatched() {
        let alert = UIAlertController(title: "You Won", message: "Word Matched", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

