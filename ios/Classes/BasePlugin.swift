import Flutter
import UIKit
import Greeting
public class BasePlugin: NSObject, FlutterPlugin,HostMessageApi {
    
    private static var flutterAPI: FlutterMessageApi? = nil
    public static func register(with registrar: any FlutterPluginRegistrar) {
        let api = BasePlugin()
        HostMessageApiSetup.setUp(binaryMessenger: registrar.messenger(), api: api)
        flutterAPI = FlutterMessageApi(binaryMessenger: registrar.messenger())
    }
    
    func flutter2Native(message: String, type: Int64) throws -> String {
        print("ios->flutter2Native=>start=>message=\(message)=type=\(type)");
        if type==1 {
            var error: NSError?
            if let walletResponse = GreetingCreateWalletF1( "111111", &error) {
               let dict: [String: Any] = [
                   "address": walletResponse.address,
                   "privateKey": walletResponse.privateKey,
                   "publicKey": walletResponse.publicKey,
                   "mnemonic": walletResponse.mnemonic,
                   "keystore": walletResponse.keystore
               ]
               do {
                   let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                   let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
                    // 在这里处理成功创建钱包后的walletResponse，比如获取钱包相关信息等
                   return jsonString
               } catch {
                   print("Error converting to JSON: \(error)")
               }
            return ""
            } else {
                // 在这里处理创建钱包失败的情况，通过error获取错误信息
                if let unwrappedError = error {
                    print("创建钱包失败，错误信息：\(unwrappedError.localizedDescription)")
                } else {
                    print("创建钱包失败，但未获取到具体错误信息")
                }
                return ""
            }
        } else if type==2{
            return "这是日志信息"+GreetingSayHi("ios->flutter2Native=>start=>message=\(message)=type=\(type)")
        }else{
            return "ios->flutter2Native=>start=>message=\(message)=type=\(type)"
        }
    }


    func flutter2NativeAsync(message: String, type: Int64, completion: @escaping (Result<String, any Error>) -> Void) {
        print("ios->flutter2NativeAsyncMessage===2")
        completion(.success(message))
    }

    

}

