//
//  PostsListView.swift
//  iOS Concurrency
//
//  Created by Andrei Chenchik on 9/12/21.
//

import SwiftUI

struct PostsListView: View {
    @StateObject var vm = PostsListViewModel()
    var userId: Int?

    var body: some View {
        List {
            ForEach(vm.posts) { post in
                Text(post.title)
                    .font(.headline)
                Text(post.body)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .onAppear {
            vm.userId = userId
            vm.fetchPosts()
        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(userId: 1)
        }
    }
}
