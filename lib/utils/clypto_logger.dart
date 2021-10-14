import 'package:logger/logger.dart';

class MyLogger {
  static Logger get logger => Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
          printTime: false,
        ),
      );
}
