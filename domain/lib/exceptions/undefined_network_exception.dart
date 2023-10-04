import 'package:domain/exceptions/base_exception.dart';
import 'package:flutter/material.dart';

class UndefinedNetworkException implements BaseException {
  @override
  String? title = "Page validation error";

  @override
  String? message = "The field Network is required.";

  @override
  StackTrace? stackTrace;

  @override
  BuildContext context;

  UndefinedNetworkException({required this.context});
}
