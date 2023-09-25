class commentsdatas {
/*  processId:1082
  transactionId:2925
  comments:Test Comments
  externalCommentsby:
  createdAt:2023-09-08T06:59:40.40Z
  createdBy:8
  createdByEmail:raja@ezofis.com
  isDeleted:false*/

  dynamic sProcessId = 0;
  dynamic sTransactionId = 0;
  dynamic sComments = '';
  dynamic sExternalCommentsby = '';
  dynamic sCreatedAt = '';
  dynamic sCreatedBy = '';
  dynamic sCreatedByEmail = '';
  bool bIsMe = false;
  bool bIsDeletes = false;
  commentsdatas(
      {required this.sProcessId,
      required this.sTransactionId,
      required this.sComments,
      required this.sExternalCommentsby,
      required this.sCreatedAt,
      required this.sCreatedByEmail,
      required this.bIsDeletes});

  commentsdatas.fromJson(Map<String, dynamic> json, int? iLoginId) {
    sProcessId = json['processId'];
    sTransactionId = json['transactionId'];
    sComments = json['comments'];
    sExternalCommentsby = json['externalCommentsby'];
    sCreatedAt = json['createdAt']
        .toString()
        .substring(0, json['createdAt'].toString().indexOf('T') + 6);
    sCreatedByEmail = json['createdByEmail'];
    bIsMe = json['createdBy'] == iLoginId;
    bIsDeletes = json['isDeleted'];
    sCreatedBy = json['createdBy'];
  }
}
