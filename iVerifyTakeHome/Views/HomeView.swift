//
//  HomeView.swift
//  iVerifyTakeHome
//
//  Created by Seun Olalekan on 2023-10-13.
//

import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel = .init(networkManager: NetworkManager.init(baseURL: Constants.baseURL, session: URLSession(configuration: .default, delegate: NetworkManagerURLSessionDelegate(), delegateQueue: nil)))
    
    var body: some View {
        
        ZStack{
            
            switch viewModel.loadState {
            // Error State
            case.error :
            VStack{
                Text("Error loading devices")
                    Button {
                        viewModel.fetchDevices()
                    } label: {
                        Text("Retry")
                    }
            }
            // Loaded State
            case .loaded:
                if !viewModel.devices.isEmpty || !viewModel.filteredDevices.isEmpty {
                    
                    VStack{
                        Text(viewModel.getName())
                            .font(.title)
                        SearchBar(text: $viewModel.searchText)
                        List{
                            ForEach(viewModel.filteredDevices.isEmpty ? viewModel.devices : viewModel.filteredDevices, id: \.id) { device in
                                DeviceCell(device: device)
                                if device.id == viewModel.devices.last?.id {
                                    Button {
                                        viewModel.paginate()
                                    } label: {
                                        Text("Load more")
                                            .frame(maxWidth:.infinity)
                                    }

                                }
                            }
                        }
                        .onChange(of: viewModel.searchText) { newValue in
                            viewModel.filterDevices(by: newValue)
                        }
                    }
                }
                else{
                    Text("No results.")
                }
            // Loading State
            case .loading:
                VStack{
                    Text("Loading...")
                    ProgressView()
                }
            }
            // Login view shows if user has not been authenticated (aka token isn't saved)
            if !viewModel.isAuthenticated{
                LoginView(authenticated: $viewModel.isAuthenticated){
                    viewModel.fetchDevices()
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
