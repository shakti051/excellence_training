class Info {
	int? coinsNum;
	int? time;

	Info({this.coinsNum, this.time});

	@override
	String toString() => 'Info(coinsNum: $coinsNum, time: $time)';

	factory Info.fromJson(Map<String, dynamic> json) => Info(
				coinsNum: json['coins_num'] as int?,
				time: json['time'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'coins_num': coinsNum,
				'time': time,
			};

		Info copyWith({
		int? coinsNum,
		int? time,
	}) {
		return Info(
			coinsNum: coinsNum ?? this.coinsNum,
			time: time ?? this.time,
		);
	}
}
