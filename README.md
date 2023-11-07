# CodeMixed Machine Translation

This repository contains the code implementation of the paper titled ["CoMeT: Towards Code-Mixed Translation Using Parallel Monolingual"](https://aclanthology.org/2021.calcs-1.7.pdf), published in CALCS workshop 2021.

## Overview

Code-mixing involves using words from two or more languages in the same conversation. In this project, we aim to build a machine translation system that translates English sentences into Hinglish, which is a combination of words from Hindi and English.

## Dataset

We utilize the CALCS Shared Task English-Hinglish dataset, which is referenced in the above research paper. The following tables provide data statistics:

### English-Hinglish Dataset Statistics

| Field                              | English | Hinglish |
|------------------------------------|---------|---------|
| Number of sentences in train data  | 8060    | 8060    |
| Number of sentences in dev data    | 942     | 942     |
| Number of sentences in test data   | 960     | 960     |
| Minimum number of tokens           | 1       | 1       |
| Maximum number of tokens           | 287     | 370     |
| Average number of tokens           | 12.37   | 12.6    |

**Additional Statistics**

| Field                               | Value  |
|-------------------------------------|------- |
| No. of Hindi tokens in target sentences    | 76364  |
| No. of English tokens in target sentences  | 24269  |
| No. of other tokens in target sentences   | 13730  |

## Models and Results

We employ various models for translation and report the following results:

1. **mBART Variants**

   - ***mBART-en***: Fine-tuned on the train set, translating English to Hinglish.
   - ***mBART-hien***: Fine-tuned with parallel Hindi input for translating English to Hinglish.
   
   Both cases use beam search decoding with a beam size of 5.

2. **Other Models**

   - Fine-tuned **mT5-small** and **IndicBART** models.

### Fine-Tuning Examples

To fine-tune the models, you can use the following command:

```bash
python3 run_translation.py \
    --model_name_or_path google/mT5-small \
    --do_train True \
    --do_eval True \
    --do_predict True \
    --source_lang en \
    --target_lang hi \
    --source_prefix "translate English to Hindi: " \
    --train_file train_en_hi.json \
    --validation_file dev_en_hi.json \
    --test_file test_en_hi.json \
    --output_dir ./cmt_output \
    --per_device_train_batch_size=4 \
    --per_device_eval_batch_size=4 \
    --overwrite_output_dir \
    --num_train_epochs 40 \
    --logging_strategy "epoch" \
    --save_strategy "epoch" \
    --evaluation_strategy "epoch" \
    --predict_with_generate $@ 2>&1>./mtmodel_log_eng_hindi_testing.txt

```

**Hyper-parameters**:

| Field               | Value                  |
|---------------------|------------------------|
| Loss                | label_smoothed_cross_entropy |
| Optimizer           | adam                   |
| Learning rate       | 3e^-5                  |
| Dropout             | 0.3                    |
| Attention Dropout   | 0.1                    |
| Epochs              | 40                     |


**BLEU Scores**

The following tables contain the BLEU scores of various transformer models:

| Model       | BLEU Score | BLEU Normalized |
|-------------|------------|-----------------|
| mBART-en    | 14.3       | 17.7            |
| mBART-hien  | 14.5       | 19.7            |
| mT5-small   | 8.94       | -               |
| IndicBART   | 11.83      | -               |

