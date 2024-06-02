// swiftlint:disable all
import Amplify
import Foundation

public enum Period: String, EnumPersistable {
  case weekly = "WEEKLY"
  case monthly = "MONTHLY"
  case biWeekly = "BI_WEEKLY"
}