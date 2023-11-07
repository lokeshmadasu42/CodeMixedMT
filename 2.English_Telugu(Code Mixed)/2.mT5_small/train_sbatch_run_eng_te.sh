#!/bin/bash
#SBATCH -A research 
#SBATCH -c 30
#SBATCH --gres gpu:3
#SBATCH --mem-per-cpu 2G
#SBATCH --time 1-00:00:00
#SBATCH --output cmt_eng_tel_mt5.logs
#SBATCH --mail-user lokesh.madasu@research.iiit.ac.in
#SBATCH --mail-type ALL
#SBATCH --job-name CMT_mt5_TRAIN_Eng_Tel

module load u18/cuda/10.2

source /home2/lokesh.madasu/miniconda3/etc/profile.d/conda.sh

conda deactivate
echo "conda activate cmt"
conda activate cmt
echo "cmt environment activated"

echo "available cuda devices: "
echo "$CUDA_VISIBLE_DEVICES"

echo "exporting cuda device order"
export CUDA_DEVICE_ORDER="PCI_BUS_ID"

echo "exporting cuda devices numbers"
export CUDA_VISIBLE_DEVICES="0,1,2"

echo "training"
python3 run_translation.py \
    --model_name_or_path best_checkpoint/checkpoint-54175 \
    --do_train False \
    --do_eval False \
    --do_predict True \
    --source_lang en \
    --target_lang te \
    --source_prefix "translate English to Telugu: " \
    --train_file train_en_te.json \
    --validation_file dev_en_te.json \
    --test_file test_en_te.json \
    --output_dir ./cmt_mt5_output \
    --per_device_train_batch_size=2 \
    --per_device_eval_batch_size=2 \
    --overwrite_output_dir \
    --num_train_epochs 25 \
    --logging_strategy "epoch" \
    --save_strategy "epoch" \
    --evaluation_strategy "epoch" \
    --predict_with_generate $@ 2>&1>./mtmodel_log_eng_tel_mt5.txt

#echo "Copying files from scratch to share1"
scp -r /scratch/lokesh.madasu/cmt_mt5_output lokesh.madasu@ada.iiit.ac.in:../../share1/lokesh.madasu/cmt_mt5_output_eng_tel
#echo "Model output files copied to share1 Successfully".

#rm -r /scratch/gopichand_iiith/cmt_indicBART_output
#echo "Files deleted in scratch"
echo "deactivate cmt"
conda deactivate
