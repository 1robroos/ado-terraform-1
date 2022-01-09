#!/bin/bash
set -e
#_LIVE_DIR=${LIVE_DIR:=live}
LIVE_DIR=${LIVEDIR}
echo var LIVE_DIR is passed through and has value $LIVE_DIR
_BACKEND_TPL=${BACKEND_TPL:=backend.tf.tpl}
_BRANCH_NAME=${BRANCH_NAME}

echo  TF_VAR_app_name = ${TF_VAR_app_name}
echo  BRANCH_NAME =  ${BRANCH_NAME}
echo  TF_VAR_region =  ${TF_VAR_region}
echo  LIVEDIR = ${LIVEDIR}
echo
# echo show git branch but test ADO predefined variable
# echo 1 THis gives an error $(Build.SourceBranchName)
echo 2 Predefined variable BUILD_SOURCEBRANCHNAME has value  $BUILD_SOURCEBRANCHNAME
echo 3 Pass-through variable BRANCH_NAME has value $BRANCH_NAME
echo "..........................."

# if [[ -z "$BRANCH_NAME" ]]; then
#     _BRANCH_NAME=$(git branch --show-current)
#      echo if loop 
#      echo get git branch
#      git branch --show-current
# else
#     _BRANCH_NAME=${BRANCH_NAME}
# fi

# _BRANCH_NAME=${_BRANCH_NAME//\//-}
if [[ -z "$_BRANCH_NAME" ]]; then
    echo "[ERROR] Must set _BRANCH_NAME environment variable"
    exit 1
fi
if [[ -z "$TF_VAR_app_name" ]]; then
    echo "[ERROR] Must set TF_VAR_app_name environment variable"
    exit 1
fi

if [[ -z "$AWS_REGION" ]]; then
    echo "[ERROR] Must set AWS_REGION environment variable"
    exit 1
fi
if [[ $LIVE_DIR= "live" ]]
then
    DIRTOCREATE=$_BRANCH_NAME
else
    DIRTOCREATE=$LIVE_DIR
fi 
echo dir to create = $DIRTOCREATE

##[[ -d "$_BRANCH_NAME" ]] && rm -rf "$_BRANCH_NAME"

mkdir -p "${DIRTOCREATE}"/
echo DIRTOCREATE dir = ${DIRTOCREATE}
echo "Copying ${LIVE_DIR} to ${DIRTOCREATE}"
cp "${LIVE_DIR}"/* "${DIRTOCREATE}"/
echo "Copying tflint configuration file for aws provider"
cp  "${LIVE_DIR}"/.tflint.hcl "${DIRTOCREATE}"/
sed -i.bak 's~AWS_REGION~'"$AWS_REGION"'~' "${DIRTOCREATE}/${_BACKEND_TPL}"
sed -i.bak 's~APP_NAME~'"$TF_VAR_app_name"'~' "${DIRTOCREATE}/${_BACKEND_TPL}"
sed -i.bak 's~ENVIRONMENT~'"$_BRANCH_NAME"'~' "${DIRTOCREATE}/${_BACKEND_TPL}"
mv "${DIRTOCREATE}/${_BACKEND_TPL}" "${DIRTOCREATE}"/backend.tf
echo "[LOG] Prepared files and folders for the environment - $DIRTOCREATE"
ls -lah "$DIRTOCREATE"
cat "${DIRTOCREATE}"/backend.tf
echo "SHow PWD $PWD"
ls -l
cd ${DIRTOCREATE}
echo "Now changed the branch subdir $PWD"  #/home/vsts/work/1/s/preps/dev



# mkdir -p "${_BRANCH_NAME}"/
# echo _BRANCH_NAME dir = ${_BRANCH_NAME}
# echo "Copying ${LIVE_DIR} to ${_BRANCH_NAME}"
# cp "${LIVE_DIR}"/* "${_BRANCH_NAME}"/
# echo "Copying tflint configuration file for aws provider"
# cp  "${LIVE_DIR}"/.tflint.hcl "${_BRANCH_NAME}"/
# sed -i.bak 's~AWS_REGION~'"$AWS_REGION"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
# sed -i.bak 's~APP_NAME~'"$TF_VAR_app_name"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
# sed -i.bak 's~ENVIRONMENT~'"$_BRANCH_NAME"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
# mv "${_BRANCH_NAME}/${_BACKEND_TPL}" "${_BRANCH_NAME}"/backend.tf
# echo "[LOG] Prepared files and folders for the environment - $_BRANCH_NAME"
# ls -lah "$_BRANCH_NAME"
# cat "${_BRANCH_NAME}"/backend.tf
# echo "SHow PWD $PWD"
# ls -l
# cd ${_BRANCH_NAME}
# echo "Now changed the branch subdir $PWD"  #/home/vsts/work/1/s/preps/dev

