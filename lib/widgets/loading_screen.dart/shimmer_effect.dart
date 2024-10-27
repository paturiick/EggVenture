import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffect {
  Widget buildShimmerEffect(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.13,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              // Profile picture with icon overlay shimmer
              Stack(
                alignment: Alignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: screenWidth * 0.12,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(width: screenWidth * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User name shimmer
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.03,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Star rating shimmer
                  Row(
                    children: List.generate(5, (index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Icon(
                          Icons.star,
                          color: Colors.grey,
                          size: screenWidth * 0.05,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Followers and Following shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildShimmerStatus(
                          screenWidth * 0.1, screenHeight * 0.02),
                      SizedBox(width: screenWidth * 0.1),
                      buildShimmerStatus(
                          screenWidth * 0.1, screenHeight * 0.02),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),

          // Edit Profile and Share Profile buttons shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildShimmerButton(screenWidth * 0.35, screenHeight * 0.05),
              buildShimmerButton(screenWidth * 0.35, screenHeight * 0.05),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Divider(color: Colors.grey, thickness: 1),
          SizedBox(height: screenHeight * 0.02),

          // Icons for To Pay, Processing, Review with labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              return Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(
                      radius: screenWidth * 0.08,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildShimmerStatus(double width, double height) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildShimmerButton(double width, double height) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
