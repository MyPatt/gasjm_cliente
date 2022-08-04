import 'package:flutter/material.dart';
import 'package:gasjm/app/core/theme/app_theme.dart';


class ContentTitle extends StatelessWidget {
  ContentTitle({
    required this.title,
    required this.more,
  });
  final String title;
  final String more;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              more,
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: AppTheme.blueDark, fontWeight: FontWeight.w700),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.blueDark,
              size: 14.0,
            )
          ],
        ),
      ),
    );
  }
}
