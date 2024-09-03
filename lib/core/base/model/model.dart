abstract class Model<T> {
  Map<String, dynamic> toJson();
  T fromJson(String docID, Map<String, dynamic> json);
}
