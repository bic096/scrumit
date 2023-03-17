import 'package:appwrite/appwrite.dart';
import 'package:scrumit/core/constant.dart';

class AppWrite {
  // static final AppWrite _singleton = AppWrite._internal();
  Client appWriteClient = Client()
      .setEndpoint(kAppWriteServerEndPoint) // Your Appwrite Endpoint
      .setProject(kAppwriteServerProjectId) // Your project ID
      .setSelfSigned(status: true);

  // factory AppWrite() {
  //   return _singleton;
  // }

  // AppWrite._internal();

  Databases getDataBase() {
    Databases databases = Databases(appWriteClient);
    return databases;
  }

  Account getAccount() {
    Account account = Account(appWriteClient);
    return account;
  }

  Functions getFunctions() {
    // Functions functions = Functions(appWriteClient);
    return Functions(appWriteClient);
  }

  Teams getTeams() {
    return Teams(appWriteClient);
  }
}
