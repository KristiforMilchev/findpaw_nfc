import 'package:domain/exceptions/base_exception.dart';

class ReleasePauseTimeOutOFBound extends BaseException {
  ReleasePauseTimeOutOFBound({required super.context});

  @override
  String? message = "Time cannot be greated then the remaining pause time.";

  @override
  StackTrace? stackTrace;

  @override
  String? title = "Time validation error";
}
