import 'package:clypto/data/config/base_api.dart';
import 'package:clypto/data/core/exchange.dart';
import 'package:clypto/data/core/exchange_balance.dart';
import 'package:clypto/data/remote/clypto_repo.dart';

abstract class ClyptoService {
  Future<Exchange> getExchanges();
  Future<ExchangeBalance> getExchangeBalance();
}

class ClyptoServiceImpl extends BaseApi implements ClyptoService {
  final ClyptoRepo repo;
  ClyptoServiceImpl({required this.repo});
  @override
  Future<Exchange> getExchanges() async {
    final res = await repo.getExchanges();
    return res;
  }

  @override
  Future<ExchangeBalance> getExchangeBalance() async {
    final res = await repo.getExchangeBalance();
    return res;
  }
}
