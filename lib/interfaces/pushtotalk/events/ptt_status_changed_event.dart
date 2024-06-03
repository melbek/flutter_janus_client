part of janus_client;

class PTTStatusChangedEvent extends PTTEvent {
  PTTStatusChangedEvent({pushtotalk, room, this.statuschanged}) {
    super.pushtotalk = pushtotalk;
    super.room = room;
  }

  PTTStatusChangedEvent.fromJson(dynamic json) {
    pushtotalk = json['pushtotalk'];
    room = json['room'];
    statuschanged = json['leaving'];
  }

  dynamic statuschanged;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pushtotalk'] = pushtotalk;
    map['room'] = room;
    map['statuschanged'] = statuschanged;
    return map;
  }
}
