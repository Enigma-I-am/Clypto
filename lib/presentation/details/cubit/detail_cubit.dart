import 'package:bloc/bloc.dart';
import 'package:clypto/data/config/exceptions.dart';
import 'package:clypto/data/core/exchange.dart';
import 'package:clypto/data/core/exchange_balance.dart';
import 'package:clypto/data/remote/clypto_service.dart';
import 'package:clypto/di/di.dart';
import 'package:clypto/utils/clypto_logger.dart';
import 'package:equatable/equatable.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailState.initial());

  final _clyptoService = getIt<ClyptoService>();

  Future getExchanges() async {
    emit(state.copyWith(status: ClptoDetailStatus.loading, resMessage: null));
    try {
      final res = await _clyptoService.getExchanges();

      emit(state.copyWith(status: ClptoDetailStatus.success, exchanges: res.data));
    } on CustomException catch (err) {
      MyLogger.logger.d("Error: $err");
      emit(state.copyWith(status: ClptoDetailStatus.failure, resMessage: err.message));
    } catch (e) {
      MyLogger.logger.d("This is the Error: ${e.toString()}");
      emit(state.copyWith(status: ClptoDetailStatus.failure, resMessage: e.toString()));
    }
  }

  Future getExchengeBalance() async {
    emit(state.copyWith(status: ClptoDetailStatus.loadingExchangeBalance));
    try {
      final res = await _clyptoService.getExchangeBalance();
      emit(state.copyWith(status: ClptoDetailStatus.exchangeBalanceSuccess, exchangeBalance: res));
    } on CustomException catch (err) {
      emit(state.copyWith(status: ClptoDetailStatus.exchangeBalanceFailure, resMessage: err.message));
    } catch (e) {
      MyLogger.logger.d("This is the Error ex: ${e.toString()}");
      emit(state.copyWith(status: ClptoDetailStatus.exchangeBalanceFailure, resMessage: 'Something went wrong'));
    }
  }
}
