#!/bin/bash
printf "\360\237\225\265  Let's test some dependency management...\n"

printf "\360\237\233\240  We'll build our dependency into a wheel. It 'install_requires' the 'requests' library.\n"
cd dependency/; set -x
pipenv run python setup.py bdist_wheel >/dev/null 2>&1
{ set +x; } 2>/dev/null; cd ..

echo
printf "\342\255\220  Create venv and install from path, should succeed:\n"
set -x; cd example/
pipenv --three install file://$(dirname $(pwd))/dependency/dist/test_dep-1.0-py3-none-any.whl >/dev/null 2>&1
pipenv run python test.py
{ set +x; } 2>/dev/null; cd ..

echo
printf "\360\237\223\204  Note that 'pipenv graph' knows about the 'requests' dependency, but the created Pipfile.lock doesn't:\n"
set -x; cd example/
pipenv graph
pipenv lock >/dev/null 2>&1 && cat Pipfile.lock
{ set +x; } 2>/dev/null; cd ..

echo
printf "\360\237\222\243  Reset venv and install from lockfile, should fail:\n"
set -x; cd example/
pipenv --three install >/dev/null 2>&1
pipenv run python test.py
{ set +x; } 2>/dev/null; cd ..

echo
printf "\360\237\233\201  Cleaning up!\n"
rm -rf dependency/build/ dependency/dist/ dependency/test_dep.egg-info/
rm example/Pipfile.lock
