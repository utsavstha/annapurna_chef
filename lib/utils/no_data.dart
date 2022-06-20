import 'package:annapurna_chef/constants/colors.dart';
import 'package:flutter/material.dart';

/// This component is used when the List<Data> for transactions is empty to notify
/// the user that there is no data
class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.hourglass_empty_outlined,
            size: 20,
            color: colorLightBlue,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'No records found.',
          ),
        ],
      ),
    );
  }
}
