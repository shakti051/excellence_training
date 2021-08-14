class Coin {
  String? id;
  String? symbol;
  String? name;
  String? nameid;
  int? rank;
  String? priceUsd;
  String? percentChange24h;
  String? percentChange1h;
  String? percentChange7d;
  String? priceBtc;
  String? marketCapUsd;
  double? volume24;
  double? volume24a;
  String? csupply;
  String? tsupply;
  String? msupply;

  Coin({
    this.id,
    this.symbol,
    this.name,
    this.nameid,
    this.rank,
    this.priceUsd,
    this.percentChange24h,
    this.percentChange1h,
    this.percentChange7d,
    this.priceBtc,
    this.marketCapUsd,
    this.volume24,
    this.volume24a,
    this.csupply,
    this.tsupply,
    this.msupply,
  });

  @override
  String toString() {
    return 'Data(id: $id, symbol: $symbol, name: $name, nameid: $nameid, rank: $rank, priceUsd: $priceUsd, percentChange24h: $percentChange24h, percentChange1h: $percentChange1h, percentChange7d: $percentChange7d, priceBtc: $priceBtc, marketCapUsd: $marketCapUsd, volume24: $volume24, volume24a: $volume24a, csupply: $csupply, tsupply: $tsupply, msupply: $msupply)';
  }

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json['id'] as String?,
        symbol: json['symbol'] as String?,
        name: json['name'] as String?,
        nameid: json['nameid'] as String?,
        rank: json['rank'] as int?,
        priceUsd: json['price_usd'] as String?,
        percentChange24h: json['percent_change_24h'] as String?,
        percentChange1h: json['percent_change_1h'] as String?,
        percentChange7d: json['percent_change_7d'] as String?,
        priceBtc: json['price_btc'] as String?,
        marketCapUsd: json['market_cap_usd'] as String?,
        volume24: json['volume24'] as double?,
        volume24a: json['volume24a'] as double?,
        csupply: json['csupply'] as String?,
        tsupply: json['tsupply'] as String?,
        msupply: json['msupply'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'nameid': nameid,
        'rank': rank,
        'price_usd': priceUsd,
        'percent_change_24h': percentChange24h,
        'percent_change_1h': percentChange1h,
        'percent_change_7d': percentChange7d,
        'price_btc': priceBtc,
        'market_cap_usd': marketCapUsd,
        'volume24': volume24,
        'volume24a': volume24a,
        'csupply': csupply,
        'tsupply': tsupply,
        'msupply': msupply,
      };

  Coin copyWith({
    String? id,
    String? symbol,
    String? name,
    String? nameid,
    int? rank,
    String? priceUsd,
    String? percentChange24h,
    String? percentChange1h,
    String? percentChange7d,
    String? priceBtc,
    String? marketCapUsd,
    double? volume24,
    double? volume24a,
    String? csupply,
    String? tsupply,
    String? msupply,
  }) {
    return Coin(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      nameid: nameid ?? this.nameid,
      rank: rank ?? this.rank,
      priceUsd: priceUsd ?? this.priceUsd,
      percentChange24h: percentChange24h ?? this.percentChange24h,
      percentChange1h: percentChange1h ?? this.percentChange1h,
      percentChange7d: percentChange7d ?? this.percentChange7d,
      priceBtc: priceBtc ?? this.priceBtc,
      marketCapUsd: marketCapUsd ?? this.marketCapUsd,
      volume24: volume24 ?? this.volume24,
      volume24a: volume24a ?? this.volume24a,
      csupply: csupply ?? this.csupply,
      tsupply: tsupply ?? this.tsupply,
      msupply: msupply ?? this.msupply,
    );
  }
}
