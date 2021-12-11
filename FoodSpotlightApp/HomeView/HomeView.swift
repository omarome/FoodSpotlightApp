//
//  ContentView.swift
//  FoodSpotlightApp
//
//  Created by Omar on 19.11.2021.
//
import SwiftUI
import CoreData
import MapKit

// this is the home page
@available(iOS 15.0, *)
struct HomeView: View {

    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.managedObjectContext) var context

    var body: some View {
        NavigationView {
            VStack{
                VStack{
                    Text(viewModel.cityName)
                        .font(.largeTitle.bold())
                        .frame(width: 200)
                        .foregroundColor(.blue)
                }
            VStack(alignment: .leading) {
                // Category
                Group {
                    Text(L10n.categories)
                        .font(.custom(.poppinsSemibold, size: 16))
                        .padding(.top, .small)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(FoodCategory.allCases, id: \.self) { category in
                                CategoryView(selectedCategory: $viewModel.selectedCategory, category: category)
                            }
                        }.padding(.small)
                    }
                }.padding(.leading, .large)

                // List
                List(viewModel.businesses, id: \.id) { business in
                    ZStack {
                        NavigationLink(destination: DetailView(id: business.id!)) {
                            EmptyView().opacity(0).frame(width: 0)
                        }
                        BusinessCell(business: business)
                            .padding(.bottom, .small)
                    
                    }
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Save") {
                        }
                                FavoriteButton(business: business)
                    }
                }
                .listStyle(.plain)
                .navigationTitle(Text(L10n.splfood))
                .searchable(text: $viewModel.searchText, prompt: Text(L10n.searchFood)) {
                    ForEach(viewModel.completions, id: \.self) { completion in
                        Text(completion).searchCompletion(completion)
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack{
   
                            Button(action: { viewModel.ShowFavorite.toggle() }) {
                                Image("heart-filled")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                
                            }
                        }
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Rectangle()
                        .fill(LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .bottom, endPoint: .top))
                        .frame(height: 90)
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            .sheet(isPresented: $viewModel.ShowFavorite) {
                FavoriteView()
            }
            .sheet(isPresented: $viewModel.showModal, onDismiss: nil) {
                PermissionView {
                    viewModel.requestPermission()
                }
            }
            .onChange(of: viewModel.showModal) { newValue in
                viewModel.request()
            }

        }
    }
}
}
@available(iOS 15.0, *)
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
