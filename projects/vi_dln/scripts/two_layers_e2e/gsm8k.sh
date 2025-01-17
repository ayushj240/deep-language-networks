#!/bin/bash
set -x  # print commands to terminal

fwd_model_type="text-davinci-003"
bwd_model_type="text-davinci-003"
dataset="gsm8k"
loss_function="number_presence_loss"
output_scoring_function="accuracy"
max_train_size=300
max_dev_size=300
max_test_size=300
p_class_tpl="classify_forward:3.0"
iters=10
batch_size=10
num_p_samples=10
num_h_samples=5
bwd_temp=0.7
forward_use_classes=False
held_out_prompt_ranking=True
use_memory=2
tolerance=2
trust_factor=1.
q_prompt_tpl="q_action_prompt"
logp_penalty=1.
posterior_temp=1.
p_hidden_tpl="suffix_forward_tbs"
q_hidden_tpl="suffix_forward_tbs_y|suffix_forward_tbs"
fwd_max_tokens=256
bwd_max_tokens=512

dir=log/${fwd_model_type}_${bwd_model_type}/two_layers_e2e/${dataset}

for seed in 13 42 25; do
    python vi_main.py \
        --do_first_eval \
        --fwd_model_type ${fwd_model_type} \
        --bwd_model_type ${bwd_model_type} \
        --dataset ${dataset} \
        --loss_function ${loss_function} \
        --max_train_size ${max_train_size} \
        --max_dev_size ${max_dev_size} \
        --max_test_size ${max_test_size} \
        --p_class ${p_class_tpl} \
        --iters ${iters} \
        --batch_size ${batch_size} \
        --num_p_samples ${num_p_samples} \
        --num_h_samples ${num_h_samples} \
        --bwd_temp ${bwd_temp} \
        --forward_use_classes ${forward_use_classes} \
        --held_out_prompt_ranking ${held_out_prompt_ranking} \
        --out_dir ${dir} \
        --use_memory ${use_memory} \
        --tolerance ${tolerance} \
        --trust_factor ${trust_factor} \
        --q_prompt ${q_prompt_tpl} \
        --logp_penalty ${logp_penalty} \
        --posterior_temp ${posterior_temp} \
        --p_hidden ${p_hidden_tpl} \
        --q_hidden ${q_hidden_tpl} \
        --seed ${seed} \
        --fwd_max_tokens ${fwd_max_tokens} \
        --bwd_max_tokens ${bwd_max_tokens} \
        --output_scoring_function ${output_scoring_function}
done
