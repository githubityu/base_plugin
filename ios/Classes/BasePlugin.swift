import Flutter
import UIKit

public class BasePlugin: NSObject, FlutterPlugin,HostMessageApi {
    
    private static var flutterAPI: FlutterMessageApi? = nil
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let api = BasePlugin()
        HostMessageApiSetup.setUp(binaryMessenger: registrar.messenger(), api: api)
        flutterAPI = FlutterMessageApi(binaryMessenger: registrar.messenger())
    }
    
    func flutter2Native(message: String, type: Int64) throws -> String {
        print("ios->flutter2NativeMessage===="+message);
        return "ios->flutter2Native=message=\(message)=type=\(type)"
    }
    
    func flutter2NativeAsync(message: String, type: Int64, completion: @escaping (Result<String, any Error>) -> Void) {
        print("ios->flutter2NativeAsyncMessage===2")
        completion(.success(message))
    }

    

}

