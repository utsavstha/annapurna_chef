import 'dart:async';

import 'package:annapurna_chef/constants/colors.dart';
import 'package:annapurna_chef/model/order_item.dart';
import 'package:annapurna_chef/providers/dashboard_provider.dart';
import 'package:annapurna_chef/utils/no_data.dart';
import 'package:annapurna_chef/utils/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      ref.read(dashboardNotifierProvider).getOrders();
    });
    Timer.periodic(const Duration(seconds: 5), (_) => _fetchData());
  }

  _fetchData() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    ref.read(dashboardNotifierProvider).pollOrders();
    // });
  }

  Widget _buildOrderDetailsList(String tableName, List<Items> items) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items[index].name,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text("${items[index].quantity}",
                        style: TextStyle(color: colorGreyText, fontSize: 18)),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        ref.watch(dashboardNotifierProvider).notify(
                            tableName,
                            items[index].quantity.toString(),
                            items[index].name,
                            items[index].id);
                      },
                      icon: const Icon(Icons.notifications_active_outlined),
                      color: items[index].isCooked == 1
                          ? Colors.green
                          : Colors.grey,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: colorSidebar,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.list,
                          color: Colors.green,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.history,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                final provider = ref.watch(dashboardNotifierProvider);
                if (provider.apiResponse.isLoading) {
                  return const ProgressDialog();
                }
                if (provider.apiResponse.model == null ||
                    (provider.apiResponse.model as List<OrderModel>) == null) {
                  return const NoData();
                } else {
                  final data = (provider.apiResponse.model as List<OrderModel>);
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: const Color(0xff40b5c4),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Text("${data.length}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30)),
                                Text("Active Orders",
                                    style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("Order Queue",
                            style:
                                TextStyle(color: colorGreyText, fontSize: 20)),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              var parsedDate = DateTime.parse(
                                  data[index].items[0].createdAt);
                              var dateNow = DateTime.now();
                              var sinceMins =
                                  dateNow.difference(parsedDate).inMinutes;
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            color: colorLightGrey,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(30.0),
                                              child: Center(
                                                child: Text(
                                                    data[index].tableName,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Text("ORDERED ITEMS",
                                                    style: TextStyle(
                                                        color: colorGreyText,
                                                        fontSize: 12)),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                    "${data[index].items.length}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18.0, top: 18),
                                      child: Text("Order Details",
                                          style: TextStyle(
                                              color: colorGreyText,
                                              fontSize: 15)),
                                    ),
                                    _buildOrderDetailsList(
                                        data[index].tableName,
                                        data[index].items)
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
