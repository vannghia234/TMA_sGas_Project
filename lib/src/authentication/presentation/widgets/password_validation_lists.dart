import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sgas/core/ui/resource/image_path.dart';
import 'package:sgas/core/ui/style/base_color.dart';
import 'package:sgas/core/ui/style/base_style.dart';
import 'package:sgas/src/authentication/presentation/page/change_password_page.dart';

class PasswordValidationLists extends StatefulWidget {
  const PasswordValidationLists({
    super.key,
    required this.lists,
  });
  final List<Map<String, String>> lists;

  @override
  State<PasswordValidationLists> createState() =>
      _PasswordValidationListsState();
}

class _PasswordValidationListsState extends State<PasswordValidationLists> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            widget.lists.length,
            (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        (widget.lists[index]["status"]! ==
                                ValidationStatus.inValid)
                            ? ImagePath.checkCircle
                            : ImagePath.fillCheckCircle,
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.lists[index]["title"]!,
                        style: BaseTextStyle.body2(
                            color: (widget.lists[index]["status"]! ==
                                    ValidationStatus.inValid)
                                ? BaseColor.textSecondaryColor
                                : BaseColor.textPrimaryColor),
                      )
                    ],
                  ),
                ))
      ],
    );
  }
}
