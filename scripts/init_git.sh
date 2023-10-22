#!/bin/bash
echo "configuring git..."
echo "input your git name: "
read git_name
echo "input your git e-mail: "
read git_e_mail
git config --global user.name "$git_name"
git config --global user.email $git_e_mail
git config --global core.autocrlf input