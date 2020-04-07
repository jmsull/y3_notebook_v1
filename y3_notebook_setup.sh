#!/bin/bash
if [[ -z "${COSMOSIS_SRC_DIR}" ]]; then
  echo 'Exiting without executing. Make sure you source setup-cosmosis-nersc please!'
  exit 1
fi
COSMOSIS_SRC_DIR_copy=$COSMOSIS_SRC_DIR
conda deactivate
conda deactivate
conda env create -f environment.yml
source activate cosmosis-nbf
python -m ipykernel install --user --name cosmosis-nbf --display-name Cosmosis-nbf
#edit kernel spec and helper script
kernelshell="${PWD}/kernel_cosmosis.sh"
python add_line.py ./kernel.json $kernelshell 
cp kernel.json $HOME/.local/share/jupyter/kernels/cosmosis-nbf/kernel.json
chmod u+x kernel_cosmosis.sh
python add_line.py ./kernel_cosmosis.sh $COSMOSIS_SRC_DIR_copy 
#get bayesfast
git clone https://github.com/HerculesJack/bayesfast
cd bayesfast
LDSHARED="cc -shared" CC=cc python -m pip install --user -e .
#pip install -e .
echo 'Done'
