import 'package:hive/hive.dart';

part 'todo_model.g.dart';

//Hive Field and TypeAdapter for the data model
@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int? completed;

  TodoModel({this.title, this.description, this.completed});
}
