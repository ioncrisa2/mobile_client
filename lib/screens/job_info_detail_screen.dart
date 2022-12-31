import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/job_detail.dart';
import 'package:mobile_client/model/type.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/job_service.dart';

class JobInfoDetailScreen extends StatefulWidget {
  final id;
  JobInfoDetailScreen({Key key, this.id}) : super(key: key);

  @override
  State<JobInfoDetailScreen> createState() => _JobInfoDetailScreenState();
}

class _JobInfoDetailScreenState extends State<JobInfoDetailScreen> {
  Future<JobDetail> _jobDetailFuture;

  @override
  void initState() {
    super.initState();
    _jobDetailFuture = JobService().detailJob(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Job Info')),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: _jobDetailFuture,
              builder: (ctx, index) {
                final data = index.data;
                if (index.hasData) {
                  // print("data : ${index.data.jobName}");
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        height: 380,
                        child: Image.network(
                          '${data.poster}',
                        ),
                      ),
                      Text(
                        "${data.jobName}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Container(
                        child: Row(
                          children: [
                            sidedInfo('Perusahaan', data.company.name),
                            sidedInfo('Batas Lamar', data.endDate),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tipe Pekerjaan',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              child: TypesWidget(typeList: data.types),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: jobDescription(data.jobDescription),
                      ),
                    ],
                  );
                } else if (index.hasError) {
                  return Text("${index.error}");
                }
                return Center(child: CircularProgressIndicator());
              }),
        ),
      ),
      drawer: AppDrawer(),
    );
  }

  Column jobDescription(text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripsi Pekerjaan',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }

  Expanded sidedInfo(title, data) {
    return Expanded(
      child: ListTile(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          data,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class TypesWidget extends StatefulWidget {
  final typeList;
  TypesWidget({Key key, this.typeList}) : super(key: key);

  @override
  State<TypesWidget> createState() => _TypesWidgetState();
}

class _TypesWidgetState extends State<TypesWidget> {
  Types _typeList;

  @override
  void initState() {
    super.initState();
    _typeList = widget.typeList;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      itemCount: _typeList.items.length,
      itemBuilder: (ctx, index) {
        return IconWithText(
          Icons.fiber_manual_record,
          _typeList.items[index].name,
        );
      },
    );
  }
}

// SingleChildScrollView(
//         child: Column(
//           children: [
//             Center(
//               child: Container(
//                 height: 400,
//                 margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
//                 child: Image.network(
//                   'https://res.cloudinary.com/ioncrisa2/image/upload/v1671418185/poster/2022-12-19_024943_paninti-backend.png',
//                 ),
//               ),
//             ),
//             Text(
//               'Backend Developer',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//             ),
//             Wrap(spacing: 5, children: [
//               Chip(label: Text('nodejs')),
//               Chip(label: Text('javascript')),
//               Chip(label: Text('rest api')),
//               Chip(label: Text('MySql')),
//               Chip(label: Text('Micro service')),
//             ]),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//               child: Text(
//                 'Diperlukan seorang backend developer yang telah memiliki pengalaman dengan nodejs dan ekosistemnya Diperlukan seorang backend developer yang telah memiliki pengalaman dengan nodejs dan ekosistemnya',
//                 style: TextStyle(fontSize: 18),
//                 textAlign: TextAlign.justify,
//               ),
//             )
//           ],
//         ),
//       ),
