# CMake generated Testfile for 
# Source directory: /home/waqas/rosbridge_ws/src/rosbridge_suite/rosbridge_server
# Build directory: /home/waqas/rosbridge_ws/build/rosbridge_server
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_rosbridge_server_rostest_test_websocket_test_smoke.test "/home/waqas/rosbridge_ws/build/rosbridge_server/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/waqas/rosbridge_ws/build/rosbridge_server/test_results/rosbridge_server/rostest-test_websocket_test_smoke.xml" "--return-code" "/usr/bin/python3 /opt/ros/noetic/share/rostest/cmake/../../../bin/rostest --pkgdir=/home/waqas/rosbridge_ws/src/rosbridge_suite/rosbridge_server --package=rosbridge_server --results-filename test_websocket_test_smoke.xml --results-base-dir \"/home/waqas/rosbridge_ws/build/rosbridge_server/test_results\" /home/waqas/rosbridge_ws/src/rosbridge_suite/rosbridge_server/test/websocket/test_smoke.test ")
set_tests_properties(_ctest_rosbridge_server_rostest_test_websocket_test_smoke.test PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/rostest/cmake/rostest-extras.cmake;52;catkin_run_tests_target;/home/waqas/rosbridge_ws/src/rosbridge_suite/rosbridge_server/CMakeLists.txt;29;add_rostest;/home/waqas/rosbridge_ws/src/rosbridge_suite/rosbridge_server/CMakeLists.txt;0;")
subdirs("gtest")
