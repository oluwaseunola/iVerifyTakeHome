//
//  HomeViewModel.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-16.
//

import Foundation

enum LoadState {
    case loaded,loading,error
}

final class HomeViewModel : ObservableObject {
    /// Fetched devices
    @Published private (set) var devices: [Device] = []
    /// Filtered devices
    @Published private (set) var filteredDevices: [Device] = []
    /// Current load state
    @Published var loadState: LoadState = .loading
    /// Authentication state
    @Published var isAuthenticated: Bool = KeychainService.loadToken() != nil
    /// Search text for search bar
    @Published var searchText: String = ""
    /// Queried number of pages for pagination
    private var page: Int = 1
    
    let networkManager: Networking
    
    init(networkManager: Networking){
        self.networkManager = networkManager
        fetchDevices()
    }
    
    /// Fetches devices
    func fetchDevices(){
        loadState = .loading
        networkManager.fetchData(page: page) { result in
            switch result {
            case .success(let devices):
                DispatchQueue.main.async {
                    self.devices = devices
                    self.loadState = .loaded
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async{
                    self.loadState = .error
                }
            }
        }
        
    }
    
    /// Filters devices using search text
    func filterDevices(by searchText: String){
        filteredDevices = devices.filter{$0.device.lowercased().contains(searchText.lowercased()) || $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    /// Pagination logic
    func paginate(){
        page += 1
        fetchDevices()
    }
    
    /// Incorporates C code and generates a random name
    func getName()-> String{
        guard let namePtr = get_name() else {return ""}
        return String(cString: namePtr)
    }
}
