library flutter_package;
import 'package:flutter/material.dart';



/// Dialog box with different input parameters
class GenericDialog extends StatefulWidget {
  final ToolProperties toolProperties;
  final TitleProperties titleProperties;
  final HeaderProperties headerProperties;
  final BodyProperties bodyProperties;
  final FooterProperties footerProperties;

  ///constructor
  GenericDialog(
      {this.titleProperties,
        this.toolProperties,
        this.headerProperties,
        this.bodyProperties,
        this.footerProperties});
  @override
  _State createState() => new _State(
    titleProperties: this.titleProperties,
    toolProperties: this.toolProperties,
    headerProperties: this.headerProperties,
    bodyProperties: this.bodyProperties,
    footerProperties: this.footerProperties,
  );
}

class _State extends State<GenericDialog> {
  ToolProperties toolProperties;
  TitleProperties titleProperties;
  HeaderProperties headerProperties;
  BodyProperties bodyProperties;
  FooterProperties footerProperties;

  Widget toolWidget;
  Widget headerWidget;
  Widget bodyWidget;
  Widget titleWidget;
  Widget footerWidget;

  /// constructor
  _State(
      {this.titleProperties,
        this.toolProperties,
        this.headerProperties,
        this.bodyProperties,
        this.footerProperties});

  /// Check whether all inputs parameters are valid or not
  checkPropertiesValidOrNot() {
    checkToolProperties();
    checkTitleProperties();
    checkHeaderProperties();
    checkBodyProperties();
    checkFooterProperties();
  }

  ///This checks title properties otherwise returns null container
  checkTitleProperties() {
    this.titleWidget = new Container();
    if (this.titleProperties != null &&
        this.titleProperties.container is Widget) {
      this.titleWidget = this.titleProperties.container;
    } else if (this.titleProperties != null) {}
  }


  ///This checks tool properties
  checkToolProperties() {
    this.toolWidget = new Container();
    if (this.toolProperties != null &&
        this.toolProperties.container is Widget) {
      this.toolWidget = this.toolProperties.container;
    } else if (this.toolProperties != null &&
        this.toolProperties.iconData != null) {
      this.toolWidget = new Container();
    } else {
//      this.toolWidget = IconButton(
//        padding: new EdgeInsets.all(0.0),
//        color: Colors.black,
//        icon: Icon(Icons.close, size: 20.0),
//        onPressed: () {
//          // Closing the alert window of on click of close button on top right corner
//          Navigator.of(context).pop();
//        },
//      );
    }
  }


  ///Checks the header properties, which is title of dialog box
  checkHeaderProperties() {
    this.headerWidget = new Container();
    if (this.headerProperties != null &&
        this.headerProperties.container is Widget) {
      this.headerWidget = this.headerProperties.container;
    } else if (this.headerProperties != null &&
        this.headerProperties.headerText != null) {
      var textStyles;
      if (this.headerProperties.headerStyle != null &&
          this.headerProperties.headerStyle is TextStyle) {
        textStyles = this.headerProperties.headerStyle;
      } else {
        textStyles = TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0);
      }
      this.headerWidget = new Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text(
            this.headerProperties.headerText,
            style: textStyles,
          ));
    }
  }


  /// checks the body properties, which is the body of the dialog box
  checkBodyProperties() {
    this.bodyWidget = new Container();
    if (this.bodyProperties != null &&
        this.bodyProperties.container is Widget) {
    } else if (this.bodyProperties != null &&
        this.bodyProperties.dataList != null) {
      if (this.bodyProperties.dataList != null &&
          this.bodyProperties.dataList.length > 0) {
        List<Widget> data = [];
        for (int i = 0; i < this.bodyProperties.dataList.length; i++) {
          var contentLine = this.bodyProperties.dataList[i];
          if (contentLine.text != null) {
            EdgeInsets padding = contentLine.padding != null
                ? contentLine.padding
                : EdgeInsets.only(top: 10.0, bottom: 0.0);
            TextStyle textStyle =
            new TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w400);

            if (contentLine.textStyle == null) {
              contentLine.textStyle = textStyle;
            }

            data.add(new Padding(
              padding: padding,
              child: Text(contentLine.text, style: contentLine.textStyle),
            ));
          }

          this.bodyWidget = new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: data,
          );
        }
      }
    }
  }


  /// Checks for footer properties, which holds the buttons
  checkFooterProperties() {
    this.footerWidget = new Container();
    if (this.footerProperties != null &&
        this.footerProperties.container is Widget) {
      this.footerWidget = this.footerProperties.container;
    } else if (this.footerProperties != null &&
        this.footerProperties.buttonList != null &&
        this.footerProperties.buttonList.length > 0) {
      var list = this.footerProperties.buttonList;
      List<Widget> buttonList = [];
      for (int i = 0; i < list.length; i++) {
        if (list[i].buttonText != null) {
          var btn = list[i];
          buttonList.add(SizedBox(child : Material(
            elevation: 5.0,
            // borderRadius: BorderRadius.circular(30.0),
            color: btn.color,
            shape: Border.all(width: 1.0, color: Colors.black),
            child: MaterialButton(
              key: btn.key,
              padding: btn.padding,
              child: Text(
                btn.buttonText,
              ),
              onPressed: (){
                btn.handler();
              },
              minWidth: btn.buttonWidth ?? 50,
              textColor: btn.textColor,
            ),
          ),
            width: btn.buttonWidth,
          ));
        }
      }
      this.footerWidget = new Container(padding: this.footerProperties.padding,
        width: MediaQuery.of(context).size.width * 0.45,
        child : Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: buttonList,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    checkPropertiesValidOrNot();
    return new Dialog(
      child: new Container(
        width: MediaQuery.of(context).size.width * 0.60,
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        // height: MediaQuery.of(context).size.width * 0.5,
        // width: 50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: this.titleWidget,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: this.toolWidget,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Center(child: this.headerWidget),
            ),
            Container(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: new Center(child: this.bodyWidget),
            ),
            this.footerWidget,
//            Padding(
//                child: this.footerWidget
//            ),
          ],
        ),
      ),
    );
  }
}

class ToolProperties {
  Widget container;
  List<ToolList> iconData;

  ToolProperties({this.container, this.iconData});
}

class ToolList {
  Widget tool;
  String iconPath;

  ToolList({this.tool, this.iconPath});
}

class HeaderProperties {
  String headerText;
  TextStyle headerStyle;
  Widget container;

  HeaderProperties({this.headerText, this.headerStyle, this.container});
}

class TitleProperties {
  String titleText;
  TextStyle titleStyle;
  Widget container;
  TitleProperties({this.titleText, this.titleStyle, this.container});
}

class BodyProperties {
  Widget container;
  List<ContentLine> dataList;
  TextStyle textStyle;

  double minHeight;
  double maxHeight;
  double minWidth;
  double maxWidth;

  BodyProperties(
      {this.container,
        this.dataList,
        this.textStyle,
        this.maxHeight,
        this.minHeight,
        this.maxWidth,
        this.minWidth});
}

class ContentLine {
  String text;
  TextStyle textStyle = new TextStyle(color: Colors.red);
  EdgeInsets padding;
  ContentLine({this.text, this.textStyle, this.padding});
}

class FooterProperties {
  Widget container;
  List<FooterButton> buttonList;
  EdgeInsets padding;
  FooterProperties({this.container, this.buttonList, this.padding = const EdgeInsets.only(top: 20.0, bottom: 20.0)});
}

class FooterButton {
  EdgeInsets padding;
  Color color;
  String buttonText;
  Alignment alignment;
  Color textColor;
  Function handler;
  double buttonWidth;
  Key key;
  FooterButton(
      {this.padding = const EdgeInsets.only(left: 40.0, right: 40.0),
        @required this.buttonText,
        this.alignment,
        this.color = Colors.black,
        this.textColor = Colors.white,
        this.buttonWidth,
        this.key,
        @required this.handler});
}

