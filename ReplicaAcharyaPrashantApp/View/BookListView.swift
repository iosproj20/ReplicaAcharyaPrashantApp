//
//  ContentView.swift
//  ReplicaAcharyaPrashantApp
//
//  Created by Tarun Sahu on 19/02/24.
//

import SwiftUI

struct BookListView: View {
    @ObservedObject var bookListModelObject = BookListViewModel()
    @State private var isLoading = true
    @State private var showAlert = false
    @State private var alertMessage = "Initial Message"
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    TitleView()
                    if bookListModelObject.dataResponse != nil{
                        ScrollView{
                            BookListCollView(model: bookListModelObject)
                        }
                    }
                    Spacer()
                }
                
            }
            .showAlert(title: "Alert", message: alertMessage, isPresented:$showAlert)
            .onAppear{
                getBookListApi()
            }
        }
    }
}

// MARK: Api call
extension BookListView {
    func getBookListApi(){
        isLoading = true
        bookListModelObject.fetchData() { response in
            switch response {
            case .success(let data):
                isLoading = data
                print(data)
            case .failure(let error):
                isLoading = false
                showAlert = true
                alertMessage = "\(error.localizedDescription)"
                print(error.localizedDescription)
            }
        }
    }
}

struct TitleView:View {
    var body: some View {
        VStack{
            Text("Browse Books")
                .font(.system(size: 20).bold())
                .foregroundColor(Color.black)
        }
    }
}


// MARK: - Render Data

struct BookListCollView:View {
    var model:BookListViewModel
    let columnss: [GridItem] = [
        GridItem(.flexible(), spacing:10),GridItem(.flexible(), spacing:10)
    ]
    var body: some View {
        VStack{
            LazyVGrid(columns: columnss, spacing: 10) {
                ForEach(model.dataResponse ?? [], id: \.self) { item in
                    BookListCell(model: item)
                }
            }
        }
        .padding([.leading,.trailing],UIScreen.main.bounds.width*0.0467)
    }
}
#Preview {
    BookListView()
}
