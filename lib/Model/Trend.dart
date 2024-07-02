class Trend {
  String word;

  Trend({
    required this.word,
  });

  // Json 받아서 모델 생성
  factory Trend.fromJson(Map<String, dynamic> json) {
    return Trend(
      word: json['word'],
    );
  }

  // 모델을 json 형태로 리턴
  Map<String, dynamic> toJson() {
    return {
      'word': word,
    };
  }
}

