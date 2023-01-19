#!/bin/bash
#SBATCH -A research 
#SBATCH -c 20
#SBATCH --gres gpu:4
#SBATCH --mem-per-cpu 2G
#SBATCH --time 2-00:00:00
#SBATCH --output joblogs/mt_v1.logs
#SBATCH --mail-user gopichand.kanumolu@research.iiit.ac.in
#SBATCH --mail-type ALL
#SBATCH --job-name MT_TRAIN

module load u18/cuda/10.2


# conda env create --file ./environment.yml
source /home2/gopichand_iiith/miniconda3/etc/profile.d/conda.sh


conda deactivate
conda activate cmtranslation2
echo 'activated environment'
# pip install sklearn
# pip install fairseq

export CUDA_DEVICE_ORDER="PCI_BUS_ID"
export CUDA_VISIBLE_DEVICES="0,1,2,3"

mkdir -p /scratch/gopichand_iiith/mt_data
echo "Folder created at /scratch/gopichand_iiith/mt_data/"

rm -r /scratch/gopichand_iiith/mt_output

echo "mBART Model file copying: from share1/gopichand_iiith to scratch/gopichand_iiith"
scp -r gopichand_iiith@ada.iiit.ac.in:../../share1/gopichand_iiith/Machine_Translation/mbart.cc25.v2.tar.gz /scratch/gopichand_iiith/mt_data/mbart.cc25.v2.tar.gz
echo "File copying done:"

echo "Input Data folder copying: from share1/gopichand_iiith to scratch/gopichand_iiith"
scp -r gopichand_iiith@ada.iiit.ac.in:../../share1/gopichand_iiith/Machine_Translation/data /scratch/gopichand_iiith/mt_data
echo "Data folder copying done:"

echo "Running train.sh file"
bash train.sh /scratch/gopichand_iiith/mt_data/mbart.cc25.v2.tar.gz /scratch/gopichand_iiith/mt_output /scratch/gopichand_iiith/mt_data/data mBARTen

echo "Evaluating"
bash eval.sh /scratch/gopichand_iiith/mt_output /scratch/gopichand_iiith/mt_data/data

echo "Scoring"
conda deactivate
conda activate indictrans
python3 calc_scores.py /scratch/gopichand_iiith/mt_output /scratch/gopichand_iiith/mt_data/data

