import 'package:flutter_test_app/utils/types.dart';

abstract class Model {
  static const String columnId = 'id';

  final Id id;

  const Model({this.id = 0});

  Map<String, dynamic> toMap() {
    return {columnId: id};
  }
}
