import 'package:get/get.dart';

class ContentAreaProperties {
  int itemIndex;
  dynamic item;
  bool isFullView;

  ContentAreaProperties({required this.itemIndex, required this.isFullView});
}

class ContentAreaController extends GetxController {
  var contentArea = ContentAreaProperties(itemIndex: 0,isFullView: false).obs;
}
