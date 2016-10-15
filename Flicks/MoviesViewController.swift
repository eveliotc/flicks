//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Evelio Tarazona on 10/15/16.
//  Copyright © 2016 Evelio Tarazona. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import MBProgressHUD

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkErrorView: UILabel!
    
    public var movieSource: MovieSource = .nowPlaying
    fileprivate lazy var searchBar:UISearchBar = UISearchBar(frame: .zero)
    fileprivate weak var refreshControl: UIRefreshControl?
    fileprivate let reachability = NetworkReachabilityManager()
    fileprivate var data: [Movie] = []
    fileprivate var unfilteredData: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        loadData()
        listenForNetworkChanges()
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Colors.main]
        setRightNavButtonAsSearch()
    }
    
    func loadData() {
        refreshControl?.beginRefreshing()
        networkErrorView.isHidden = true
        TheMovieDatabaseAPI.getMovies(movieSource, failure: { e in
                self.networkErrorView.isHidden = false
            }, success: { movies in
                self.data = movies
                self.unfilteredData = movies
                self.tableView.reloadData()
                self.networkErrorView.isHidden = true
                self.refreshControl?.endRefreshing()
                MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    deinit {
        stopListeningForNetworkChanges()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! MovieDetailsViewController
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
        destinationViewController.movie = data[(indexPath?.row)!]
        searchBar.resignFirstResponder()
    }
}

// MARK: - TableView
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.refreshControl = refreshControl
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = data[indexPath.row]
        cell.bind(movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func refreshData() {
        dismissSearch()
        loadData()
    }
}

// MARK: - Reachability
extension MoviesViewController {
    
    func listenForNetworkChanges() {
        reachability?.listener = {
            status in
            let reachable = status != .notReachable
            self.networkErrorView.isHidden = reachable
            if reachable && self.unfilteredData.isEmpty {
                self.loadData()
            }
            
        }
        reachability?.startListening()
    }
    
    func stopListeningForNetworkChanges() {
        reachability?.stopListening()
    }
    
}

// MARK: - Search
extension MoviesViewController: UISearchBarDelegate {
    
    func setRightNavButtonAsSearch() {
        let rightNavBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(beginSearch))
        self.navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    func dismissSearch() {
        searchBar.resignFirstResponder()
        navigationItem.titleView = nil
        setRightNavButtonAsSearch()
        
        if data.count != unfilteredData.count {
            data = unfilteredData
            tableView.reloadData()
        }
    }
    
    func beginSearch() {
        unfilteredData = data
        searchBar.delegate = self
        searchBar.text = ""
        searchBar.sizeToFit()
        searchBar.becomeFirstResponder()
        navigationItem.titleView = searchBar
        let rightNavBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissSearch))
        navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        data = unfilteredData.filter({ (movie) -> Bool in
            return searchText.isEmpty
                || movie.title.localizedCaseInsensitiveContains(searchText)
                || movie.overview.localizedCaseInsensitiveContains(searchText)
        })
        tableView.reloadData()
    }


}
