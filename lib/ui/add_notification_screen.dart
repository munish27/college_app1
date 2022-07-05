import 'dart:io';

import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/admin/provider/department_provider.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/notification_provider.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({Key? key}) : super(key: key);

  @override
  State<AddNotificationScreen> createState() => _AddNotificationScreenState();
}

class _AddNotificationScreenState extends State<AddNotificationScreen> {
  late TextEditingController _name;
  late TextEditingController _description;

  late NotificationProvider _provider;
  final _key = GlobalKey<FormState>();

  void _navigate(bool? val) async {
    Navigator.of(context).pop(val ?? false);
  }

  @override
  void initState() {
    _provider = Provider.of<NotificationProvider>(context, listen: false);
    _name = TextEditingController();
    _description = TextEditingController();
    _provider.addListener(() {
      if (_provider.status == STATUS.ERROR) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(_provider.errMsg ??
                'Something went wrong, Please try again later.')));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigate(null);
        return true;
      },
      child: ChangeNotifierProvider.value(
        value: _provider,
        child: Scaffold(
          body: SafeArea(child: bodyContainer()),
        ),
      ),
    );
  }

  Widget bodyContainer() => Consumer<NotificationProvider>(
      builder: (context, value, child) => Stack(
            children: [
              _form(),
              value.status == STATUS.LOADING
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
            ],
          ));

  Widget _form() => Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.h),
          shrinkWrap: true,
          children: [
            myTextFeild(
              context,
              title: 'Title',
              controller: _name,
              hint: 'Enter title',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid title';
                }
              },
            ),
            SizedBox(height: 30.h),
            myTextFeild(
              context,
              title: 'Description *',
              controller: _description,
              hint: 'Enter description',
              validator: (val) {
                if (val != null && val.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter valid description';
                }
              },
            ),
            SizedBox(height: 30.h),
            Consumer<NotificationProvider>(builder: (context, provider, child) {
              if (provider.filePath != null &&
                  provider.filePath!.path.isNotEmpty) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                  child: Text(provider.filePath!.path),
                );
              } else {
                return ElevatedButton(
                  onPressed: () async {
                    //pick file
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles();
                    if (result != null && result.files.single.path != null) {
                      File file = File(result.files.single.path!);
                      provider.addFile(file);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.button,
                    primary: Color(0xff6AE099),
                    elevation: 0,
                    minimumSize: Size.fromHeight(58.h),
                    maximumSize: Size.fromHeight(58.h),
                  ),
                  child: Text('Add File'),
                );
              }
            }),
            //file
            SizedBox(height: 70.h),
            myButton(
              context,
              title: 'Add Notification',
              onPressed: () async {
                if (_key.currentState != null &&
                    _key.currentState!.validate()) {
                  final _result = await _provider.addNotifications(
                    title: _name.value.text,
                    description: _description.value.text,
                  );
                  if (_result) {
                    _navigate(true);
                  }
                }
              },
            ),
          ],
        ),
      );
}
