//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by 현수빈 on 2021/04/11.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji] = [
       Emoji(symbol: "😀", name: "Grinning Face",
       description: "A typical smiley face.", usage: "happiness"),
       Emoji(symbol: "😕", name: "Confused Face",
       description: "A confused, puzzled face.",
       usage: "unsure what to think; displeasure"),
       Emoji(symbol: "😍", name: "Heart Eyes",
       description: "A smiley face with hearts for eyes.",
       usage: "love of something; attractive"),
       Emoji(symbol: "👮", name: "Police Officer",
       description: "A police officer wearing a blue cap with a goldbadge.",
       usage: "person of authority"),
       Emoji(symbol: "🐢", name: "Turtle", description:
       "A cute turtle.", usage: "Something slow"),
       Emoji(symbol: "🐘", name: "Elephant", description:
       "A gray elephant.", usage: "good memory"),
       Emoji(symbol: "🍝", name: "Spaghetti",
       description: "A plate of spaghetti.", usage: "spaghetti"),
       Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
        description: "Three colored books stacked on each other.",
        usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
        description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",
           description:
           "Three blue \'z\'s.", usage: "tired, sleepiness"),
           Emoji(symbol: "🏁", name: "Checkered Flag",
           description: "A black-and-white checkered flag.", usage:
           "completion")]
    
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.navigationItem.leftBarButtonItem=self.editButtonItem
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        여러줄을 쓰기 위해 사용
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        
        cell.update(with: emoji)
        
//        cell.textLabel?.text = "\(emoji.symbol) = \(emoji.name)"
//        cell.detailTextLabel?.text = emoji.description
        
    
        cell.showsReorderControl = true
        
        return cell
    }
    
    //uitableview controller를 만들 시 data source method이거 없애야 한다
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = emojis[indexPath.row]
//        print("\(emoji.symbol) \(indexPath)")
//
//
//    }
    
//    table view 삭제 시 사용, 빨간 삭제 버튼 구현하는 함수
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
            emojis.insert(movedEmoji, at: destinationIndexPath.row)
            tableView.reloadData()
     
    }

    /*
     // data source 함수로써 편집을 할 수 있는 index와 아닌 거를 나누어 준다. false면 편집 불가 편집에 빠질 row를 선택
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//     없데이트 할 때 사용, 편집을 하려면 반드시 구현해야 한다
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        모델도 업데이트 해야하고 ui적인 업데이트도 해야 한다
        if editingStyle == .delete {
            // Delete the row from the data source
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic) //automatic은 왼쪽으로 푸시되면서 삭제되는 형식을 의미
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func unwindToEmojiTableView(_ unwindSegue: UIStoryboardSegue) {
        
//        add를 완성했으면 새로운 emoji를 가져오는 것
        guard unwindSegue.identifier == "saveUnwind",
              let sourceViewContoller = unwindSegue.source as? AddEditEmojiTableViewController,
              let emoji = sourceViewContoller.emoji else{return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            
        } else{
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditEmoji" {
                let indexPath = tableView.indexPathForSelectedRow!
                let emoji = emojis[indexPath.row]
                let navController = segue.destination as!
                   UINavigationController
                let addEditEmojiTableViewController =
                   navController.topViewController as!
                   AddEditEmojiTableViewController
                addEditEmojiTableViewController.emoji = emoji
            
        
            }
        
       
       
    }
    

}
