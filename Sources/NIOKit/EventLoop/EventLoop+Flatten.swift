import NIO

extension EventLoop {
    /// Returns a new `EventLoopFuture` that succeeds only when all the provided futures succeed.
    /// The new `EventLoopFuture` contains an array of results, maintaining same ordering as the futures.
    ///
    /// The returned `EventLoopFuture` will fail if any of the provided futures fails. All remaining
    /// `EventLoopFuture` objects will be ignored.
    /// - Parameter futures: An array of futures to flatten into a single `EventLoopFuture`.
    /// - Returns: A new `EventLoopFuture` with all the resolved values of the input collection.
    public func flatten<T>(_ futures: [EventLoopFuture<T>]) -> EventLoopFuture<[T]> {
        return EventLoopFuture.reduce(into: [T](), futures, eventLoop: self, { (a, r) in a.append(r) })
    }

    /// Returns a new `EventLoopFuture` that succeeds only when all the provided futures succeed,
    /// ignoring the resolved values.
    ///
    /// The returned `EventLoopFuture` will fail if any of the provided futures fails. All remaining
    /// `EventLoopFuture` objects will be ignored.
    /// - Parameter futures: An array of futures to wait for.
    /// - Returns: A new `EventLoopFuture`.
    public func flatten<T>(_ futures: [EventLoopFuture<T>]) -> EventLoopFuture<Void> {
        return EventLoopFuture<Void>.reduce((), futures, eventLoop: self) { _, _ in }
    }
}