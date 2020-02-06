# Get CIFAR10
DATASET_NAME='CIFAR-10'
DATASET_DIR_NAME='cifar10'
DATASET_PATH='http://filecremers3.informatik.tu-muenchen.de/~dl4cv/cifar10_train.zip'
DATASET_ZIP_NAME='cifar10_train.zip'
EXERCISE_DIR=$(pwd)

cd ..
mkdir -p datasets/$DATASET_DIR_NAME
cd datasets/$DATASET_DIR_NAME
DATASET_DIR=$(pwd)

# Check if cifar is already downloaded in previous exercise
if [ -f ./cifar10_train.p ]; then
    echo 'Cifar10 already downloaded! Terminating...'
    cd "${EXERCISE_DIR}"
    exit 1
fi

echo 'Downloading '$DATASET_NAME

case $OSTYPE in
    # MacOS
    darwin*) curl -LO $DATASET_PATH ;;
    # Linux
    linux*) wget $DATASET_PATH ;;
    # All others
    *) echo "Failed! Your OS was not recognised, please download the zip file from ${DATAET_PATH}; after extraction, place cifar10_train.p in folder ${DATASET_DIR}" ;;
esac

tar -xzvf $DATASET_ZIP_NAME
rm $DATASET_ZIP_NAME
echo $DATASET_NAME ' downloaded successfully!'

cd "${EXERCISE_DIR}"
