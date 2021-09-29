#!/usr/bin/env python3

import sys
import subprocess

def handler():
    # a comment on its own line containing "WTF"
    wtf_pattern = r'^\s*-- .*WTF.*'

    # search out haskell files; expect it to succeed
    sources = subprocess.check_output(['find', './lib/', '-name', '*.hs']).decode('utf8').strip().splitlines()
    # search for WTF notes; don't care if it succeeds/fails (it will fail if there were none)
    wtfs = subprocess.run(['grep', wtf_pattern] + sources, stdout=subprocess.PIPE).stdout.decode('utf8').strip().splitlines()
    if wtfs:
        print('\n'.join(wtfs))

    # add changes; expect it to succeed
    subprocess.check_call(['git', 'add', '--no-all', '.'])
    # commit; don't care if it succeeds/fails (it will fail if there were no changes to files)
    subprocess.run(['git', 'commit', '-m', 'Autocommit ' + '\n'.join(wtfs)])

    if wtfs:
        # remove WTF notes; expect it to succeed
        subprocess.check_call(['sed', f'/{wtf_pattern}/d', '-i'] + [wtf.partition(':')[0] for wtf in wtfs])

if __name__ == '__main__' and sys.argv[1:]: # any arguments
    handler()
elif __name__ == '__main__' and not sys.argv[1:]: # no arguments
    subprocess.run('git ls-files | entr -c ./autocommitter.py run_handler', shell=True)
