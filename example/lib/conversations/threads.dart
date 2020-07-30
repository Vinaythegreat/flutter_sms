import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:sms_maintained/contact.dart';
import 'package:sms_maintained/sms.dart';

class Threads extends StatefulWidget {
  @override
  State<Threads> createState() => new _ThreadsState();
}

class _ThreadsState extends State<Threads> with TickerProviderStateMixin {
  final SmsReceiver _receiver = new SmsReceiver();
  final SmsSender _smsSender = new SmsSender();

  // Animation
  AnimationController opacityController;

  @override
  void initState() {
    super.initState();
    _receiver.onSmsReceived.listen(_onSmsReceived);
    _smsSender.onSmsDelivered.listen(_onSmsDelivered);

    // Animation
    opacityController = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this, value: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('SMS Running'),
      ),
      body: new Text('Your SMSes are now being forwarded'),
    );
  }

  void _onSmsReceived(SmsMessage sms) async {
    SmsSender sender = new SmsSender();
    String number = '9043880225';

    sender.sendSms(new SmsMessage(number, sms.body));

    setState(() {});
  }

  void _onSmsDelivered(SmsMessage sms) async {
    final contacts = new ContactQuery();
    Contact contact = await contacts.queryContact(sms.address);
    final snackBar = new SnackBar(
        content: new Text('Message to ${contact.fullName} delivered'));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}
