import 'package:get/get.dart';

class WorkerController extends GetxController {
  final tasks = <Map<String, String>>[
    {
      'title': 'Plastic waste pickup',
      'distance': '2.1 km',
      'status': 'Assigned',
    },
    {
      'title': 'Metal scrap collection',
      'distance': '4.8 km',
      'status': 'In Progress',
    },
  ].obs;

  void updateTaskStatus(int index, String status) {
    tasks[index] = {...tasks[index], 'status': status};
  }
}
