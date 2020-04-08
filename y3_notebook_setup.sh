#!/bin/bash
if [[ -z "${COSMOSIS_SRC_DIR}" ]]; then
  echo 'Exiting without executing. Make sure you source setup-cosmosis-nersc please!'
  exit 1
fi
COSMOSIS_SRC_DIR_copy=$COSMOSIS_SRC_DIR
conda deactivate
conda deactivate
conda env create -f environment.yml
source activate cosmosis-ft
python -m ipykernel install --user --name cosmosis-ft --display-name Cosmosis-ft
#edit kernel spec and helper script
kernelshell="${PWD}/kernel_cosmosis.sh"
python add_line.py ./kernel.json $kernelshell 
cp kernel.json $HOME/.local/share/jupyter/kernels/cosmosis-ft/kernel.json
chmod u+x kernel_cosmosis.sh
python add_line.py ./kernel_cosmosis.sh $COSMOSIS_SRC_DIR_copy 
#get bayesfast
git clone https://github.com/HerculesJack/bayesfast
cd bayesfast
LDSHARED="cc -shared" CC=gcc python -m pip install --user -e .
#pip install -e 
cd ../.
echo 'Moving notebook up one directory so it can run properly.'
mv des-y3-v1.ipynb ../
echo "Moving original params.ini file to orig_3x2pt.ini"
mv ../params.ini ../orig_3x2pt.ini
echo "Copying up the bayesfast 2x2pt params.ini with pm_marg=False."
cp ./mn_inifiles/params.ini ../
echo 'Done'
