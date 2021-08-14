import 'data.dart';
import 'info.dart';

class CoinBase {
  List<Coin>? data;
  Info? info;

  CoinBase({this.data, this.info});

  @override
  String toString() => 'CoinBase(data: $data, info: $info)';

  factory CoinBase.fromJson(Map<String, dynamic> json) => CoinBase(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Coin.fromJson(e as Map<String, dynamic>))
            .toList(),
        info: json['info'] == null
            ? null
            : Info.fromJson(json['info'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'info': info?.toJson(),
      };

  CoinBase copyWith({
    List<Coin>? data,
    Info? info,
  }) {
    return CoinBase(
      data: data ?? this.data,
      info: info ?? this.info,
    );
  }
}
