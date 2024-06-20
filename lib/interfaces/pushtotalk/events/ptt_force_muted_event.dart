part of janus_client;

class PTTForceMutedEvent extends PTTEvent {
  PTTForceMutedEvent({pushtotalk, room}) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTForceMutedEvent.fromJson(dynamic json) {
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
