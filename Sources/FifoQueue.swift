class Element<T> {
    let data: T
    var next: Element<T>?
    init(input: T) {
        data = input
    }

    deinit {
        // Thanks to @kballard for providing this code:
        // try to avoid deep recursion in deinit by tearing down the rest of the
        // list ourselves if it's uniquely referenced
        while isUniquelyReferencedNonObjC(&next) {
            // we hold the only pointer to next, lets tear it down
            let temp = next
            next = temp?.next
            temp?.next = nil
            // temp no longer has a tail, so when it deinits it won't recurse
            // and if our new next is still uniquely referenced, we'll keep
            // tearing it down. Otherwise, we'll break, next will be released,
            // but it won't recurse because something else will be keeping it
            // alive.
        }
    }
}

public struct FifoQueue<T> {
    private var first: Element<T>?
    private var last: Element<T>?
    public private(set) var count = 0
    public init () {
    }
    public init (array: Array<T>) {
        for a in array {
            self.push(a)
        }
    }
    public mutating func push(data: T) {
        count += 1
        guard first != nil else {
            first = Element(input: data)
            return
        }
        guard last != nil else {
            last = Element(input: data)
            first!.next = last!
            return
        }
        let append = Element(input: data)
        last!.next = append
        self.last = append
    }

    public mutating func pop() -> T? {
        guard first != nil else {return nil}
        count -= 1
        let data = first!.data
        first = first!.next
        return data
    }

    public var last: T? {
        get {
            return self.last
        }
    }

    public var isEmpty: Bool {
        get {
            return first == nil
        }
    }
}
