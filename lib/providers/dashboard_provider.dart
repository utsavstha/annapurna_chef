import 'package:annapurna_chef/controller/dashboard_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dashboardNotifierProvider =
    ChangeNotifierProvider.autoDispose<DashboardController>(
        (ref) => DashboardController());
