
class FetchData {
  final String message;
  final int id;

  FetchData({this.message, this.id});

  factory FetchData.fromJson(Map<String, dynamic> json) {
    return FetchData(
      message: json['message'],
      id: json['id'],
    );
  }
}