import 'package:artohmapp/widgets/custom_elevated_button.dart';
import 'package:artohmapp/widgets/custom_outlined_button.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import '../art_marketplace_screen/models/seller_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactSellerBottomSheet extends StatelessWidget {
  final Seller seller;

  ContactSellerBottomSheet({Key? key, required this.seller}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (!await canLaunch(url)) {
      throw Exception('Could not launch $url');
    }
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15.h,
          vertical: 13.v,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFFEE9E9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          border: Border.all(
            color: Color.fromRGBO(245, 140, 140, 0.075),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Contact ${seller.name}',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      leftIcon: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      text: 'Call',
                      onTap: () async {
                        final String phoneUrl = 'tel:${seller.phone}';
                        try {
                          await _launchUrl(phoneUrl);
                        } catch (e) {
                          print('Could not launch $phoneUrl');
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: CustomOutlinedButton(
                      leftIcon: Icon(Icons.email),
                      // text: '${seller.email}',
                      text: 'Send Email',
                      onTap: () async {
                        final Email email = Email(
                          body: 'Hello ${seller.name},',
                          subject: 'Interested in your artwork',
                          recipients: [seller.email],
                          isHTML: false,
                        );
                        try {
                          await FlutterEmailSender.send(email);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email sent!'),
                            ),
                          );
                        } catch (error) {
                          print('Could not send the email: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to send email.'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.0),
              // Add more seller contact details here
              CustomElevatedButton(
                buttonStyle: ElevatedButton.styleFrom(
                  backgroundColor: appTheme.lightBlueA700,
                ),
                text: 'Go Back',
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
