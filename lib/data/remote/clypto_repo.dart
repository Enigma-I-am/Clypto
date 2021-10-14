import 'package:clypto/data/config/base_api.dart';
import 'package:clypto/data/core/exchange.dart';
import 'package:clypto/data/core/exchange_balance.dart';

abstract class ClyptoRepo {
  Future<Exchange> getExchanges();
  Future<ExchangeBalance> getExchangeBalance();
}

class ClyptoRepoImpl extends BaseApi implements ClyptoRepo {
  @override
  Future<Exchange> getExchanges() async {
    final res = await get('v1/exchanges');

    return Exchange.fromMap(res);
  }

  @override
  Future<ExchangeBalance> getExchangeBalance() async {
    final res = await get('v1/exchangerate/USD/BTC"');

    return ExchangeBalance.fromMap(res);
  }
}
