// swiftlint:disable all
import Amplify
import Foundation

// Contains the set of classes that conforms to the `Model` protocol. 

final public class AmplifyModels: AmplifyModelRegistration {
  public let version: String = "550680c72955cd16f090e1e08028793f"
  
  public func registerModels(registry: ModelRegistry.Type) {
    ModelRegistry.register(modelType: Note.self)
    ModelRegistry.register(modelType: Contact.self)
  }
}