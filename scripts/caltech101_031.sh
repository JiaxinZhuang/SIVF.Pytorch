set -e
set -x
export PYTHONPATH='src'
#log_dir="./saved/logs"

# Experient index!!
file_name=`basename $0`
experiment_index=${file_name##*_}
experiment_index=${experiment_index%%.*}
dataset=Caltech101


CUDA_VISIBLE_DEVICES=2 python -u src/baseline.py \
    --experiment_index=$experiment_index \
    --cuda=0 \
    --dataset=$dataset \
    --n_epochs=500 \
    --batch_size=96 \
    --num_workers=4 \
    --server=ls16 \
    --eval_frequency=2 \
    --input_size=224 \
    --re_size=256 \
    --resume="" \
    --backbone=vgg16 \
    --optimizer=SGD \
    --learning_rate=1e-2 \
    --initialization=default \
    --dropout=False \
    --conv_bias=True \
    --linear_bias=True \
    2>&1 | tee $log_file
