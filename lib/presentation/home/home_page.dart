import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../di/register_dependencies.dart';
import '../bloc/employee_cubit.dart';
import 'add_employee_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EmployeeCubit _employeeCubit;

  @override
  void initState() {
    super.initState();
    _employeeCubit = getItInstance<EmployeeCubit>();
    _employeeCubit.loadEmployees();
  }

  @override
  void dispose() {
    _employeeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.center,
        height: 50.h,
        width: 50.w,
        child: ElevatedButton(
          style: ButtonStyle(
            alignment: Alignment.center,
            foregroundColor: MaterialStateProperty.all(Colors.red),
          ),
          child: Icon(Icons.add, size: 18.w, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushNamed(AddEmployeePage.routeName);
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Employee List",
        ),
      ),
      body: BlocProvider.value(
        value: _employeeCubit,
        child: BlocBuilder<EmployeeCubit, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoadedState) {
              if (state.employees.isEmpty) {
                return Center(child: Image.asset("assets/empty.png"));
              }
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: ListView.builder(
                    itemCount: state.employees.length,
                    itemBuilder: (context, i) {
                      var e = state.employees[i];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        height: 120.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Text(e.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Text(e.designation),
                            ),
                            Text(e.joiningDate.toString())
                          ],
                        ),
                      );
                    }),
              );
            } else if (state is EmployeeErrorState) {
              return Center(
                child: Text(state.connectionError.message!),
              );
            }

            return const Text("noting");
          },
        ),
      ),
    );
  }
}
