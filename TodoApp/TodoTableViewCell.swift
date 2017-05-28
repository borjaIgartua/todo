//
//  TodoTableViewCell.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    typealias CheckClosure = (Bool) -> ()
    var checkHandler: CheckClosure?
    
    var done: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        checkButton.layer.cornerRadius = 10
        checkButton.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1.0).cgColor
        checkButton.layer.borderWidth = 1.0
        
        checkButton.layer.shadowColor = UIColor.gray.cgColor
        checkButton.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        checkButton.layer.shadowOpacity = 1.0
        checkButton.layer.shadowRadius = 1.0
        checkButton.layer.masksToBounds = false
        checkButton.layer.cornerRadius = 4.0
        
        self.selectionStyle = .none
    }

    @IBAction func checkButtonPressed(_ sender: UIButton) {
        
        self.done = !self.done
        self.updateCheckButtonImage(done: self.done)
        checkHandler?(self.done)
    }
    
    func fillWithTitle(_ title: String, done: Bool, checkHandler: @escaping CheckClosure) {
        titleLabel.text = title
        self.checkHandler = checkHandler
        
        self.updateCheckButtonImage(done: done)
    }
    
    func updateCheckButtonImage(done: Bool) {
        
        if done {
            checkButton.setImage(UIImage(named: "checked")!.withRenderingMode(.alwaysOriginal), for: .normal)
            
        } else {
            checkButton.setImage(nil, for: .normal)
        }
    }
}
