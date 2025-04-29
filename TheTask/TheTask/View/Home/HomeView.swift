//
//  HomeView.swift
//  TheTask
//
//  Created by Zhora Babakhanyan on 27/04/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            Color.primaryBackgroundColor
                .ignoresSafeArea()
            
            VStack {
                Group {
                    if !hasAppeared || viewModel.isLoading {
                        ProgressView("Loading Users...")
                    } else if viewModel.users.isEmpty {
                        StatusView(statusType: .noUsers)
                    } else {
                        self.getUsersListView()
                    }
                }
            }
        }
        .onAppear {
            if !hasAppeared {
                hasAppeared = true 
                Task {
                    await viewModel.getUsers()
                }
            }
        }
    }
}

// MARK: - Users List View
extension HomeView {
    /// This function returns a `List` view displaying the users fetched from the view model.
    /// It checks if the last user in the list has appeared on screen and loads more users if needed.
    /// A loading indicator is shown at the bottom of the list while new users are being fetched.
    ///
    /// - Returns: A `View` representing a list of users with a progress indicator at the bottom.
    func getUsersListView() -> some View {
        List {
            ForEach(viewModel.users, id: \.id) { user in
                UserCardView(user: user)
                    .onAppear {
                        Task {
                            if user == viewModel.users.last {
                                await viewModel.loadMoreUsers()
                            }
                        }
                    }
                    .listSectionSeparator(.hidden, edges: .bottom)
            }
            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .listStyle(.plain)
    }
}
