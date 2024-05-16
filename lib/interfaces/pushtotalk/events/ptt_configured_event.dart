part of janus_client;

class PTTConfiguredEvent {
  PTTConfiguredEvent({
    this.pushtotalk,
    this.room,
    this.result,
  });

  PTTConfiguredEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    result = json['result'];
  }
  String? pushtotalk;
  dynamic room;
  String? result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushtotalk'] = pushtotalk;
    map['room'] = room;
    map['result'] = result;
    return map;
  }
}
