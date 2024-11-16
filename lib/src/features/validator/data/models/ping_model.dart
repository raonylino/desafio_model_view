class PingModel {
  final String? url;
  final bool success;

  PingModel({
    required this.success,
    this.url,
  });

  factory PingModel.fromJson(Map<String, dynamic> json) => PingModel(
        success: json["success"] ?? false,
        url: json["url"],
      );

  @override
  String toString() => 'PingModel(success: $success, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PingModel && other.success == success && other.url == url;
  }

  @override
  int get hashCode => success.hashCode ^ url.hashCode;
}
