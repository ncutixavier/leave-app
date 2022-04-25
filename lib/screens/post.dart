import 'package:flutter/material.dart';
import 'package:leaveapp/services/department-service.dart';
import 'package:leaveapp/models/department.dart';

class PostsPage extends StatelessWidget {
  final DepartmentService httpService = DepartmentService();
  static const routename = "post";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder(
        future: httpService.getDepartments(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Department>> snapshot) {
          print('snapshot');
          print(snapshot.data);
          if (snapshot.hasData) {
            List<Department>? posts = snapshot.data;
            return ListView(
              children: posts!
                  .map(
                    (Department post) => ListTile(
                      title: Text('${post.departmentName} Department'),
                      subtitle: Text("${post.supervisorName} - ${post.supervisorEmail}"),
                    ),
                  )
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Text('Error:: ${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
