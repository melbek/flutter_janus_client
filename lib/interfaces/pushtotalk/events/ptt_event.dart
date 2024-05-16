part of janus_client;

class PTTEvent {
  String? pushtotalk;
  dynamic room;

  PTTEvent.create(videoroom, room) {
    pushtotalk = videoroom;
    room = room;
  }

  PTTEvent() {
    pushtotalk = '';
    room = 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is PTTEvent && runtimeType == other.runtimeType && pushtotalk == other.pushtotalk && room == other.room);

  @override
  int get hashCode => pushtotalk.hashCode ^ room.hashCode;

  @override
  String toString() {
    return 'PTTEvent{pushtotalk: $pushtotalk, room: $room,}';
  }

  Map<String, dynamic> toMap() {
    return {
      'pushtotalk': pushtotalk,
      'room': room,
    };
  }

  factory PTTEvent.fromMap(Map<String, dynamic> map) {
    return PTTEvent.create(
      map['pushtotalk'] as String,
      map['room'] as dynamic,
    );
  }

}
