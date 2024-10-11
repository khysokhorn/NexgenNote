class BaseResponse<T> {
  final T? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  BaseResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalRecords,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        data: json["data"],
        status: json["status"],
        message: json["message"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "status": status,
        "message": message,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };
}
