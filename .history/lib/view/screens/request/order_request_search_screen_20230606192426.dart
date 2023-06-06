import 'dart:async';
import 'dart:developer';

import 'package:efood_multivendor_driver/controller/order_controller.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/view/base/custom_app_bar.dart';
import 'package:efood_multivendor_driver/view/base/custom_snackbar.dart';
import 'package:efood_multivendor_driver/view/base/custom_text_field.dart';
import 'package:efood_multivendor_driver/view/screens/request/widget/order_requset_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

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
        return Column(crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: 'search'.tr,
                      controller: _searchController,
                      focusNode: _searchNode,
                      inputType: TextInputType.number,
                      showTitle: false,
                    ),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  InkWell(
                    child: Icon(
                      Icons.search,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      if (_searchController.text.isNotEmpty) {
                        orderController.getSearchOrder(_searchController.text);
                      } else {
                        showCustomSnackBar('invalid_text'.tr);
                      }
                    },
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                  InkWell(
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                    onTap: () {
                      barcodeScanning(orderController);
                    },
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                ],
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
              orderController.searchOrderList != null &&
                      orderController.searchOrderList.isNotEmpty
                  ? ListView.builder(
                      itemCount: orderController.searchOrderList.length,
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return OrderRequestWidget(
                          orderModel: orderController.searchOrderList[index],
                          index: index,
                          onTap: widget.onTap,
                          isFromSearchOrderScreen: true,
                        );
                      },
                    )
                  : Center(child: Text('no_order_request_available'.tr)),
              if (orderController.isLoading)
                Center(child: CircularProgressIndicator())
            ]);

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

  //scan barcode asynchronously
  Future barcodeScanning(OrderController orderController) async {
    try {
      ScanResult barcode = await BarcodeScanner.scan();
      // showCustomSnackBar(barcode.rawContent);
      // setState(() => this.barcode = barcode);
      orderController.getSearchOrder(barcode.rawContent);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.cameraAccessDenied) {
        // setState(() {
        showCustomSnackBar('No camera permission!');
        // });
      } else {
        showCustomSnackBar('Unknown error: $e');
      }
    } on FormatException {
      showCustomSnackBar('Nothing captured.');
    } catch (e) {
      showCustomSnackBar('Unknown error: $e');
    }
  }
}
