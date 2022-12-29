import 'package:flutter/material.dart';
import 'package:mobile_client/screens/app_drawer.dart';

class JobInfoDetailScreen extends StatefulWidget {
  JobInfoDetailScreen({Key key}) : super(key: key);

  @override
  State<JobInfoDetailScreen> createState() => _JobInfoDetailScreenState();
}

class _JobInfoDetailScreenState extends State<JobInfoDetailScreen> {
  final List<String> types = [
    'nodejs',
    'javascript',
    'mysql',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Job Info')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 400,
                margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                child: Image.network(
                  'https://res.cloudinary.com/ioncrisa2/image/upload/v1671418185/poster/2022-12-19_024943_paninti-backend.png',
                ),
              ),
            ),
            Text(
              'Backend Developer',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            Wrap(spacing: 5, children: [
              Chip(label: Text('nodejs')),
              Chip(label: Text('javascript')),
              Chip(label: Text('rest api')),
              Chip(label: Text('MySql')),
              Chip(label: Text('Micro service')),
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              child: Text(
                'Diperlukan seorang backend developer yang telah memiliki pengalaman dengan nodejs dan ekosistemnya Diperlukan seorang backend developer yang telah memiliki pengalaman dengan nodejs dan ekosistemnya',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
