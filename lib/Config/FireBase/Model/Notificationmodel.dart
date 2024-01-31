class Notifier {
  String to;
  Notifications notification;
  Datas data;

  Notifier({required this.to, required this.notification, required this.data});

  Notifier.fromJson(Map<String, dynamic> json)
      : to = json['to'],
        notification = (json['notification'] != null
            ? new Notifications.fromJson(json['notification'])
            : null)!,
        data =
            (json['data'] != null ? new Datas.fromJson(json['data']) : null)!;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Notifications {
  String title;
  String body;
  String sound;
  String tag;
  String? color;
  Notifications(
      {required this.title,
      required this.body,
      required this.sound,
      required this.tag,
      this.color});

  Notifications.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        body = json['body'],
        sound = json['sound'],
        tag = json['tag'],
        color = json['color'] ?? "";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['sound'] = this.sound;
    data['tag'] = this.tag;
    data['color'] = this.color;
    return data;
  }
}

class Datas {
  String postid;
  String postimage;
  var senderid;
  var receiverid;
  var msg;
  var time;
  Datas({
    required this.postid,
    required this.postimage,
    required this.senderid,
    required this.receiverid,
    required this.msg,
    required this.time,
  });

  Datas.fromJson(Map<String, dynamic> json)
      : postid = json['postid'],
        postimage = json['postimage'],
        senderid = json['senderid'],
        receiverid = json['receiverid'],
        msg = json['msg'],
        time = json['time'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postid'] = this.postid;
    data['postimage'] = this.postimage;
    data['senderid'] = this.senderid;
    data['receiverid'] = this.receiverid;
    data['msg'] = this.msg;
    data['time'] = this.time;

    return data;
  }
}
