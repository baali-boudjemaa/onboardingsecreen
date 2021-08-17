import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StackedCardCarousel extends StatefulWidget {
  StackedCardCarousel({
    StackedCardCarouselType type = StackedCardCarouselType.cardsStack,
    double initialOffset = 40.0,
    double spaceBetweenItems = 400,
    bool applyTextScaleFactor = true,
    PageController pageController,
    OnPageChanged onPageChanged,
  })  :
        _type = type,
        _initialOffset = initialOffset,
        _spaceBetweenItems = spaceBetweenItems,
        _applyTextScaleFactor = applyTextScaleFactor,
        _pageController = pageController ?? _defaultPageController,
        _onPageChanged = onPageChanged;

  final StackedCardCarouselType _type;
  final double _initialOffset;
  final double _spaceBetweenItems;
  final bool _applyTextScaleFactor;
  final PageController _pageController;
  final OnPageChanged _onPageChanged;

  @override
  _StackedCardCarouselState createState() => _StackedCardCarouselState();
}

class _StackedCardCarouselState extends State<StackedCardCarousel> {
  double _pageValue = 0.0;
  SlidableController slidableController;


  List<_HomeItem> items = [];
  List<Widget> _itemss = [];
  @override
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    items = List.generate(
        20,
            (i) => _HomeItem(
          i,
          "assets/pluto-sign-up.png",
          'Tile n°$i',
          _getSubtitle(i),
          _getAvatarColor(i),
        ));
    _itemss = List.generate(items.length,
        (index) => _getSlidableWithLists(context, index, Axis.horizontal));

    super.initState();
  }

  static Color _getAvatarColor(int index) {
    switch (index % 4) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.indigoAccent;
      default:
        return null;
    }
  }

  static String _getSubtitle(int index) {
    switch (index % 4) {
      case 0:
        return 'SlidableBehindActionPane';
      case 1:
        return 'SlidableStrechActionPane';
      case 2:
        return 'SlidableScrollActionPane';
      case 3:
        return 'SlidableDrawerActionPane';
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text, int index) {
    setState(() {
      print("///////////////////////////${index}");
      items.removeAt(index);
      _itemss.removeAt(index);
      //_positionedCards.removeAt(index);
      _positionedCards[index]=null;
    });
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("item ${index} deleted")));
  setState(() {

  });
  }

  List<Widget> _positionedCards=[];
  Animation<double> _rotationAnimation;

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final _HomeItem item = items[index];
    //final int t = index;
    return Slidable(
      key: Key(item.title),
      controller: slidableController,
      direction: direction,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _showSnackBar(
              context,
              actionType == SlideActionType.primary
                  ? 'Dismiss Archive'
                  : 'Dimiss Delete',
              index);
        },
      ),
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.55,
      child: direction == Axis.horizontal
          ? Card(
              elevation: 4.0,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: <Widget>[
                    VerticalListItem(items[index]),
                    Container(
                      width: 250,
                      height: 250,
                      child: Image.asset("assets/pluto-done.png"),
                    ),
                  ])),
            )
          : Container(
              color: Colors.deepOrange,
              child: HorizontalListItem(items[index])),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () => _showSnackBar(context, 'Archive', index),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _showSnackBar(context, 'Delete', index),
        ),
      ],
    );
  }

  Color _fabColor = Colors.blue;

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {
    setState(() {
      _rotationAnimation = slideAnimation;
    });
  }

  void handleSlideIsOpenChanged(bool isOpen) {
    setState(() {
      _fabColor = isOpen ? Colors.green : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget._pageController.addListener(() {
      if (mounted) {
        setState(() {
          _pageValue = widget._pageController.page;
        });
      }
    });

    return ClickThroughStack(
      children: <Widget>[
        _stackedCards(context),
        PageView.builder(
          scrollDirection: Axis.vertical,
          controller: widget._pageController,
          itemCount: _itemss.length,
          onPageChanged: widget._onPageChanged,
          itemBuilder: (BuildContext context, int index) {
            return Container();
          },
        ),
      ],
    );
  }

  Widget _stackedCards(BuildContext context) {
    double textScaleFactor = 1.0;
    if (widget._applyTextScaleFactor) {
      final double mediaQueryFactor = MediaQuery.of(context).textScaleFactor;
      if (mediaQueryFactor > 1.0) {
        textScaleFactor = mediaQueryFactor;
      }
    }

   _positionedCards = _itemss.asMap().entries.map(
      (MapEntry<int, Widget> item) {
        double position = -widget._initialOffset;
        if (_pageValue < item.key) {
          position += (_pageValue - item.key) *
              widget._spaceBetweenItems *
              textScaleFactor;
        }
        switch (widget._type) {
          case StackedCardCarouselType.fadeOutStack:
            double opacity = 1.0;
            double scale = 1.0;
            if (item.key - _pageValue < 0) {
              final double factor = 1 + (item.key - _pageValue);
              opacity = factor < 0.0 ? 0.0 : pow(factor, 1.5).toDouble();
              scale = factor < 0.0 ? 0.0 : pow(factor, 0.1).toDouble();
            }
            return Positioned.fill(
              top: -position,
              child: Align(
                alignment: Alignment.topCenter,
                child: Wrap(
                  children: <Widget>[
                    Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity,
                        child: item.value,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case StackedCardCarouselType.cardsStack:
          default:
            double scale = 1.0;
            if (item.key - _pageValue < 0) {
              final double factor = 1 + (item.key - _pageValue);
              scale = 0.95 + (factor * 0.1 / 2);
            }
            return Positioned.fill(
              top: -position + (20.0 * item.key),
              child: Align(
                alignment: Alignment.topCenter,
                child: Wrap(
                  children: <Widget>[
                    Transform.scale(
                      scale: scale,
                      child: item.value,
                    ),
                  ],
                ),
              ),
            );
        }
      },
    ).toList();

    return Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: _positionedCards);
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);

  final _HomeItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);

  final _HomeItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
              ? Slidable.of(context)?.open()
              : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.color,
            child: Text('${item.index}'),
            foregroundColor: Colors.white,
          ),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }
}

/// To allow all gestures detections to go through
/// https://stackoverflow.com/questions/57466767/how-to-make-a-gesturedetector-capture-taps-inside-a-stack
class ClickThroughStack extends Stack {
  ClickThroughStack({List<Widget> children}) : super(children: children);

  @override
  ClickThroughRenderStack createRenderObject(BuildContext context) {
    return ClickThroughRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.of(context),
      fit: fit,
    );
  }
}

class ClickThroughRenderStack extends RenderStack {
  ClickThroughRenderStack({
    AlignmentGeometry alignment,
    TextDirection textDirection,
    StackFit fit,
  }) : super(
          alignment: alignment,
          textDirection: textDirection,
          fit: fit,
        );

  @override
  bool hitTestChildren(BoxHitTestResult result, {Offset position}) {
    bool stackHit = false;

    final List<RenderBox> children = getChildrenAsList();

    for (final RenderBox child in children) {
      final StackParentData childParentData =
          child.parentData as StackParentData;

      final bool childHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );

      if (childHit) {
        stackHit = true;
      }
    }

    return stackHit;
  }
}

final PageController _defaultPageController = PageController();

enum StackedCardCarouselType {
  cardsStack,
  fadeOutStack,
}

class _HomeItem {
  const _HomeItem(
    this.index,
    this.image,
    this.title,
    this.subtitle,
    this.color,
  );

  final String title;

  final int index;
  final String image;
  final String subtitle;
  final Color color;
}

typedef OnPageChanged = void Function(int pageIndex);
