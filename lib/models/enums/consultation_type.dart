enum ConsultationType {
  Video,
  Call,
  Chat,
  Offline
}

extension Label on ConsultationType {
  String get label => this.toString().split('.').last;
}

Map<String, ConsultationType> consultationTypeMapper = {
  ConsultationType.Video.label: ConsultationType.Video,
  ConsultationType.Call.label: ConsultationType.Call,
  ConsultationType.Chat.label: ConsultationType.Chat,
  ConsultationType.Offline.label: ConsultationType.Offline,

};
