part of janus_client;

class PTTDestroyedEvent extends PTTEvent {
  PTTDestroyedEvent({pushtotalk, room}) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTDestroyedEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushtotalk'] = pushtotalk;
    map['room'] = room;
    return map;
  }
}
