# inspired by https://github.com/ohtorii/dnsmasq_adblock/blob/master/script/make_adblock_list.sh

format(){
  #remove BOM,comment(#...),space tab and empty lines.
  #convert CRLF -> LF
  echo "$1" | sed -e '1s/^\xef\xbb\xbf//' | sed -e "s/\r//g" | sed -e "/^#/d"|sed -e "/^[<space><tab>\n\r]*$/d"|sed -e "/^$/d" > $2
}

make_work_dir(){
  #作業ディレクトリ名を返す
  while :
  do
    local dir=/tmp/adlist_work$RANDOM/
    if [ -d $dir ]; then
      #ディレクトリ名を作り直して再挑戦
      :
    else
      echo $dir
      break
    fi
  done
}

download_adlist(){
  local result=`curl -LI "$1" -w '%{http_code}\n' -s -o /dev/null`
  if [ ! $result -eq 200 ];then
    echo "Not found URL."
    echo $1
    return 1
  fi
  local src=`curl -s "$1"`
  format "$src" "$2"
  return 0
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

process(){
  post_fix=$(date +%Y%m)
  url="https://280blocker.net/files/280blocker_domain_"${post_fix}".txt"
  download_adlist ${url} ${work_dir}host_280domain.txt
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  download_adlist "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=showintro=0&amp;mimetype=plaintext" ${work_dir}host_yoyo.txt
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  if [ -f /opt/additional_hosts.txt  ]; then
    src=`cat /opt/additional_hosts.txt `
    format "$src" "${work_dir}host_additional.txt"
  else
    echo Not found.
  fi

  #
  #(memo) host_*.txt -> merged.txt -> dnsmasq_adblock_list.txt
  #
  cat ${work_dir}host_*.txt | sort | uniq > ${work_dir}merged.txt
  cat ${work_dir}merged.txt | sed -e "s/^/address=\//g" | sed -e "s/\$/\/0\.0\.0\.0/g" > ${output_list_name}
}

main(){
  echo executed at $(date)
  output_list_name=/etc/dnsmasq.rabbit-house.conf
  script_dir="$(abs_dirname "$0")"
  work_dir=`make_work_dir`
  mkdir $work_dir
  if [ ! -d $work_dir ]; then
    echo "work dir not created."
    return 1
  fi

  process
  local ret=$?
  if [ ! $ret -eq 0 ];then
    return 1
  fi

  rm -r -f $work_dir

  sudo systemctl restart dnsmasq
}

main $*