import 'package:flutter_test_app/utils/types.dart';

abstract class Model {
  static const String columnId = 'id';

  late final Id id;

  Model({this.id = 0});

  Model.fromMap(Map<String, dynamic> map) {
    id = map[columnId] as Id;
  }

  Map<String, dynamic> toMap() {
    return id != 0 ? {columnId: id} : {};
  }
}
