# CMake generated Testfile for 
# Source directory: /home/waqas/rosbridge_ws/src/rosauth
# Build directory: /home/waqas/rosbridge_ws/build_isolated/rosauth
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rosauth_rostest_test_ros_mac_authentication.test "/home/waqas/rosbridge_ws/build_isolated/rosauth/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/waqas/rosbridge_ws/build_isolated/rosauth/test_results/rosauth/rostest-test_ros_mac_authentication.xml" "--return-code" "/usr/bin/python3 /opt/ros/noetic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/waqas/rosbridge_ws/src/rosauth --package=rosauth --results-filename test_ros_mac_authentication.xml --results-base-dir \"/home/waqas/rosbridge_ws/build_isolated/rosauth/test_results\" /home/waqas/rosbridge_ws/src/rosauth/test/ros_mac_authentication.test ")
set_tests_properties(_ctest_rosauth_rostest_test_ros_mac_authentication.test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;52;catkin_run_tests_target;/home/waqas/rosbridge_ws/src/rosauth/CMakeLists.txt;74;add_rostest;/home/waqas/rosbridge_ws/src/rosauth/CMakeLists.txt;0;")
subdirs("gtest")
