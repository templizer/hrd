import 'package:cnattendance/provider/leaveprovider.dart';
import 'package:cnattendance/widget/radialDecorationBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ToggleLeaveTime extends StatelessWidget {
  @override
  Widget build(BuildContext context,[bool mounted = true]) {
    final provider = Provider.of<LeaveProvider>(context);

    void onToggleChanged() async {
      final detailResponse =
          await provider.getLeaveTypeDetail();

      if (!mounted) return;
      if (detailResponse.statusCode == 200) {
        if (detailResponse.data.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              padding: EdgeInsets.all(20), content: Text('No data found')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            padding: const EdgeInsets.all(20), content: Text(detailResponse.message)));
      }
    }

    return Container(
      decoration: RadialDecorationBox(),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ToggleSwitch(
          activeBgColor: const [Colors.white12],
          activeFgColor: Colors.white,
          inactiveFgColor: Colors.white,
          inactiveBgColor: Colors.transparent,
          minWidth: 100,
          minHeight: 45,
          initialLabelIndex: provider.selectedMonth == 0 ? 1 : 0,
          totalSwitches: 2,
          onToggle: (index) {
            if (index == 0) {
              DateTime now = DateTime.now();
              provider.setMonth(now.month);
              onToggleChanged();
            } else {
              provider.setMonth(0);
              onToggleChanged();
            }
          },
          labels: [translate('leave_screen.this_month'), translate('leave_screen.this_year')],
        ),
      ),
    );
  }
}
