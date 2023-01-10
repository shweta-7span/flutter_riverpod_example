class PreviousDataModel {
  int? drawNumber;
  DateTime? drawDate;
  String? immigrationProgram;
  int? invitationsIssued;
  int? crsScore;
  String? programsCovered;
  String? link;

  PreviousDataModel(
      {this.drawNumber,
      this.drawDate,
      this.immigrationProgram,
      this.invitationsIssued,
      this.crsScore,
      this.programsCovered,
      this.link});

  PreviousDataModel.fromJson(Map<String, dynamic> json) {
    drawNumber = json['draw_number'];
    drawDate = DateTime.parse(json['draw_date']);
    immigrationProgram = json['immigration_program'];
    invitationsIssued = json['invitations_issued'];
    crsScore = json['crs_score'];
    programsCovered = json['programs_covered'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw_number'] = this.drawNumber;
    data['draw_date'] = this.drawDate?.toIso8601String();
    data['immigration_program'] = this.immigrationProgram;
    data['invitations_issued'] = this.invitationsIssued;
    data['crs_score'] = this.crsScore;
    data['programs_covered'] = this.programsCovered;
    data['link'] = this.link;
    return data;
  }
}
