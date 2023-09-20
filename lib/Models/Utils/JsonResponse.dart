class JsonResponse {
  final dynamic data;
  final String message;
  final int statusCode;

  JsonResponse(this.data, this.message, this.statusCode);

  JsonResponse.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        statusCode = json['code'],
        message = json['message'];
}
