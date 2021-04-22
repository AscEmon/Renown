
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import '../Model/CategoryModel.dart';
import '../Repository/MyRepository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CheckController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var packagesList = CategoryModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchPackages();
    super.onInit();
  }

  void fetchPackages() async {
    try {
      isLoading(true);
      var packages = await repository.getAll();
      if (packages != null) {
            packagesList(packages);
      }
    } finally {
      isLoading(false);
    }
  }
}