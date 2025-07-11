import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/constants/assets.gen.dart';
import 'package:invo_app/features/common/widgets/big_header.dart';
import 'package:invo_app/features/common/widgets/invo_top_bar.dart';

import 'invo_material_backdrop_filter.dart';

class SliversTopCardPage extends HookWidget {
  const SliversTopCardPage({
    required this.onPopPage,
    required this.itemBuilder,
    required this.title,
    this.smallImage = false,
    super.key,
  });

  final VoidCallback onPopPage;
  final List<Widget> Function(BuildContext) itemBuilder;
  final bool smallImage;
  final String title;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final safeArea = useMemoized(() => MediaQuery.of(context).padding.top);

    final imageAspectRatio = useState(375 / 433);

    final topImage = Assets.images.icSandwitch.image(fit: BoxFit.fill);

    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: width / imageAspectRatio.value - safeArea - 10,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              expandedTitleScale: 1,
              titlePadding: EdgeInsets.zero,
              title: InvoMaterialBackgroundFilter(
                blur: 32,
                containerColor: context.colors.background.withValues(
                  alpha: 0.5,
                ),
                decoration: BoxDecoration(
                  color: context.colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 32,
                      color: context.colors.gradient1,
                      offset: const Offset(0, 0),
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                containerPadding: EdgeInsetsGeometry.only(
                  left: InvoSpaces.space12,
                  right: InvoSpaces.space12,
                  top: InvoSpaces.space24,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                containerHeight: 100,
                child: BigHeader(title),
              ),
              background: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(left: 0, right: 0, top: 0, child: topImage),
                  Builder(
                    builder: (context) {
                      return Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                context.colors.background,
                                context.colors.background,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: InvoTopBar(
                      onBackTap: () {
                        ///TODO(Artur): add handle
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...itemBuilder(context),
        ],
      ),
    );
  }
}
