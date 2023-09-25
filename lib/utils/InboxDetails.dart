class InboxDetails {
  final String requestNo;
  final String stage, raisedAt, raisedBy;
  final dynamic lastAction;
  final bool bread;

  InboxDetails(
      {required this.requestNo,
      required this.stage,
      required this.raisedAt,
      required this.raisedBy,
      required this.lastAction,
      required this.bread});

  factory InboxDetails.fromJson(Map<String, dynamic> json) {
    return new InboxDetails(
        requestNo: json['requestNo'],
        stage: json['stage'],
        raisedAt: json['raisedAt'],
        raisedBy: json['raisedBy'],
        lastAction: json['lastAction'],
        //bread: json['read']);
        bread: true);
  }
}
