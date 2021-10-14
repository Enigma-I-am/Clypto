import 'dart:convert';

class ExchangeBalance {
  ExchangeBalance({
    this.data,
  });

  ExchangeBalanceData? data;

  ExchangeBalanceData get clyptoData =>
      data ?? ExchangeBalanceData(time: DateTime.now(), assetIdBase: '', assetIdQuote: '', rate: 0.0);

  factory ExchangeBalance.fromJson(String str) => ExchangeBalance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeBalance.fromMap(Map<String, dynamic> json) => ExchangeBalance(
        data: ExchangeBalanceData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data?.toMap(),
      };
}

class ExchangeBalanceData {
  ExchangeBalanceData({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
  });

  DateTime? time;
  String? assetIdBase;
  String? assetIdQuote;
  double? rate;

  num get clyptoBalnce => (rate ?? 0) ~/ 1;

  factory ExchangeBalanceData.fromJson(String str) => ExchangeBalanceData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ExchangeBalanceData.fromMap(Map<String, dynamic> json) => ExchangeBalanceData(
        time: DateTime.parse(json["time"]),
        assetIdBase: json["asset_id_base"],
        assetIdQuote: json["asset_id_quote"],
        rate: json["rate"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "time": time?.toIso8601String(),
        "asset_id_base": assetIdBase,
        "asset_id_quote": assetIdQuote,
        "rate": rate,
      };
}
