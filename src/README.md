# SRDT
The code of the manuscript to JGR.Solid Earth (AGU journal submission 2025JB032636)  


📄 Paper Title: "Latent Diffusion Transformer for Cross-Regional Seismic Data Reconstruction under Varying Degradation Conditions"  



🚀 Getting Started  
1. Clone the repository  
  
git clone https://github.com/WYJLCYWHZ/SRDT.git  
cd SRDT  

2. Create environment and install dependencies  
  
pip install -r requirements.txt  
  
3. Run the main script  
  
cd src/config/unet-latent
python train.py -opt=options/train/train_restore.yml

cd src/config/latent-seismic-restore
python train.py -opt=options/train/nasde.yml

cd src/config/latent-seismic-restore
python test.py -opt=options/test/nasde.yml


📬 Contact  
For questions or collaborations, feel free to contact:  
Email: wanghongzhou@jlu.edu.cn  
