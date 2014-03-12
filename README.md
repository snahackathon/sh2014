# SNA Hackathon 2014 helper code

This project contains the code that builds baseline model for SNA Hackathon
online challenge [http://sh2014.org](http://sh2014.org).

There are 3 scripts in R provided:

* `prepare.R` - Pre-processes content data and counts likes by post.
* `features.R` - Extracts basic text features.
* `baseline.R` - Builds baseline model.

## Instruction

Extract source data files into `./data/src/`. There must be 3 files provided:

* `test_content.csv`
* `train_content.csv`
* `train_likes.csv`

The details on where to find source data might be found [here](http://sh2014.org/task/)

To build baseline model, run in command line:

    git clone https://github.com/snahackathon/sh2014.git
    cd ./sh2014/R
    R --vanilla < prepare.R
    R --vanilla < features.R
    R --vanilla < baseline.R

Baseline model ready for submission will be stored in `data/submit` directory.

Good luck!