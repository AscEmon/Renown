import '../ApiProvider/ApiProvider.dart';
import 'package:meta/meta.dart';

class MyRepository {

final MyApiClient apiClient;

MyRepository({@required this.apiClient}) : assert(apiClient != null);

getAll(){
  return apiClient.getAll();
}

signUpPost(String name,String email,String password){
  print(name);
  return apiClient.signUpPost(name,email, password);
}
 loginPost(var adminCheck,String email,String password){
  print(adminCheck);
  return apiClient.loginPost(adminCheck,email, password);
}
logOutPost(){
  return apiClient.logOutPost();
}

}