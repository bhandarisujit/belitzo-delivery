import 'package:efood_multivendor_driver/controller/auth_controller.dart';
import 'package:efood_multivendor_driver/helper/date_converter.dart';
import 'package:efood_multivendor_driver/util/dimensions.dart';
import 'package:efood_multivendor_driver/util/styles.dart';
import 'package:efood_multivendor_driver/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ShiftDialogue extends StatefulWidget {
  const ShiftDialogue({Key key}) : super(key: key);

  @override
  State<ShiftDialogue> createState() => _ShiftDialogueState();
}

class _ShiftDialogueState extends State<ShiftDialogue> {
  @override
  void initState() {
    super.initState();
    Get.find<AuthController>().initData();
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: GetBuilder<AuthController>(
          builder: (authController) {
            return SizedBox(
              width: 500, height: MediaQuery.of(context).size.height * 0.6,
              child: Column(children: [

                Container(
                  width: 500,
                  padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                  ),
                  child: Column(children: [
                    Text(
                      'select_shift'.tr,
                      style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                    SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  ]),
                ),

                Expanded(
                  child: authController.shifts != null ? authController.shifts.isNotEmpty
                    ? ListView.builder(
                      itemCount: authController.shifts.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                          child: ListTile(
                            onTap: (){
                              // orderController.setOrderCancelReason(orderController.orderCancelReasons[index].reason);
                              authController.setShiftId(authController.shifts[index].id);
                            },
                            title: Row(
                              children: [
                                Icon(authController.shifts[index].id == authController.shiftId ? Icons.radio_button_checked : Icons.radio_button_off, color: Theme.of(context).primaryColor, size: 18),
                                SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(authController.shifts[index].name, style: robotoMedium, maxLines: 1, overflow: TextOverflow.ellipsis),

                                    Text(
                                      DateConverter.onlyTimeShow(authController.shifts[index].startTime)
                                       + ' - '+ DateConverter.onlyTimeShow(authController.shifts[index].endTime),
                                      style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }) : Center(child: Text('no_reasons_available'.tr)) : Center(child: CircularProgressIndicator()),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.FONT_SIZE_DEFAULT, vertical: Dimensions.PADDING_SIZE_SMALL),
                  child: !authController.shiftLoading ? Row(children: [
                    Expanded(child: CustomButton(
                      buttonText: 'skip'.tr, backgroundColor: Theme.of(context).disabledColor, radius: 50,
                      onPressed: () {
                        authController.updateActiveStatus(isUpdate: true).then((success) {
                          if(success){
                            Get.back();
                            Future.delayed(Duration(seconds: 2), (){
                              Get.back();
                            });
                          }
                        });
                      },
                    )),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                    Expanded(child: CustomButton(
                      buttonText: 'submit'.tr,  radius: 50,
                      onPressed: (){
                        if(authController.shiftId != null ){
                          authController.updateActiveStatus(shiftId: authController.shiftId, isUpdate: true).then((success) {
                            if(success){
                              Get.back();
                              Future.delayed(Duration(seconds: 2), ()=> Get.back());
                            }
                          });
                        }else{
                          authController.updateActiveStatus(isUpdate: true).then((success) {
                            if(success){
                              Get.back();
                                Future.delayed(Duration(seconds: 2), (){
                                    Get.back();
                                });
                            }
                          });
                        }
                      },
                    )),
                  ]) : Center(child: CircularProgressIndicator()),
                ),
              ]),
            );
          }
      ),
    );
  }
}
