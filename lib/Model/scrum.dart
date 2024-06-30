import 'dart:convert';
import 'dart:io';

class Scrum {
  // File image;
  String icon;
  String summary;
  String yesterday;
  String today;
  String learned;
  int team;
  int date;

  Scrum({
    // required this.image,
    required this.icon,
    required this.summary,
    required this.yesterday,
    required this.today,
    required this.learned,
    required this.team,
    required this.date,
  });

  // 이미지 파일을 base64로 인코딩
  String _encodeImageToBase64(image) {
    final bytes = image.readAsBytesSync();
    return base64Encode(bytes);
  }


  // instance -> json
  Map<String, dynamic> toJson() {
    return {
      // 'image': _encodeImageToBase64(image),
      'icon': icon,
      'summary': summary,
      'yesterday': yesterday,
      'today': today,
      'learned': learned,
      'team': team,
      'date': date
    };
  }

  // JSON -> instance
  factory Scrum.fromJson(json) {

    // String base64Image = json['image'];
    // File imageFile = File('decoded_image.jpg');
    // imageFile.writeAsBytesSync(base64Decode(base64Image));

    return Scrum(
      // image: imageFile,
      icon: json['icon'],
      summary: json['summary'],
      yesterday: json['yesterday'],
      today: json['today'],
      learned: json['learned'],
      team: json['team'],
      date: json['date'],
    );
  }
}

