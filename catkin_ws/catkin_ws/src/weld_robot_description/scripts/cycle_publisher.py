#!/usr/bin/env python3
import rospy, numpy as np
from sensor_msgs.msg import JointState

def main():
    rospy.init_node('cycle_publisher')
    pub = rospy.Publisher('/welding_cycle', JointState, queue_size=1)
    rate = rospy.Rate(10)        # 10 Hz
    while not rospy.is_shutdown():
        js = JointState()
        js.header.stamp = rospy.Time.now()
        js.name = ['cycle']
        t = rospy.get_time()
        V =  20 + 5*np.sin(np.linspace(0, 6.28, 200) + t)
        I = 150 + 20*np.cos(np.linspace(0, 6.28, 200) + t)
        js.position = np.concatenate([V, I]).tolist()  # 400 floats
        pub.publish(js)
        rate.sleep()

if __name__ == '__main__':
    main()
