import 'package:flutter/material.dart';
import 'package:flutter_app/model/Employe.dart';

class EmployeeItemCard extends StatelessWidget {
  final Function press;
  final Data employee;
  const EmployeeItemCard({
    Key key,
    this.employee,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(onTap: (){
       press();
    },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container( width: width,
          height: height/6,
          decoration: new BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Color(0x1a181818),
                  offset: Offset(0, 1),
                  blurRadius: 25,
                  spreadRadius: 0)
            ],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Employee Name: ${employee.employeeName}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Employee Salary: ${employee.employeeSalary}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Employee Age: ${employee.employeeAge}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
