import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../di/register_dependencies.dart';
import '../bloc/employee_cubit.dart';

class AddEmployeePage extends StatefulWidget {
  static const routeName = "/add-employee";
  const AddEmployeePage({super.key});

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _role;
  late final TextEditingController _startDate;
  late final TextEditingController _endDate;

  final DateTime startdate = DateTime.now();
  DateTime? endDate;

  DateTime selectedDate = DateTime.now();
  final roles = [
    "Product Designer",
    "Flutter Developer",
    "QA Tester",
    "Product Owner"
  ];

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _role = TextEditingController();
    _startDate = TextEditingController();
    _endDate = TextEditingController();
  }

  Future<DateTime?> _openCalendar() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(3023));
    return picked;
  }

  void _openBottomSheet() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (var role in roles)
                Column(
                  children: [
                    TextButton(
                      child: Text(role,
                          style: Theme.of(context).textTheme.bodyMedium),
                      onPressed: () {
                        _role.text = role;

                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                    const Divider(),
                  ],
                ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Employee Details",
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: "Employee name",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.person_outlined,
                          size: 24.w,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: const OutlineInputBorder()),
                    validator: (value) {
                      if (_name.text == '') {
                        return 'Please enter name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: TextFormField(
                    controller: _role,
                    readOnly: true,
                    onTap: () async {
                      _openBottomSheet();
                    },
                    decoration: InputDecoration(
                        hintText: "Select role",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.work_outline,
                          size: 24.w,
                          color: Theme.of(context).primaryColor,
                        ),
                        suffixIcon: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 30.h,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: const OutlineInputBorder()),
                    validator: (value) {
                      if (_role.text == '') {
                        return 'Please select role';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        onTap: () async {
                          var date = await _openCalendar();
                          if (date != null) {
                            setState(() {
                              _startDate.text = date.toIso8601String();
                            });
                          }
                        },
                        readOnly: true,
                        controller: _startDate,
                        decoration: InputDecoration(
                            hintText: "Today",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            prefixIcon: Icon(
                              Icons.event_outlined,
                              size: 24.w,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder()),
                        // validator: (value) {
                        //   if (_startDate.text == '') {
                        //     return 'Please select date';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                    Expanded(
                        child: Icon(
                      Icons.arrow_forward_rounded,
                      size: 24.h,
                      color: Theme.of(context).primaryColor,
                    )),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () async {
                          var date = await _openCalendar();
                          if (date != null) {
                            setState(() {
                              _endDate.text =
                                  "${DateTime(date.year, date.month, date.day)}";
                            });
                          }
                        },
                        controller: _endDate,
                        decoration: InputDecoration(
                            hintText: "No date",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.event_outlined,
                              size: 24.w,
                              color: Theme.of(context).primaryColor,
                            ),
                            border: const OutlineInputBorder()),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter name';
                        //   }
                        //   return null;
                        // },
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: 64.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: ElevatedButton(
                          child: const Text("Cancle"),
                          onPressed: () {},
                        ),
                      ),
                      ElevatedButton(
                        child: const Text("Save"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await getItInstance<EmployeeCubit>().addEmployees(
                                name: _name.text,
                                role: _role.text,
                                startdate: startdate,
                                endDate: endDate);
                            if (mounted) {
                              Navigator.of(context).pop();
                            }
                          }
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
