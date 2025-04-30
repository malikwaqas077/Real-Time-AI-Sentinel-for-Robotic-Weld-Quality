import time
import pandas as pd
import streamlit as st
import plotly.express as px
from roslibpy import Ros, Topic

st.set_page_config(page_title="Live Weld-Quality Dashboard", layout="wide")
st.title("🛠️ Real-Time Weld-Quality Monitor")

# Connect to ROSBridge
ros = Ros('localhost', 9090)
ros.run()

# Data buffers & subscription
buf_time, buf_quality = [], []
def callback(msg):
    buf_time.append(pd.Timestamp.utcnow())
    buf_quality.append(msg['data'])
Topic(ros, '/weld_quality', 'std_msgs/Float32').subscribe(callback)

# Sidebar controls & status
st.sidebar.title("⚙️ Controls")
threshold = st.sidebar.slider("Defect threshold", 0.0, 1.0, 0.5, 0.01)
status = st.sidebar.empty()
status.success("✅ Connected to ROSBridge")

# Main layout placeholders
col1, col2, col3 = st.columns(3)
# KPI placeholders (create once)
latest_kpi = col1.empty()
avg_kpi    = col2.empty()
min_kpi    = col3.empty()

plot_area  = st.empty()
hist_area  = st.empty()
table_area = st.empty()
csv_area   = st.empty()

# Live-update loop
while ros.is_connected:
    n = min(len(buf_time), len(buf_quality))
    if n > 0:
        df = pd.DataFrame({
            'time':    buf_time[-n:],
            'quality': buf_quality[-n:]
        })

        # Anomaly alert
        latest = df['quality'].iloc[-1]
        if latest < threshold:
            status.warning(f"⚠️ Quality {latest:.2f} < {threshold:.2f}")
        else:
            status.success(f"Quality {latest:.2f} ≥ {threshold:.2f}")

        # Latency metrics (ms)
        latencies = df['time'].diff().dt.total_seconds() * 1000
        avg_lat   = latencies.mean()
        min_lat   = latencies.min()

        # Update KPIs in-place
        latest_kpi.metric("Latest Quality",      f"{latest:.2f}")
        avg_kpi.metric   ("Avg Latency (ms)",    f"{avg_lat:.1f}")
        min_kpi.metric   ("Min Latency (ms)",    f"{min_lat:.1f}")

        # EMA smoothing
        df['ema'] = df['quality'].ewm(span=10).mean()

        # Line chart: raw vs EMA
        fig_line = px.line(
            df, x='time', y=['quality', 'ema'],
            labels={'time': 'Time', 'value':'Quality'},
            title='Weld Quality: Raw vs EMA (span=10)'
        )
        plot_area.plotly_chart(fig_line, use_container_width=True)

        # Histogram
        fig_hist = px.histogram(df, x='quality', nbins=20,
                                title='Quality Distribution')
        hist_area.plotly_chart(fig_hist, use_container_width=True)

        # Recent 10 welds table
        table_area.subheader("Last 10 Welds")
        table_area.dataframe(
            df[['time','quality']].tail(10).reset_index(drop=True),
            height=200
        )

        # CSV download
        csv_area.download_button(
            "⬇️ Download CSV",
            df.to_csv(index=False).encode(),
            file_name="weld_quality.csv",
            mime="text/csv",
            key=f"download_csv_{n}"
        )

    time.sleep(0.5)

# Disconnection handling
status.error("❌ ROSBridge disconnected")

