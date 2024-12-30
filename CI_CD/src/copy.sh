#!/bin/bash

# Берем переменные
source /home/gitlab-runner/.env

# Копирование файлов
scp ${REPO_PATH}artifacts/cat/s21_cat ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/s21_cat
scp ${REPO_PATH}artifacts/grep/s21_grep ${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}/s21_grep

# Проверка успешности копирования
if ssh ${REMOTE_USER}@${REMOTE_HOST} "[ -f ${REMOTE_PATH}/s21_cat ] && [ -f ${REMOTE_PATH}/s21_grep ]"; then
  echo "Deployment successful"
  echo ""
  echo "Files on the second machine:"
  ssh ${REMOTE_USER}@${REMOTE_HOST} ls -la /usr/local/bin
  exit 0
else
  echo "Deployment failed"
  exit 1
fi

