// swiftlint:disable all
import Amplify
import Foundation

extension Contact {
  // MARK: - CodingKeys 
   public enum CodingKeys: String, ModelKey {
    case id
    case name
    case notificationPeriod
    case nextNotification
    case lastNotification
    case image
    case createdAt
    case updatedAt
  }
  
  public static let keys = CodingKeys.self
  //  MARK: - ModelSchema 
  
  public static let schema = defineSchema { model in
    let contact = Contact.keys
    
    model.authRules = [
      rule(allow: .owner, ownerField: "owner", identityClaim: "cognito:username", provider: .userPools, operations: [.create, .update, .delete, .read])
    ]
    
    model.listPluralName = "Contacts"
    model.syncPluralName = "Contacts"
    
    model.attributes(
      .primaryKey(fields: [contact.id])
    )
    
    model.fields(
      .field(contact.id, is: .required, ofType: .string),
      .field(contact.name, is: .required, ofType: .string),
      .field(contact.notificationPeriod, is: .required, ofType: .enum(type: Period.self)),
      .field(contact.nextNotification, is: .optional, ofType: .dateTime),
      .field(contact.lastNotification, is: .optional, ofType: .dateTime),
      .field(contact.image, is: .optional, ofType: .string),
      .field(contact.createdAt, is: .optional, isReadOnly: true, ofType: .dateTime),
      .field(contact.updatedAt, is: .optional, isReadOnly: true, ofType: .dateTime)
    )
    }
}

extension Contact: ModelIdentifiable {
  public typealias IdentifierFormat = ModelIdentifierFormat.Default
  public typealias IdentifierProtocol = DefaultModelIdentifier<Self>
}