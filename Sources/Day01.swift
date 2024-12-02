import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n").map {
      $0.split(separator: "   ").compactMap { Int($0) }
    }
  }

  func part1() -> Any {
    // I suspect that we don't even need to sort the lists or do this much, but at least this works.
    var leftSide: [Int] = []
    var rightSide: [Int] = []

    for pair in entities {
      if let leftItem = pair.first, let rightItem = pair.last {
        leftSide.append(leftItem)
        rightSide.append(rightItem)
      } else {
        fatalError("The data file wasn't a big list of integer pairs separated by 3 spaces.")
      }
    }
    leftSide.sort()
    rightSide.sort()

    var totalDifference: Int = 0

    // could we do this with reduce somehow?
    for (leftItem, rightItem) in zip(leftSide, rightSide) {
      totalDifference += abs(leftItem - rightItem)
    }

    return totalDifference
  }

  func part2() -> Any {
    var leftSide: [Int] = []
    var rightSide: [Int] = []

    for pair in entities {
      if let leftItem = pair.first, let rightItem = pair.last {
        leftSide.append(leftItem)
        rightSide.append(rightItem)
      } else {
        fatalError("The data file wasn't a big list of integer pairs separated by 3 spaces.")
      }
    }

    // found at https://stackoverflow.com/a/41841238
    // if this were Ruby, I'd use tally, a lovely method used to do exactly this
    let rightSideCounts = rightSide.reduce(into: [:]) { counts, number in
      counts[number, default: 0] += 1
    }

    return leftSide.reduce(0) { $0 + ($1 * rightSideCounts[$1, default: 0]) }
  }
}
