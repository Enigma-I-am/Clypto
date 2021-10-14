import 'dart:convert';

import 'package:truncate/truncate.dart';

class Exchange {
  Exchange({
    this.data,
  });

  List<ExchangeDatum>? data;

  factory Exchange.fromJson(String str) => Exchange.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Exchange.fromMap(Map<String, dynamic> json) =>
      Exchange(data: List<ExchangeDatum>.from(json["data"].map((x) => ExchangeDatum.fromMap(x))));

  Map<String, dynamic> toMap() => {"data": data == null ? [] : List<dynamic>.from((data ?? []).map((x) => x.toMap()))};
}

class ExchangeDatum {
  ExchangeDatum({
    this.exchangeId,
    this.website,
    this.name,
    // this.dataStart,
    // this.dataEnd,
    // this.dataQuoteStart,
    // this.dataQuoteEnd,
    // this.dataOrderbookStart,
    // this.dataOrderbookEnd,
    // this.dataTradeStart,
    // this.dataTradeEnd,
    this.dataSymbolsCount,
    this.volume1HrsUsd,
    this.volume1DayUsd,
    this.volume1MthUsd,
  });

  String? exchangeId;
  String? website;
  String? name;
  // DateTime? dataStart;
  // DateTime? dataEnd;
  // DateTime? dataQuoteStart;
  // DateTime? dataQuoteEnd;
  // DateTime? dataOrderbookStart;
  // DateTime? dataOrderbookEnd;
  // DateTime? dataTradeStart;
  // DateTime? dataTradeEnd;
  int? dataSymbolsCount;
  double? volume1HrsUsd;
  double? volume1DayUsd;
  double? volume1MthUsd;

  String get clyptoName => truncate(
        name ?? '',
        15,
        omission: '',
        position: TruncatePosition.end,
      );
  num get clyptoAmount => (volume1DayUsd ?? 0) ~/ 10000;

  factory ExchangeDatum.fromJson(String str) => ExchangeDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeDatum.fromMap(Map<String, dynamic> json) => ExchangeDatum(
        exchangeId: json["exchange_id"],
        website: json["website"],
        name: json["name"] ?? 'xxx',
        // dataStart: json["data_start"] != null ? DateTime.parse(json["data_start"]) : DateTime.now(),
        // dataEnd: json["data_end"] != null ? DateTime.parse(json["data_end"]) : DateTime.now(),
        // dataQuoteStart: json["data_quote_start"] != null ? DateTime.parse(json["data_quote_start"]) : DateTime.now(),
        // dataQuoteEnd: json["data_quote_end"] != null ? DateTime.parse(json["data_quote_end"]) : DateTime.now(),
        // dataOrderbookStart:
        //     json["data_orderbook_start"] != null ? DateTime.parse(json["data_orderbook_start"]) : DateTime.now(),
        // dataOrderbookEnd:
        //     json["data_orderbook_end"] != null ? DateTime.parse(json["data_orderbook_end"]) : DateTime.now(),
        // dataTradeStart: json["data_trade_start"] != null ? DateTime.parse(json["data_trade_start"]) : DateTime.now(),
        // dataTradeEnd: json["data_trade_end"] != null ? DateTime.parse(json["data_trade_end"]) : DateTime.now(),
        dataSymbolsCount: json["data_symbols_count"],
        volume1HrsUsd: json["volume_1hrs_usd"].toDouble(),
        volume1DayUsd: json["volume_1day_usd"].toDouble(),
        volume1MthUsd: json["volume_1mth_usd"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "exchange_id": exchangeId,
        "website": website,
        "name": name,
        // "data_start":
        //     "${dataStart?.year.toString().padLeft(4, '0')}-${dataStart?.month.toString().padLeft(2, '0')}-${dataStart?.day.toString().padLeft(2, '0')}",
        // "data_end":
        //     "${dataEnd?.year.toString().padLeft(4, '0')}-${dataEnd?.month.toString().padLeft(2, '0')}-${dataEnd?.day.toString().padLeft(2, '0')}",
        // "data_quote_start": (dataQuoteStart ?? DateTime.now()).toIso8601String(),
        // "data_quote_end": (dataQuoteEnd ?? DateTime.now()).toIso8601String(),
        // "data_orderbook_start": (dataOrderbookStart ?? DateTime.now()).toIso8601String(),
        // "data_orderbook_end": (dataOrderbookEnd ?? DateTime.now()).toIso8601String(),
        // "data_trade_start": (dataTradeStart ?? DateTime.now()).toIso8601String(),
        // "data_trade_end": (dataTradeEnd ?? DateTime.now()).toIso8601String(),
        "data_symbols_count": dataSymbolsCount,
        "volume_1hrs_usd": volume1HrsUsd,
        "volume_1day_usd": volume1DayUsd,
        "volume_1mth_usd": volume1MthUsd,
      };
}
