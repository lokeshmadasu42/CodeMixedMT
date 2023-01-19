#!/bin/bash
#SBATCH -A research 
#SBATCH -c 30
#SBATCH --gres gpu:4
#SBATCH --mem-per-cpu 2G
#SBATCH --time 1-00:00:00
#SBATCH --output cmt_eng_tel.logs
#SBATCH --mail-user lokesh.madasu@research.iiit.ac.in
#SBATCH --mail-type ALL
#SBATCH --job-name CMT_IndicBART_TRAIN_Eng_Tel

module load u18/cuda/10.2

source /home2/gopichand_iiith/miniconda3/etc/profile.d/conda.sh

conda deactivate
echo "conda activate cmt"
conda activate cmt
echo "cmt environment activated"

echo "available cuda devices: "
echo "$CUDA_VISIBLE_DEVICES"

echo "exporting cuda device order"
export CUDA_DEVICE_ORDER="PCI_BUS_ID"

echo "exporting cuda devices numbers"
export CUDA_VISIBLE_DEVICES="0,1,2,3"

echo "training"
python3 run_translation.py \
    --model_name_or_path best_checkpoint/checkpoint-15120/ \
    --do_train False \
    --do_eval False \
    --do_predict True \
    --source_lang en \
    --target_lang hi \
    --source_prefix "translate English to Hindi: " \
    --train_file train_en_hi.json \
    --validation_file dev.json \
    --test_file test_en_hi.json \
    --output_dir ./cmt_indicBART_output \
    --per_device_train_batch_size=4 \
    --per_device_eval_batch_size=4 \
    --overwrite_output_dir \
    --num_train_epochs 30 \
    --logging_strategy "epoch" \
    --save_strategy "epoch" \
    --evaluation_strategy "epoch" \
    --predict_with_generate $@ 2>&1>./mtmodel_log_eng_hindi_testing.txt

#echo "Copying files from scratch to share1"
scp -r /scratch/gopichand_iiith/cmt_indicBART_output gopichand_iiith@ada.iiit.ac.in:../../share1/gopichand_iiith/cmt_indicBART_output_eng_tel
#echo "Model output files copied to share1 Successfully".

#rm -r /scratch/gopichand_iiith/cmt_indicBART_output
#echo "Files deleted in scratch"
echo "deactivate cmt"
conda deactivate
