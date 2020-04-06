#!/bin/bash
if [[ -z "${COSMOSIS_SRC_DIR}" ]]; then
  echo 'Exiting without executing. Make sure you source setup-cosmosis-nersc please!'
  exit 1
fi
COSMOSIS_SRC_DIR_copy=$COSMOSIS_SRC_DIR
conda deactivate
conda deactivate
conda env create -f environment.yml
source activate cosmosis-nb1
python -m ipykernel install --user --name cosmosis-nb1 --display-name Cosmosis-nb1
#edit kernel spec and helper script
kernelshell="${PWD}/kernel_cosmosis.sh"
python add_line.py ./kernel.json $kernelshell 
cp kernel.json $HOME/.local/share/jupyter/kernels/cosmosis-nb1/kernel.json
chmod u+x kernel_cosmosis.sh
python add_line.py ./kernel_cosmosis.sh $COSMOSIS_SRC_DIR_copy 
#get bayesfast
git clone https://github.com/HerculesJack/bayesfast
cd bayesfast
pip install -e .
echo 'Done'