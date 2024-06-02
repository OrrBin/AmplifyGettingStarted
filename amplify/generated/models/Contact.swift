// swiftlint:disable all
import Amplify
import Foundation

public struct Contact: Model {
  public let id: String
  public var name: String
  public var notificationPeriod: Period
  public var nextNotification: Temporal.DateTime?
  public var lastNotification: Temporal.DateTime?
  public var image: String?
  public var createdAt: Temporal.DateTime?
  public var updatedAt: Temporal.DateTime?
  
  public init(id: String = UUID().uuidString,
      name: String,
      notificationPeriod: Period,
      nextNotification: Temporal.DateTime? = nil,
      lastNotification: Temporal.DateTime? = nil,
      image: String? = nil) {
    self.init(id: id,
      name: name,
      notificationPeriod: notificationPeriod,
      nextNotification: nextNotification,
      lastNotification: lastNotification,
      image: image,
      createdAt: nil,
      updatedAt: nil)
  }
  internal init(id: String = UUID().uuidString,
      name: String,
      notificationPeriod: Period,
      nextNotification: Temporal.DateTime? = nil,
      lastNotification: Temporal.DateTime? = nil,
      image: String? = nil,
      createdAt: Temporal.DateTime? = nil,
      updatedAt: Temporal.DateTime? = nil) {
      self.id = id
      self.name = name
      self.notificationPeriod = notificationPeriod
      self.nextNotification = nextNotification
      self.lastNotification = lastNotification
      self.image = image
      self.createdAt = createdAt
      self.updatedAt = updatedAt
  }
}