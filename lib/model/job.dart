import 'package:mobile_client/model/user.dart';
import 'package:mobile_client/model/company.dart';
import 'package:mobile_client/model/types.dart';

class Jobs {
  List<Job> job;

  Jobs({this.job});

  Jobs.fromJson(json) {
    job = <Job>[];
    json['data'].forEach((item) {
      job.add(Job.fromJson(item));
    });
  }
}

class Job {
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
  List<Types> types;
  Company company;

  Job({
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

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobName = json['job_name'];
    jobDescription = json['job_description'];
    poster = json['poster'];
    endDate = json['end_date'];
    companyId = json['company_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['types'] != null) {
      types = <Types>[];
      json['types'].forEach((v) {
        types.add(new Types.fromJson(v));
      });
    }
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
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
      data['types'] = this.types.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company.toJson();
    }
    return data;
  }
}
