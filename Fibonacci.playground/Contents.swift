import UIKit

public func sequence<T>(first: T,
                        while condition: @escaping (T)-> Bool,
                        next: @escaping (T) -> T) -> UnfoldSequence<T, T>
{
    let nextState =
    {
        (state: inout T) -> T? in
        // Return `nil` if condition is no longer satisfied:
        guard condition(state) else { return nil }
        // Update current value _after_ returning from this call:
        defer { state = next(state) }
        // Return current value:
        return state
    }
    return sequence(state: first, next: nextState)
}

for f in sequence(first: (0, 1), while: { $1 <= 1000 }, next: { ($1, $0 + $1)})
{
    if f.1 > 750 && f.1 < 1000  //the second condition is not necessary its already in 1000 while loop
    {
        print(f.1)
    }
}
