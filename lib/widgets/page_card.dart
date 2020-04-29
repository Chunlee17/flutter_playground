import 'package:flutter/material.dart';
import 'package:flutter_playground/models/page_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class PageCard extends StatelessWidget {
  final PageModel page;

  const PageCard({Key key, this.page}) : super(key: key);

  void onViewPage(context) {
    if (page.shouldHaveTransition) {
      Navigator.of(context).push(
        PageRouteBuilder(
          opaque: false,
          pageBuilder: (context, animation, secondaryAnimation) => page.page,
          transitionDuration: Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, _, child) {
            var offset = Tween<Offset>(
              begin: Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              child: child,
              position: offset,
            );
          },
        ),
      );
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => page.page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onViewPage(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (page.image == null)
                CircleAvatar(
                    child: Icon(FontAwesomeIcons.mobileAlt),
                    backgroundColor: Colors.white)
              else
                Hero(
                  tag: "Image",
                  child:
                      CircleAvatar(backgroundImage: NetworkImage(page.image)),
                ),
              UIHelper.verticalSpace(16),
              Text(
                page.toString(),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
