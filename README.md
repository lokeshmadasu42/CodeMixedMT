# CodeMixed Machine Translation

This repostiory contains the code implementation of paper titled["**CoMeT: Towards Code-Mixed Translation Using Parallel Monolingual**"](https://aclanthology.org/2021.calcs-1.7.pdf) published in CALCS workshop-2021.


## Overview

Code-mixing is using words from two or more languages in the same conversation. In this project we attempt to build a machine translation system that translates the English sentence into codemixed language Hinglish (combination of words from Hindi and English).

## Dataset

We use the CALCS Shared Task English-Hinglish dataset, which is referenced in the above research paper. The following tables contain the data statistics.

| Field                              | English | Hinglish |
|------------------------------------|---------|---------|
| Number of sentences in train data  | 8060    | 8060    |
| Number of sentences in dev data    | 942     | 942     |
| Number of sentences in test data   | 960     | 960     |
| Minimum no.of tokens              | 1       | 1       |
| Maximum no.of tokens              | 287     | 370     |
| Average no.of tokens              | 12.37   | 12.6    |

***Other statistics***

| Field                               | Value |
|-------------------------------------|-------|
| No.of Hindi tokens in target sentences    | 76364 |
| No.of English tokens in target sentences  | 24269 |
| No.of other tokens in target sentences   | 13730 |

## Models

1) We use the following variations of mBART:
   - ***mBART-en***: We fine-tune mBART on the train set, feeding the English sentences to the encoder and decoding Hinglish sentences. We use beam search with a beam size of 5 for decoding.
   - ***mBART-hien***: In this variant, along with the English sentence we pass the parallel Hindi translated input to the encoder and the model has to generate the Hinglish sentence.
   - In both the cases, we use beam search decoder with a beam size of 5 for decoding.
2) Additionally, we also fine-tuned mT5_small and IndicBART models:

***Hyper-parameters***:

| Field               | Value                  |
|---------------------|------------------------|
| Loss                | label_smoothed_cross_entropy |
| Optimizer           | adam                   |
| Learning rate       | 3e^-5                  |
| Dropout             | 0.3                    |
| Attention Dropout   | 0.1                    |
| Epochs              | 40                     |


