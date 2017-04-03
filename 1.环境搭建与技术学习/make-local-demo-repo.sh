#! /bin/sh
cocos new -l cpp torch_demo
git clone <TODO> torch_demo/remote
cd torch_demo
rm -r Classes Resource proj.android
mv -r remote/* .  && rmdir remote

