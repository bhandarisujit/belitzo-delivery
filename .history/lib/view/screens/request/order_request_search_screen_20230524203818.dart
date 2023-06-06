import 'dart:async';

import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_text_field.dart';
import 'package:efood_multivendor_driver/view/screens/request/widget/order_requset_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRequestSearchScreen extends StatefulWidget {
  final Function onTap;
  OrderRequestSearchScreen({@required this.onTap});

  @override
  _OrderRequestSearchScreenState createState() =>
      _OrderRequestSearchScreenState();
}

class _OrderRequestSearchScreenState extends State<OrderRequestSearchScreen> {
  // Timer _timer;
  final FocusNode _searchNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  initState() {
    super.initState();

    // Get.find<OrderController>().getLatestOrders();
    // _timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   Get.find<OrderController>().getLatestOrders();
    // });
  }

  @override
  void dispose() {
    super.dispose();

    // _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomAppBar(title: 'search_scan_order'.tr, isBackButtonExist: false),
      body: GetBuilder<OrderController>(builder: (orderController) {
        return CustomTextField(
          hintText: 'search'.tr,
          controller: _searchController,
          focusNode: _searchNode,
          inputType: TextInputType.number,
          showTitle: false,
          divider: true,
        );
        // SizedBox(height: Dimensions.PADDING_SIZE_LARGE);
        // return orderController.latestOrderList != null
        //     ? orderController.latestOrderList.length > 0
        //         ? RefreshIndicator(
        //             onRefresh: () async {
        //               await Get.find<OrderController>().getLatestOrders();
        //             },
        //             child: ListView.builder(
        //               itemCount: orderController.latestOrderList.length,
        //               padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        //               physics: AlwaysScrollableScrollPhysics(),
        //               itemBuilder: (context, index) {
        //                 return OrderRequestWidget(
        //                     orderModel: orderController.latestOrderList[index],
        //                     index: index,
        //                     onTap: widget.onTap);
        //               },
        //             ),
        //           )
        //         : Center(child: Text('no_order_request_available'.tr))
        //     : Center(child: CircularProgressIndicator());
      }),
    );
  }
}
