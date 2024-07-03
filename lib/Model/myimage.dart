class MyImage {
  String url;

  MyImage({
    required this.url
  });

  // Json 받아서 모델 생성
  factory MyImage.fromJson(Map<String, dynamic> json) {
    return MyImage(
      url: json['url'],
    );
  }

  // 모델을 json 형태로 리턴
  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

