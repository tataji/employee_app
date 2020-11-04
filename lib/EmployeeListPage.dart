import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/service/ApiService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Components/EmployeeItemCard.dart';
import 'model/Employe.dart';

class EmployeeListPage extends StatefulWidget {
  EmployeeListPage() : super();
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  List<Data> employeeList = new List();
  double width;
  double height;
  APiService apiService = new APiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeList();
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:10,bottom:20.0),
                  child: GestureDetector(onTap: (){
                    getEmployeeList();
                  },
                      child: Text("Employee list",style: TextStyle(fontSize: 20),)),
                ),
                FutureBuilder(future: apiService.fetchEmployee(),
                  builder: (context,data){
                   if(data.hasError){
                     return Container();
                   }else {
                     return Container(
                       height: MediaQuery
                           .of(context)
                           .size
                           .height / 1.4,
                       child: employeeList.isEmpty ? Container() : ListView
                           .builder(
                         shrinkWrap: false,
                         scrollDirection: Axis.vertical,
                         itemCount: employeeList.length,
                         itemBuilder: (context, index) {
                           return EmployeeItemCard(
                             employee: employeeList[index],
                             press: () {
                               Fluttertoast.showToast(
                                 msg: "Name: ${employeeList[index]
                                     .employeeName}"
                                     " Salary: ${employeeList[index]
                                     .employeeSalary}",
                                 toastLength: Toast.LENGTH_SHORT,
                                 gravity: ToastGravity.CENTER,
                               );
                             },);
                         },
                       ),
                     );
                   }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

   getEmployeeList() async {
      var response = await http.get(Uri.encodeFull("https://dummy.restapiexample.com/api/v1/employees"),
          headers: {
            "Accept": "application/json"
          }
      );
      Employee emloyeesModel = Employee.fromJson(json.decode(response.body));
      print(' response ${response.body}');
       if(emloyeesModel.status=="success") {
         employeeList= emloyeesModel.data.toList();
       }else{
         Fluttertoast.showToast(
           msg: "Please try again, some thing went while loading the employee list",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
         );
       }
       setState(() {});
  }
}