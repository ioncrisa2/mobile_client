import 'package:flutter/material.dart';
import 'package:mobile_client/model/job.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/screens/job_info_detail_screen.dart';
import 'package:mobile_client/service/job_service.dart';

class JobInfoScreen extends StatefulWidget {
  JobInfoScreen({Key key}) : super(key: key);

  @override
  State<JobInfoScreen> createState() => _JobInfoScreenState();
}

class _JobInfoScreenState extends State<JobInfoScreen> {
  Future<Jobs> futureJobs;

  @override
  void initState() {
    super.initState();
    futureJobs = JobService().getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Info'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => Navigator.pushNamed(context, '/jobinfo'),
          )
        ],
      ),
      body: FutureBuilder(
          future: futureJobs,
          builder: (ctx, ss) {
            if (ss.hasData) {
              return JobListWidget(jobs: ss.data.job);
            } else if (ss.hasError) {
              return Text("${ss.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
      drawer: AppDrawer(),
    );
  }
}

class JobListWidget extends StatefulWidget {
  final jobs;
  JobListWidget({Key key, this.jobs}) : super(key: key);

  @override
  State<JobListWidget> createState() => _JobListWidgetState();
}

class _JobListWidgetState extends State<JobListWidget> {
  List<Job> _jobsList;

  @override
  void initState() {
    super.initState();
    _jobsList = widget.jobs;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _jobsList.length,
      itemBuilder: (ctx, index) {
        final item = _jobsList[index];
        return InkWell(
          onTap: () {
            print('Clicked ${item.id}');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobInfoDetailScreen(id: item.id),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 120,
                    child: Image.network(item.poster),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            item.jobName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, size: 12),
                              SizedBox(width: 5),
                              Text('Berlaku sampai : '),
                              Text(item.endDate),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_city, size: 12),
                              SizedBox(width: 5),
                              Text('Dari : '),
                              Text(item.company.name)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
