import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlcc/providers/feedback_provider.dart';
import 'package:vlcc/resources/assets_path.dart';
import 'package:vlcc/widgets/custom_shimmers.dart';
import 'package:vlcc/widgets/dashboard_widgets/dashboard_widgets.dart';

class DashboardSlider extends StatefulWidget {
  const DashboardSlider({Key? key}) : super(key: key);

  @override
  State<DashboardSlider> createState() => _DashboardSliderState();
}

class _DashboardSliderState extends State<DashboardSlider> {
  final CarouselController _controller = CarouselController();

  final FeedbackProvider _feedbackProvider = FeedbackProvider();

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    final dashboard = context.watch<DashboardProvider>();
    final List<String> imgList = List.generate(
        _feedbackProvider.bannerList.length > 4
            ? 4
            : _feedbackProvider.bannerList.length, (index) {
      String img = _feedbackProvider.bannerList[index].img;
      return img;
    });
    final List<String> imgUrl = List.generate(
        _feedbackProvider.bannerList.length > 4
            ? 4
            : _feedbackProvider.bannerList.length, (index) {
      String imgUrl = _feedbackProvider.bannerList[index].url;
      return imgUrl;
    });
    final slides = context.watch<DashboardProvider>();
    final List<Widget> imageSliders = imgList
        .map(
          (item) => FadeInImage.assetNetwork(
              placeholder: JPGAsset.banner,
              image: item,
              imageErrorBuilder: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width),
        )
        .toList();

    return dashboard.bannerApiHit
        ? Stack(
            children: [
              GestureDetector(
                onTap: () {
                  _launchURL(imgUrl[slides.getSliderIndex]);
                },
                child: CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 240,
                    viewportFraction: 1,
                    autoPlay: true,
                    // aspectRatio: 4 / 3,
                    enlargeCenterPage: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.scale,
                    onPageChanged: (index, reason) {
                      slides.updateSliderIndex(index);
                    },
                  ),
                ),
              ),
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: slides.getSliderIndex == entry.key ? 14.0 : 10,
                        height: slides.getSliderIndex == entry.key ? 14.0 : 10,
                        margin: EdgeInsets.only(left: 8.0, bottom: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.white)
                                .withOpacity(slides.getSliderIndex == entry.key
                                    ? 1
                                    : 0.6)),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          )
        : CustomShimmer(
            shimmers: ShimmerType.singleShimmer,
          );
  }
}
