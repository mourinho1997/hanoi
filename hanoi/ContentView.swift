//
//  ContentView.swift
//  hanoi
//
//  Created by 佐藤恭平 on 2024/01/07.
//

import SwiftUI

struct ContentView: View {
    //円盤の数
    @State private var disks = ""
    //ステップ
    @State private var steps: [String] = []
    
    var body: some View {
        VStack {
            //円盤の数を入力する場所
            TextField("円盤の数を入力してください（1以上）", text: $disks)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            //実行ボタン
            Button(action: {
                if let disks = Int(disks), disks > 0 {
                    steps = []
                    hanoi(n: disks, start: "A", via: "B", goal: "C")
                }
            }) {
                Text("ステップを表示する")
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            //ステップを表示する
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(steps, id: \.self) { step in
                        Text(step)
                            .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
    }
    
    //start：スタート柱、via：作業用の柱（バッファー）、goal：目的柱
    func hanoi(n: Int, start: String, via: String, goal: String) {
        if n > 0 {
            //スタート柱から、n番目に大きい円盤を残して、n-1個の円盤を作業用柱に移動
            hanoi(n: n - 1, start: start, via: goal, goal: via)
            //n番目に大きい円盤を目的柱に移動
            let step = "\(n)を\(start)から\(goal)に移動する"
            steps.append(step)
            //n-1個の円盤を、作業用柱から目的柱に移動
            hanoi(n: n - 1, start: via, via: start, goal: goal)
        }
    }
}
