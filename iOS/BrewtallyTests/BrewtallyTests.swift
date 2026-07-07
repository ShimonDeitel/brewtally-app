import XCTest
@testable import Brewtally

@MainActor
final class BrewtallyTests: XCTestCase {
    var store: Store!

    override func setUp() async throws {
        store = Store()
        store.entries = []
    }

    func testAddEntryIncreasesCount() {
        let before = store.entries.count
        store.add(BrewEntry())
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testFreshInstallSeedDataBelowFreeLimit() {
        let seed = Store.seedData()
        XCTAssertLessThan(seed.count, Store.freeLimit)
    }

    func testCanAddMoreWhenUnderLimit() {
        store.entries = []
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreAtFreeLimit() {
        store.entries = (0..<Store.freeLimit).map { _ in BrewEntry() }
        XCTAssertFalse(store.canAddMore)
    }

    func testAddRespectsLimit() {
        store.entries = (0..<Store.freeLimit).map { _ in BrewEntry() }
        store.add(BrewEntry())
        XCTAssertEqual(store.entries.count, Store.freeLimit)
    }

    func testDeleteAtOffsetRemovesEntry() {
        let entry = BrewEntry()
        store.entries = [entry]
        store.delete(at: IndexSet(integer: 0))
        XCTAssertTrue(store.entries.isEmpty)
    }

    func testDeleteSpecificEntry() {
        let entry = BrewEntry()
        store.entries = [entry]
        store.delete(entry)
        XCTAssertTrue(store.entries.isEmpty)
    }

    func testUpdateEntryReplacesExisting() {
        var entry = BrewEntry()
        store.entries = [entry]
        entry = BrewEntry(id: entry.id)
        store.update(entry)
        XCTAssertEqual(store.entries.first?.id, entry.id)
    }
}
