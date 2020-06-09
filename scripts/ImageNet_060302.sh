set -e
set -x
export PYTHONPATH='src'
#log_dir="./saved/logs"

# Experient index!!
file_name=`basename $0`
experiment_index=${file_name##*_}
experiment_index=${experiment_index%%.*}
dataset=ImageNet
# -------------------------------
class_index=950
num_class=30
server=ls15
delta=0
eval_frequency=10000
# -------------------------------
# Variables
n_epochs=500000

cuda_visible_devices=1
selected_layer=3
selected_filter=20
alpha=1000
beta=1
gamma=100
guidedReLU=False
inter=True
seed=-1


CUDA_VISIBLE_DEVICES=$cuda_visible_devices python -u src/trainer.py \
    --experiment_index=$experiment_index \
    --server=$server \
    --cuda=0 \
    --dataset=$dataset \
    --n_epochs=$n_epochs \
    --eval_frequency=$eval_frequency \
    --re_size=224 \
    --backbone=vgg16 \
    --optimizer=SGD \
    --learning_rate=1e-1 \
    --alpha=$alpha \
    --gamma=$gamma \
    --beta=$beta \
    --delta=$delta \
    --selected_layer=$selected_layer \
    --selected_filter=$selected_filter \
    --resume=037-0 \
    --num_class=$num_class \
    --class_index=$class_index \
    --mode=keep \
    --rho=0 \
    --regularization=L1 \
    --smoothing=TotalVariation \
    --regular_ex=3 \
    --delta=$delta \
    --rescale=False \
    --guidedReLU $guidedReLU \
    --seed $seed\
    --inter $inter\
    2>&1 | tee $log_file
