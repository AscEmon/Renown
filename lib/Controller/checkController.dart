
import 'package:TrainnigInfo/ApiProvider/ApiProvider.dart';
import '../Model/CategoryModel.dart';
import '../Repository/MyRepository.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CheckController extends GetxController {
  final MyRepository repository =
      MyRepository(apiClient: MyApiClient(httpClient: Client()));
  var isLoading = true.obs;
  var categoryList = CategoryModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    fetchJob();
    super.onInit();
  }

  void fetchJob() async {
    try {
      isLoading(true);
      var category = await repository.getAll();
      if (category != null) {
            categoryList(category);
      }
    } finally {
      isLoading(false);
    }
  }
}