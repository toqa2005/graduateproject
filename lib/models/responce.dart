import 'data_model.dart';

class MoviesResponseModel {
  final String status;
  final String statusMessage;
  final DataModel data;

  MoviesResponseModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MoviesResponseModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return MoviesResponseModel(
      status: json['status'] ?? '',
      statusMessage:
      json['status_message'] ?? '',

      data: DataModel.fromJson(
        json['data'] ?? {},
      ),
    );
  }
}