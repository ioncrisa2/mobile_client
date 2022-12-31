import 'package:mobile_client/model/company.dart';
import 'package:mobile_client/model/type.dart';
import 'package:mobile_client/model/user.dart';

class JobDetail {
  int id;
  String jobName;
  String jobDescription;
  String poster;
  String endDate;
  int companyId;
  int userId;
  String createdAt;
  String updatedAt;
  User user;
  Types types;
  Company company;

  JobDetail({
    this.id,
    this.jobName,
    this.jobDescription,
    this.poster,
    this.endDate,
    this.companyId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.types,
    this.company,
  });

  JobDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['job_name'];
    jobDescription = json['job_description'];
    poster = json['poster'];
    endDate = json['end_date'];
    companyId = json['company_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    types = json['types'] != null ? new Types.fromJson(json['types']) : null;
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_name'] = this.jobName;
    data['job_description'] = this.jobDescription;
    data['poster'] = this.poster;
    data['end_date'] = this.endDate;
    data['company_id'] = this.companyId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.types != null) {
      data['types'] = this.types.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}
