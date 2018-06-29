#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2018 Harsh Shandilya
# Copyright (C) 2018 Nathan Chancellor
# Does what 'make coccicheck MODE=patch' is supposed to do in case it's broken


# Prints a message in bold red then exits
die() {
    echo
    echo -e "\033[01;31m${*}\033[0m"
    echo
    exit 1
}


# The commits we want to apply to a kernel tree (the hashes are relative to Linus's tree, make sure you fetch that repo)
declare -a MATRIX=( "acafe7e30216166a17e6e226aadc3ecb63993242:kmalloc|kzalloc|kvmalloc|kvzalloc"
                    "b4b06db115bbbc10252287ae2d326fb5ecefaf18:vmalloc|vzalloc"
                    "0ed2dd03b94b7b7f66e23f25073b5385d0416589:devm_kmalloc|devm_kzalloc|sock_kmalloc|f2fs_kmalloc|f2fs_kzalloc"
                    "6da2ec56059c3c7a7e5f729e6349e74ace1e5c57:kmalloc"
                    "6396bb221514d2876fd6dc0aa2a1f240d99b37bb:kzalloc"
                    "590b5b7d8671e011d1a8e1ab20c60addb249d015:kzalloc_node"
                    "344476e16acbe20249675b75933be1ad52eff4df:kvmalloc"
                    "778e1cdd81bb5fcd1e72bf48a2965cd7aaec82a8:kvzalloc"
                    "3c4211ba8ad883ec658b989f0c86d2d7f79a904b:devm_kmalloc"
                    "a86854d0c599b3202307abceb68feee4d7061578:devm_kzalloc"
                    "42bc47b35320e0e587a88e437e18f80f9c5bcbb2:vmalloc"
                    "fad953ce0b22cfd352a9a90b070c34b8791e6868:vzalloc"
                    "fd7becedb1f01fe1db17215fca7eebeaa51d0603:vzalloc_node"
                    "84ca176bf54a6156b44dd0509268e5390c9ca46a:kvzalloc_node"
                    "76e43e37a407857596778c9290720ace481879d0:sock_kmalloc"
                    "c86065938aab568f68609438868e94a0ca0cc7c5:f2fs_kmalloc"
                    "026f05079b00a56250e6e5864b6949eae50ae4b8:f2fs_kzalloc"
                    "9d2a789c1db75d0f55b14fa57bec548d94332ad8:f2fs_kvzalloc" )


# The current folder
PATH_TO_SCRIPTS=$(pwd)
# The path to the kernel tree to modify (must be supplied as the first parameter)
PATH_TO_TREE="${1:?}"


# Make sure the user isn't dumb
cd "${PATH_TO_TREE}" 2>/dev/null || die "Supplied path doesn't exist!"


# For each commit
for ITEM in "${MATRIX[@]}"; do
    GIT_HASH=${ITEM%:*}
    SCRIPT=${PATH_TO_SCRIPTS}/${GIT_HASH}.cocci
    [[ ! -f ${SCRIPT} ]] && die "Coccinelle script could not be found! Did you run this script in the right folder?"
    SEARCH_TERM=${ITEM#*:}

    # Make sure the kernel tree is clean
    git reset --hard
    git clean -fdxq

    # Find each file with the search term and apply the coccinelle patch to it
    ag -l -f "${SEARCH_TERM}" | parallel -j+1 spatch -sp_file "${SCRIPT}" -in_place
    
    # Commit the result
    git commit -a -s -C "${GIT_HASH}"
done
