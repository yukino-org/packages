#!/bin/bash

set -eu

here=$(readlink -f "$0")
root_dir=$(dirname "${here}")
root_dir="${root_dir%/}"

git_url="https://github.com/yukino-org/packages"
branches=(
    "dart_devx"
    "dart_tenka_dev_tools"
    "dart_tenka_runtime"
    "dart_tenka"
    "dart_utilx"
)

cloned_dir="${root_dir}/.cloned"
docs_dir="${root_dir}/docs"

mkdir -p "${cloned_dir}"
mkdir -p "${docs_dir}"

docs() {
    pkg="$1"
    git clone "${git_url}" -b "${pkg}" "${cloned_dir}/${pkg}"
    cd "${cloned_dir}/${pkg}"
    dart pub get
    dart doc -o "${docs_dir}/${pkg}"
    echo "[done] Generated docs for ${pkg}"
}

for pkg in "${branches[@]}"; do
    docs "${pkg}"
done

index_html() {
    content=$(cat "${root_dir}/index.html")
    links=""
    for pkg in "${branches[@]}"; do
        links+="<li><a href=\"${pkg}\">${pkg}</a></li>\n"
    done
    title="Documentation - Yukino Packages"
    content=$(echo "${content}" | sed -r "s#@@TITLE@@#${title}#p")
    content=$(echo "${content}" | sed -r "s#@@LINKS@@#${links}#")
    echo "${content}" >"${docs_dir}/index.html"
    echo "[done] Generated index.html"
}

index_html
