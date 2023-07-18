set -x  # print commands to terminal
dataset=medus
data_path=../../data/medus
p_class_tpl="classify_forward:3.0"
iters=20
batch_size=10
num_p_samples=10
bwd_temp=0.7
held_out_prompt_ranking=True
use_memory=2
tolerance=2
num_h_samples=5
q_prompt_tpl="q_action_prompt:v3.5"
logp_penalty=0.
posterior_temp=1.
trust_factor=5.
p_hidden_tpl="suffix_forward_tbs"
q_hidden_tpl="suffix_forward_tbs_y|suffix_forward_tbs"
scoring_function="accuracy"
hidden_scoring_function="tfidf"
model_type="text-davinci-003"


dir=log/med_two_layers/${dataset}
/bin/rm -rf ${dir}


for seed in 13; do
    python vi_main.py \
        --init_p1 "" \
        --init_p2 "Answer the following medical question." \
        --balance_batch \
        --num_p_samples ${num_p_samples} \
        --num_h_samples ${num_h_samples} \
        --bwd_temp ${bwd_temp} \
        --iters ${iters} \
        --p_hidden ${p_hidden_tpl} \
        --q_hidden ${q_hidden_tpl} \
        --q_prompt ${q_prompt_tpl} \
        --p_class ${p_class_tpl} \
        --out_dir ${dir} \
        --batch_size ${batch_size} \
        --seed ${seed} \
        --dataset ${dataset} \
        --use_memory ${use_memory} \
        --tolerance ${tolerance} \
        --held_out_prompt_ranking ${held_out_prompt_ranking} \
        --trust_factor ${trust_factor} \
        --train_p1 True \
        --train_p2 True \
        --forward_use_classes True \
        --logp_penalty ${logp_penalty} \
        --posterior_temp ${posterior_temp} \
        --strip_options_for_hidden False \
        --strip_prefix_for_hidden False \
        --scoring_function ${scoring_function} \
        --hidden_scoring_function ${hidden_scoring_function} \
        --model_type ${model_type}
done
