#!/usr/bin/env bash
declare -a DATASET_DIR_NAMES=('' '' 'mnist' 'landmark_data')
declare -a DATASET_PATHS=('http://filecremers3.informatik.tu-muenchen.de/~dl4cv/segmentation_data.zip'
                          'http://filecremers3.informatik.tu-muenchen.de/~dl4cv/segmentation_data_test.zip'
                          'http://filecremers3.informatik.tu-muenchen.de/~dl4cv/mnist_train.zip'
                          'http://filecremers3.informatik.tu-muenchen.de/~dl4cv/training.zip')

declare -a DATASET_ZIP_NAMES=('segmentation_data.zip'
                              'segmentation_data_test.zip'
                              'mnist_train.zip'
                              'training.zip')
NUM_DATASETS=${#DATASET_PATHS[@]}
EXERCISE_DIR=$(pwd)

# Check operating system
case $OSTYPE in
  # MacOS
  darwin*) download="curl -LO" ;;
  # Linux
  linux*) download="wget" ;;
  # All others
  *) echo "Failed! Your OS was not recognised, please download the following files:"
     for (( i=0; i<${NUM_DATASETS}; i++ ));
     do
       echo ${DATASET_PATHS[$i]}
     done
     echo "After extraction, place the files in the respective folders"
     exit 1 ;;
esac

mkdir -p ../datasets
cd ../datasets
DATASET_DIR=$(pwd)

# Download datasets
for (( i=1; i<${NUM_DATASETS}+1; i++ ));
do
  echo "Downloading [${i}/${NUM_DATASETS}] ${DATASET_PATHS[$i-1]}"
  if [ ${#DATASET_DIR_NAMES[$i-1]} != 0 ]
  then
    mkdir -p ${DATASET_DIR_NAMES[$i-1]}
    cd ${DATASET_DIR_NAMES[$i-1]}
  fi
  eval "${download} ${DATASET_PATHS[$i-1]}"
  echo "Unzipping ${DATASET_ZIP_NAMES[$i-1]}"
  unzip -q -o ${DATASET_ZIP_NAMES[$i-1]}
  rm ${DATASET_ZIP_NAMES[$i-1]}
  echo "${DATASET_PATHS[$i-1]} downloaded successfully!"
  cd ${DATASET_DIR}
done


cd ${EXERCISE_DIR}
