//
//  SearchBar.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//
import SwiftUI
/// Wrapping uikit Search Bar for swift UI.
struct SearchBar: UIViewRepresentable {
// MARK: - Properties
    @Binding var text: String
    var placeholder: String
// MARK: - Coordinator
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        init(text: Binding<String>) {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
// MARK: - Configure Search Bar
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = self.placeholder
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
