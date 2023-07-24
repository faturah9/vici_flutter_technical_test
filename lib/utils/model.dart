abstract class BaseModel<T> {
  Map<String, dynamic> toJson();

  T jsonToModel(Map<String, dynamic> json);
}
