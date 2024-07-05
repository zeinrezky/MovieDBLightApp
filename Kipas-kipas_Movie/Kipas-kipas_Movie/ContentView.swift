//
//  ContentView.swift
//  Kipas-kipas_Movie
//
//  Created by zein rezky chandra on 05/07/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.query)
                List(viewModel.movies) { movie in
                    NavigationLink(destination: DetailView(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Movies")
            }
            .onAppear {
                UITableView.appearance().showsVerticalScrollIndicator = false
            }
        }
    }
}

struct MovieRow: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(movie.posterPath)")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 50, height: 75)
            .cornerRadius(5)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(String(movie.releaseYear))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(movie.genres.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}

struct DetailView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 300, height: 450)
            .cornerRadius(10)
            .padding()

            Text(movie.title)
                .font(.largeTitle)
                .padding([.top, .bottom], 20)

            Text(movie.overview)
                .font(.body)
                .padding([.leading, .trailing], 20)

            Spacer()
        }
        .navigationTitle(movie.title)
    }
}

#Preview {
    MovieListView()
}
