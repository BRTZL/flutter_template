import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class CustomException extends Equatable implements Exception {
  final String error;
  final String message;
  final String path;
  final int status;
  final DateTime date;

  const CustomException({
    @required this.error,
    @required this.message,
    this.path = '',
    this.status = 0,
    @required this.date,
  });

  CustomException.now({
    @required this.error,
    @required this.message,
    this.path = '',
    this.status = 0,
  }) : date = DateTime.now();

  CustomException.unknown({
    @required this.message,
    this.path = '',
    this.status = 0,
  })  : error = "unknown-error",
        date = DateTime.now();

  @override
  List<Object> get props {
    return [
      error,
      message,
      path,
      status,
      date,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'status': status,
      'path': path,
      'date': date?.toUtc()?.toIso8601String(),
    };
  }

  factory CustomException.fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return CustomException(
      error: map['error'] as String ?? '',
      message: map['message'] as String ?? '',
      path: map['path'] as String ?? '',
      status: map['status'] as int ?? 0,
      date: map['date'] == null ? null : DateTime.parse(map['date'] as String),
    );
  }
}
