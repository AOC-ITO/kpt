#!/bin/bash
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

########################
# include the magic
########################
. $d/../../demos/demo-magic/demo-magic.sh

cd $(mktemp -d)
git init > /dev/null

kpt pkg get $PKG helloworld > /dev/null
git add . > /dev/null
git commit -m 'fetched helloworld' > /dev/null
kpt svr apply -R -f helloworld > /dev/null


# start demo
clear

echo "# start with helloworld package"
echo "$ kpt pkg desc helloworld"
kpt pkg desc helloworld

# start demo
echo " "
p "# 'kpt cfg tree' summarizes Resources in a package"
pe "kpt cfg tree helloworld"

echo " "
p "# it can also read from stdin"
p "# if the input Resources have owners references, then"
p "# the tree structure will reflect the Resource relationships"
pe "kubectl get all -o yaml | kpt cfg tree"

echo " "
p "# tree supports printing fields from objects"
pe "kpt cfg tree helloworld --replicas --name --image --ports"

echo " "
p "# in addition to the built-ins, arbitrary fields may be printed"
pe "kpt cfg tree helloworld --field 'spec.selector' --field 'spec.selector' --field 'spec.template.metadata.labels'"

p "# for more information see 'kpt help cfg tree'"
p "kpt help cfg tree"
