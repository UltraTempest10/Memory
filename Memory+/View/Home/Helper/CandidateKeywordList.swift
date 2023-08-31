//
//  CandidateKeywordList.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI

struct CandidateKeywordList: View {
    @Binding var selectedEraIndex: Int
    @Binding var selectedCityIndex: Int
    @Binding var selectedObjectIndex: Int
    @Binding var keyword: String
    var filteredEraArray: [(Int, String)] {
        Constants.era.enumerated().filter { $0.element.contains(keyword) }
    }
    var filteredCityArray: [(Int, String)] {
        Constants.city.enumerated().filter { $0.element.contains(keyword) }
    }
    var filteredObjectArray: [(Int, String)] {
        Constants.object.enumerated().filter { $0.element.contains(keyword) }
    }

    var body: some View {
        List {
            ForEach(filteredEraArray, id: \.0) { (index, key) in
                Button {
                    selectedEraIndex = index
                    keyword = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text(key)
                }
            }
            ForEach(filteredCityArray, id: \.0) { (index, key) in
                Button {
                    selectedCityIndex = index
                    keyword = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text(key)
                }
            }
            ForEach(filteredObjectArray, id: \.0) { (index, key) in
                Button {
                    selectedObjectIndex = index
                    keyword = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text(key)
                }
            }
        }
        .listStyle(.plain)
        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
        .opacity(!filteredEraArray.isEmpty || !filteredCityArray.isEmpty || !filteredObjectArray.isEmpty ? 1 : 0)
    }
}

struct CandidateKeywordList_Previews: PreviewProvider {
    static var previews: some View {
        CandidateKeywordList(selectedEraIndex: .constant(0), selectedCityIndex: .constant(0), selectedObjectIndex: .constant(0), keyword: .constant(""))
    }
}
