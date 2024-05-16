part of janus_client;

class PTTLeavingEvent extends PTTEvent {
  PTTLeavingEvent({pushtotalk, room, this.leaving}) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTLeavingEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    leaving = json['leaving'];
  }

  dynamic leaving;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushtotalk'] = pushtotalk;
    map['room'] = room;
    map['leaving'] = leaving;
    return map;
  }
}
