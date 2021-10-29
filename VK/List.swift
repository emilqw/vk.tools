//
//  List.swift
//  List
//
//  Created by Эмиль Яйлаев on 25.10.2021.
//

import UIKit

class List<Type> {
    var head:Node<Type>
    init(){
        head = Node<Type>(e: nil, nextNode: nil)
    }
    var count:Int {
        get {
            var i = 0
            var node:Node<Type> = head
            while(true){
                i+=1
                if node != nil{
                    node = head.nextNode!
                }else{
                    break
                }
            }
            return i
        }
    }
    func add(e:Type){
        let node = Node(e: e, nextNode: head)
        head = node
    }
}
class Node<Type>{
    var e:Type?
    var nextNode:Node?
    init(e:Type?,nextNode:Node?){
        self.e = e
        self.nextNode = nextNode
    }
}
