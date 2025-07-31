# SRDT
The code and data of JGR.Solid Earth
📄 Paper Title: "Latent Diffusion Transformer for Cross-Regional Seismic Data Reconstruction under Varying Degradation Conditions"
This repository contains the code, data, and results related to our paper "Latent Diffusion Transformer for Cross-Regional Seismic Data Reconstruction under Varying Degradation Conditions". All materials are provided to facilitate reproducibility and further research based on our work.

🧠 Introduction
In this paper, we propose we propose the Seismic Restore Diffusion Transformer (SRDT), a novel model that integrates a U-shaped Transformer architecture within a latent diffusion framework. SRDT operates in a compact latent space and progressively refines seismic data, effectively eliminating various forms of degradation. By leveraging the scale law of Transformers, SRDT scales effectively with model size and demonstrates strong adaptability across different geological scenarios. Furthermore, the progressive inference process inherent in diffusion models enhances interpretability.
This repository provides the full implementation of the proposed method, along with data and scripts to reproduce the experiments and figures presented in the paper.

📁 Repository Structure
├── data/               # Raw or preprocessed datasets
├── scripts/            # Core algorithms and training/inference scripts
├── results/            # Output results, visualizations, or evaluation metrics
├── requirements.txt    # Python dependencies
├── README.md           # Project documentation (this file)

🚀 Getting Started
1. Clone the repository
bash
git clone https://github.com/WYJLCYWHZ/SRDT.git
cd SRDT

2. Create environment and install dependencies
bash
pip install -r requirements.txt

3. Run the main script

📊 Reproducing Results
To reproduce the results in the paper, please refer to the instructions in scripts/ and the evaluation steps provided in the results/ folder.


📬 Contact
For questions or collaborations, feel free to contact:
Email: wanghongzhou@jlu.edu.cn
