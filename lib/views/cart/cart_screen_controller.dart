import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  void onRefresh() {}
}
