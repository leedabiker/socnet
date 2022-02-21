import 'package:flutter/widgets.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext content) {
    return Text('Activity Feed');
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}
