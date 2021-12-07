#!/bin/bash
set -e
_LIVE_DIR=${LIVE_DIR:=../../live}
_BACKEND_TPL=${BACKEND_TPL:=backend.tf.tpl}

echo before if loop
echo var BRANCH_NAME is $BRANCH_NAME
echo 
echo show git show-branch 
git show-branch
echo "..........................."
echo 
echo show git branch
git branch
echo "..........................."

if [[ -z "$BRANCH_NAME" ]]; then
    _BRANCH_NAME=$(git branch --show-current)
     echo if loop 
     echo get git branch
     git branch --show-current
else
    _BRANCH_NAME=${BRANCH_NAME}
fi

_BRANCH_NAME=${_BRANCH_NAME//\//-}

if [[ -z "$TF_VAR_app_name" ]]; then
    echo "[ERROR] Must set TF_VAR_app_name environment variable"
    exit 1
fi

if [[ -z "$AWS_REGION" ]]; then
    echo "[ERROR] Must set AWS_REGION environment variable"
    exit 1
fi


[[ -d "$_BRANCH_NAME" ]] && rm -rf "$_BRANCH_NAME"
_BRANCH_NAME=dev
mkdir -p "${_BRANCH_NAME}"/
echo _BRANCH_NAME dir = ${_BRANCH_NAME}
cp "${_LIVE_DIR}"/* "${_BRANCH_NAME}"/
sed -i.bak 's~AWS_REGION~'"$AWS_REGION"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
sed -i.bak 's~APP_NAME~'"$TF_VAR_app_name"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
sed -i.bak 's~ENVIRONMENT~'"$_BRANCH_NAME"'~' "${_BRANCH_NAME}/${_BACKEND_TPL}"
mv "${_BRANCH_NAME}/${_BACKEND_TPL}" "${_BRANCH_NAME}"/backend.tf
echo "[LOG] Prepared files and folders for the environment - $_BRANCH_NAME"
ls -lah "$_BRANCH_NAME"
cat "${_BRANCH_NAME}"/backend.tf
