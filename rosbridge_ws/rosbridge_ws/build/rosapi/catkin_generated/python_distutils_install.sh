#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/waqas/rosbridge_ws/src/rosbridge_suite/rosapi"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/waqas/rosbridge_ws/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/waqas/rosbridge_ws/install/lib/python3/dist-packages:/home/waqas/rosbridge_ws/build/rosapi/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/waqas/rosbridge_ws/build/rosapi" \
    "/usr/bin/python3" \
    "/home/waqas/rosbridge_ws/src/rosbridge_suite/rosapi/setup.py" \
    egg_info --egg-base /home/waqas/rosbridge_ws/build/rosapi \
    build --build-base "/home/waqas/rosbridge_ws/build/rosapi" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/waqas/rosbridge_ws/install" --install-scripts="/home/waqas/rosbridge_ws/install/bin"
