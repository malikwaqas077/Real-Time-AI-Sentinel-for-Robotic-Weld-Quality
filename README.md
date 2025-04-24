# AI-Powered Weld-Quality Sentinel  
*Real-time defect detection for robotic GMAW cells*

---

> **Electrical “heartbeat” of a 40 ms weld cycle – green = OK, red = defect**

---

## 1&nbsp;·&nbsp;Why this repo exists
Gateway Chassis Solutions and the University of Hull are planning a KTP project to deploy an autonomous robotic welding cell.  
This mini-project is **my skills demo**: it walks from raw data exploration through model benchmarking to edge-ready deployment.

*Highlights*

* **Data-science workflow**&nbsp; → EDA → baseline → deep model → explainability  
* **Edge feasibility**&nbsp; → < 2 ms inference, 2 MB model  
* ROS 2 package ready to drop into a production pipeline

---

## 2&nbsp;·&nbsp;Dataset

| Name | Details |
|------|---------|
| **ASIMoW Metal-Arc Welding Dataset**<br>(Zenodo [10.5281/zenodo.15101072](https://doi.org/10.5281/zenodo.15101072)) | • 130 301 labelled cycles<br>• 100 kHz raw → 200 × Voltage + 200 × Current per cycle<br>• Labels `0 = NOK`, `1 = OK`  (`-1 = unlabelled`, dropped here) |

> If you use this data, please cite **Hahn et al.**, *Procedia CIRP 120 (2023)*.

---

## 3&nbsp;·&nbsp;Repository structure
```text
weld-quality-sentinel/
├─ data/
│  └─ processed_asimow_dataset.csv   # download via script (not tracked)
├─ notebooks/
│  ├─ 01_EDA.ipynb                   # label balance & signal inspection
│  ├─ 02_Baseline_RF.ipynb           # Random-Forest pipeline (F1=0.84)
│  └─ 03_BiLSTM.ipynb                # tuned Bi-LSTM (F1≈0.93)
├─ src/
│  ├─ make_dataset.py                # fetch & clean CSV
│  ├─ train_rf.py                    # CLI RF training
│  ├─ train_lstm.py                  # CLI PyTorch training
│  ├─ export_onnx.py                 # convert → ONNX + benchmark
│  └─ ros2_sentinel_node/            # ROS2 package: /quality_flag topic
├─ docs/
│  └─ figs/                          # heartbeat & SHAP images
├─ requirements.txt
└─ README.md


└─ README.md
```

## 4&nbsp;·&nbsp;Quick Start


> **Prerequisites**  
> Python ≥ 3.9, Git, and ideally a CUDA-capable GPU for faster training (CPU works too).

```bash
git clone https://github.com/<your-user>/weld-quality-sentinel.git
cd weld-quality-sentinel
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# 1) download & pre-process data  (~1.3 GB)
python src/make_dataset.py --out data/processed.csv

# 2) train the Bi-LSTM (≈10 min on GPU, 45 min on CPU)
python src/train_lstm.py --csv data/processed.csv --epochs 30

# 3) export to ONNX for edge deployment
python src/export_onnx.py \
        --ckpt outputs/bilstm_best.pth \
        --out  models/weld_sentinel.onnx

# 4) benchmark latency
python src/export_onnx.py --benchmark models/weld_sentinel.onnx



