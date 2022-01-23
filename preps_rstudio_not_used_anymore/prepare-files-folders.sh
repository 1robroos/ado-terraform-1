#!/bin/bash
set -e
_LIVE_DIR=${LIVE_DIR:=live_rstudio}
_BACKEND_TPL=${BACKEND_TPL:=backend.tf.tpl}


# echo show git branch but test ADO predefined variable
# echo 1 THis gives an error $(Build.SourceBranchName)
echo 2 Predefined variable BUILD_SOURCEBRANCHNAME has value  $BUILD_SOURCEBRANCHNAME
echo 3 Pass-through variable BRANCH_NAME has value $BRANCH_NAME
echo "..........................."


_BRANCH_NAME=${_BRANCH_NAME//\//-}

if [[ -z "$TF_VAR_rstudio_app_name" ]]; then
    echo "[ERROR] Must set TF_VAR_rstudio_app_name environment variable"
    exit 1
fi

if [[ -z "$AWS_REGION" ]]; then
    echo "[ERROR] Must set AWS_REGION environment variable"
    exit 1
fi
echo debug check ls  from branch  dir
echo " ls -l ${_BRANCH_NAME}"
ls -l ${_BRANCH_NAME}
echo

#[[ -d "$_BRANCH_NAME" ]] && rm -rf "$_BRANCH_NAME"
mkdir -p "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"/
echo _BRANCH_NAME dir = ${_BRANCH_NAME}
echo "Copying ${_LIVE_DIR} to ${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"
cp "${_LIVE_DIR}"/* "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"/
echo debug show ls ltR 
pwd 
ls -ltR
echo
echo "Copying tflint configuration file for aws provider"
cp  "${_LIVE_DIR}"/.tflint.hcl "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"/
sed -i.bak 's~AWS_REGION~'"$AWS_REGION"'~' "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}/${_BACKEND_TPL}"
sed -i.bak 's~APP_NAME~'"$TF_VAR_rstudio_app_name"'~' "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}/${_BACKEND_TPL}"
sed -i.bak 's~ENVIRONMENT~'"$_BRANCH_NAME"'~' "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}/${_BACKEND_TPL}"
mv "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}/${_BACKEND_TPL}" "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"/backend.tf
echo "[LOG] Prepared files and folders for the environment - $_BRANCH_NAME/${TF_VAR_rstudio_app_name}"
ls -lah "$_BRANCH_NAME/${TF_VAR_rstudio_app_name}"
cat "${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}"/backend.tf
echo "SHow PWD $PWD"
ls -l
cd ${_BRANCH_NAME}/${TF_VAR_rstudio_app_name}
echo "Now changed the branch subdir $PWD"  
ls -l
echo check the files in dev
cd ..
pwd
ls -l

