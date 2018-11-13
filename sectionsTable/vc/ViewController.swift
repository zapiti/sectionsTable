//
//  ViewController.swift
//  sectionsTable
//
//  Created by Nathan Ranghel on 13/10/18.
//  Copyright © 2018 Nathan Ranghel. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    let cellId = "cellId"
    
    func callMethodToCall(cell : UITableViewCell){
        
        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}
        
        let animesAndSeries = twoDimensionalArray[indexPathTapped.section].names[(indexPathTapped.row)]
        let hasFavorited = animesAndSeries.hasFavorited
        
        twoDimensionalArray[indexPathTapped.section].names[(indexPathTapped.row)]
            .hasFavorited = !hasFavorited
        cell.accessoryView?.tintColor = animesAndSeries.hasFavorited ? UIColor.lightGray : .yellow
        
    }
    

    var twoDimensionalArray = [
        
        ExpandableNames(isExpanded: true, names:[
            "walter","jheim","ana","flavia","gildo","beta","Ray","Joo"].map{
                AnimesAndSeries(name: $0 , hasFavorited : false,genre :"labs")
        }),
        ExpandableNames(isExpanded: true, names:["pedro","pedro","pedro","pedro","pedro","pedro","pedro","pedro"].map{
            AnimesAndSeries(name: $0 , hasFavorited : false,genre: "comedia")
        }),
        ExpandableNames(isExpanded: true, names:["centro","centro","centro","centro","centro","centro","centro","centro"].map{
            AnimesAndSeries(name: $0 , hasFavorited : false,genre : "acao")
        }),
        ExpandableNames(isExpanded: true, names:["mastro","mastro","mastro","mastro","mastro","mastro","mastro","mastro"].map{
            AnimesAndSeries(name: $0 , hasFavorited : false, genre : "suspense")
        })
]
    
    var showIndexPaths = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initComponentAndView()
    }
    
    
    
    @objc func handlerShowIndexPath() {
        
        var indexPathsToReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices{
            for row in twoDimensionalArray[section].names.indices{
                let indexPath = IndexPath(row: row, section : section)
                indexPathsToReload.append(indexPath)
            }
        }
        showIndexPaths = !showIndexPaths

        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }

  
    
    fileprivate func initComponentAndView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Mostrar", style: .plain, target: self, action: #selector(handlerShowIndexPath))
        
        navigationItem.title = "Animes e Series"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(AnimeAndSeriesCell.self, forCellReuseIdentifier: cellId)
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let button = UIButton(type: .system)
        
        button.setTitle("Fechar", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor  = .orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlerExpandClose), for: .touchUpInside)
    
        button.tag = section
        
        return button
 
    }
    
    @objc func handlerExpandClose(button: UIButton){
        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        
        for row in twoDimensionalArray[section].names.indices{
            let indexPath = IndexPath(row: row, section : section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Abrir" : "Fechar", for: .normal)
        if !isExpanded{
            tableView.insertRows(at: indexPaths, with: .fade)
        }else{
           tableView.deleteRows(at: indexPaths, with: .fade)
        }
        
    
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !twoDimensionalArray[section].isExpanded {
            return 0
        }

       return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnimeAndSeriesCell
        
        
        cell.link = self
        
        let animesAndSeries = twoDimensionalArray[indexPath.section].names[indexPath.row]
        
        cell.textLabel?.text = animesAndSeries.name
        cell.detailTextLabel?.text = animesAndSeries.genre
        
        cell.accessoryView?.tintColor = animesAndSeries.hasFavorited ? UIColor.yellow : .lightGray
        
        if showIndexPaths {
            cell.textLabel?.text = "\(animesAndSeries.name) seçåo : \(indexPath.section)/\(indexPath.row)"
        }
        
        
        return cell
    }

}

