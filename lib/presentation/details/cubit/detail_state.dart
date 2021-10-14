part of 'detail_cubit.dart';

enum ClptoDetailStatus {
  initial,
  loading,
  success,
  failure,
  loadingExchangeBalance,
  exchangeBalanceSuccess,
  exchangeBalanceFailure,
  // exchangeBalanceInitial,
}

extension ClptoDetailStatusX on ClptoDetailStatus {
  bool get isInitial => this == ClptoDetailStatus.initial;
  bool get isLoading => this == ClptoDetailStatus.loading;
  bool get isSuccess => this == ClptoDetailStatus.success;
  bool get isFailure => this == ClptoDetailStatus.failure;
  bool get isloadingExchangeBalance => this == ClptoDetailStatus.loadingExchangeBalance;
  bool get isexchangeBalanceSuccess => this == ClptoDetailStatus.exchangeBalanceSuccess;
  bool get isexchangeBalanceFailure => this == ClptoDetailStatus.exchangeBalanceFailure;
  // bool get isexchangeBalanceInitial => this == ClptoDetailStatus.exchangeBalanceInitial;
}

class DetailState extends Equatable {
  const DetailState({
    this.status = ClptoDetailStatus.initial,
    required this.exchanges,
    this.resMessage,
    this.exchangeBalance,
  });

  final ClptoDetailStatus status;
  final List<ExchangeDatum> exchanges;
  final ExchangeBalance? exchangeBalance;
  final String? resMessage;

  factory DetailState.initial() {
    return DetailState(exchanges: []);
  }

  @override
  List<Object> get props => [status, exchanges, resMessage ?? '', exchangeBalance ?? ''];

  DetailState copyWith({
    ClptoDetailStatus? status,
    List<ExchangeDatum>? exchanges,
    ExchangeBalance? exchangeBalance,
    String? resMessage,
  }) {
    return DetailState(
      status: status ?? this.status,
      exchanges: exchanges ?? this.exchanges,
      resMessage: resMessage ?? this.resMessage,
      exchangeBalance: exchangeBalance ?? this.exchangeBalance,
    );
  }
}
