---
language:
- en
- hi
license: apache-2.0
tags:
- generated_from_trainer
metrics:
- bleu
model-index:
- name: cmt_translation_output
  results: []
---

<!-- This model card has been generated automatically according to the information the Trainer had access to. You
should probably proofread and complete it, then remove this comment. -->

# cmt_translation_output

This model is a fine-tuned version of [google/mt5-small](https://huggingface.co/google/mt5-small) on an unknown dataset.
It achieves the following results on the evaluation set:
- Loss: 1.8673
- Bleu: 13.0
- Gen Len: 22.6868

## Model description

More information needed

## Intended uses & limitations

More information needed

## Training and evaluation data

More information needed

## Training procedure

### Training hyperparameters

The following hyperparameters were used during training:
- learning_rate: 5e-05
- train_batch_size: 12
- eval_batch_size: 12
- seed: 42
- optimizer: Adam with betas=(0.9,0.999) and epsilon=1e-08
- lr_scheduler_type: linear
- num_epochs: 25.0

### Training results

| Training Loss | Epoch | Step  | Validation Loss | Bleu   | Gen Len |
|:-------------:|:-----:|:-----:|:---------------:|:------:|:-------:|
| 8.4365        | 1.0   | 672   | 2.8274          | 1.0841 | 12.3206 |
| 3.5569        | 2.0   | 1344  | 2.4313          | 3.0222 | 14.0287 |
| 3.1145        | 3.0   | 2016  | 2.2640          | 4.9751 | 14.1476 |
| 2.8747        | 4.0   | 2688  | 2.1609          | 5.6486 | 14.5085 |
| 2.7098        | 5.0   | 3360  | 2.1063          | 6.9396 | 14.6762 |
| 2.5971        | 6.0   | 4032  | 2.0588          | 7.0161 | 14.6879 |
| 2.5043        | 7.0   | 4704  | 2.0286          | 7.1937 | 14.7197 |
| 2.418         | 8.0   | 5376  | 1.9955          | 7.5163 | 14.7505 |
| 2.3613        | 9.0   | 6048  | 1.9767          | 7.7788 | 14.7983 |
| 2.3088        | 10.0  | 6720  | 1.9531          | 7.6362 | 14.7399 |
| 2.2598        | 11.0  | 7392  | 1.9330          | 7.8827 | 14.9225 |
| 2.2238        | 12.0  | 8064  | 1.9270          | 8.0731 | 14.8047 |
| 2.1989        | 13.0  | 8736  | 1.9116          | 8.2132 | 14.7558 |
| 2.1639        | 14.0  | 9408  | 1.9063          | 8.3475 | 14.81   |
| 2.1341        | 15.0  | 10080 | 1.9031          | 8.3378 | 14.7919 |
| 2.1125        | 16.0  | 10752 | 1.8862          | 8.375  | 14.897  |
| 2.0912        | 17.0  | 11424 | 1.8854          | 8.5035 | 14.8684 |
| 2.0691        | 18.0  | 12096 | 1.8794          | 8.7309 | 14.9172 |
| 2.0512        | 19.0  | 12768 | 1.8760          | 8.6077 | 14.8471 |
| 2.0478        | 20.0  | 13440 | 1.8726          | 8.8127 | 14.8779 |
| 2.0314        | 21.0  | 14112 | 1.8712          | 8.7489 | 14.9342 |
| 2.0299        | 22.0  | 14784 | 1.8700          | 8.6733 | 14.8949 |
| 2.015         | 23.0  | 15456 | 1.8688          | 8.9089 | 14.8599 |
| 2.0172        | 24.0  | 16128 | 1.8673          | 8.8592 | 14.8609 |
| 2.0177        | 25.0  | 16800 | 1.8673          | 8.9462 | 14.8737 |


### Framework versions

- Transformers 4.24.0
- Pytorch 1.13.0+cu117
- Datasets 2.6.1
- Tokenizers 0.13.2
