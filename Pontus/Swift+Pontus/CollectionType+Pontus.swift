

import Foundation

public extension RangeReplaceableCollection {
    
    ///	mutating func insert(newElement: Self.Generator.Element, atIndex i: Self.Index)
    
    func pontus_insert(_ newElement: Self.Iterator.Element, atIndex i: Self.Index) -> Self {
        var newCollection = self
        newCollection.insert(newElement, at: i)
        return newCollection
    }
    
    func pontus_appendFirst(_ x: Self.Iterator.Element?) -> Self {
        var newCollection = self
        if x != nil {
            newCollection.insert(x!, at: self.startIndex)
        }
        return newCollection
    }
    
    ///	mutating func append(x: Self.Generator.Element)
    
    func pontus_append(_ x: Self.Iterator.Element?) -> Self {
        var newCollection = self
        if x != nil {
            newCollection.append(x!)
        }
        return self
    }
}
