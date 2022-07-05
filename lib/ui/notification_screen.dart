import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:clg_app/core/my_preference.dart';
import 'package:clg_app/data/entities/notification_entity.dart';
import 'package:clg_app/data/entities/student_entity.dart';
import 'package:clg_app/data/remote/api_response.dart';
import 'package:clg_app/ui/add_notification_screen.dart';
import 'package:clg_app/ui/admin/provider/teacher_provider.dart';
import 'package:clg_app/ui/notification_provider.dart';
import 'package:clg_app/ui/pdf_viwer_screen.dart';
import 'package:clg_app/ui/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider _provider;

  @override
  void initState() {
    _provider = NotificationProvider();
    _provider.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      child: Scaffold(
        backgroundColor: Color(0xffF8FAFF),
        appBar: appbar(context: context, title: 'Notifications'),
        body: bodyContainer(),
        floatingActionButton: MyPreference().getUserType() == 0
            ? FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ChangeNotifierProvider.value(
                                value: _provider,
                                builder: (context, child) =>
                                    AddNotificationScreen(),
                              )));
                  if (result != null && result) {
                    _provider.getNotifications();
                  }
                },
                child: Icon(Icons.add))
            : null,
      ),
    );
  }

  Widget bodyContainer() =>
      Consumer<NotificationProvider>(builder: (context, value, child) {
        if (value.notifications.isNotEmpty) {
          return _listBuilder(value.notifications);
        } else if (value.status == STATUS.LOADING) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      });

  Widget _listBuilder(List<NotificationEntity> notifications) =>
      ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 21.h),
        itemBuilder: (_, index) => _itemBuilder(
          title: notifications[index].title,
          desc: notifications[index].description,
          onTap: () async {
            final _doc = await PDFDocument.fromURL(notifications[index].link);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PdfViewerScreen(pdf: _doc)));
          },
        ),
        separatorBuilder: (_, __) => SizedBox(height: 10.h),
        itemCount: notifications.length,
      );

  Widget _itemBuilder({
    required String title,
    required String desc,
    required Function() onTap,
  }) =>
      InkWell(
        onTap: onTap,
        child: Container(
          // height: 94.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Colors.white,
            // color: Color(0xffFFF2E4),
            // boxShadow: kElevationToShadow[1]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    desc,
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                ],
              ),
              //icon
              IconButton(
                onPressed: onTap,
                icon: Icon(Icons.download, color: Colors.green),
              ),
            ],
          ),
        ),
      );
}
