#!/bin/bash

# 定义一个函数，用于执行ping命令并将结果输出到屏幕上
ping_and_display() {
    location="$1"
    ip_host="$2"

    # 拆分IP主机字符串为主机名和IP地址
    host=$(echo $ip_host | cut -d'(' -f1)
    ip=$(echo $ip_host | cut -d'(' -f2 | cut -d')' -f1)

    # 执行ping命令并将输出保存到临时文件中
    temp_output=$(mktemp)
    ping -c 5 "$host" > $temp_output

    # 使用awk从临时文件中提取平均ping延迟
    avg_ping=$(awk -F'/' '/^rtt/ { print $5 }' $temp_output)

    # 删除临时文件
    rm $temp_output

    # 使用最大宽度和printf格式化输出
    printf "%-${max_location_width}s %-${max_host_width}s %-${max_ip_width}s %${max_ping_width}s ms\n" "$location" "$host" "$ip" "$avg_ping"
}

locations_and_hosts=(
    "(Asia)Seoul, Korea[韩国 首尔]|sel-kor-ping.vultr.com(141.164.34.61)"
    "(Asia)Tokyo, Japan[日本 东京]|hnd-jp-ping.vultr.com(108.61.201.151)"
    "Singapore[新加坡]|sgp-ping.vultr.com(45.32.100.168)"
    "(AU) Sydney, Australia[悉尼]|syd-au-ping.vultr.com(108.61.212.117)"
    "(EU) Frankfurt, DE[德国 法兰克福]|fra-de-ping.vultr.com(108.61.210.117)"
    "(EU) Amsterdam, NL[荷兰 阿姆斯特丹]|ams-nl-ping.vultr.com(108.61.198.102)"
    "(EU) London, UK[英国 伦敦]|lon-gb-ping.vultr.com(108.61.196.101)"
    "(EU) Paris, France[法国 巴黎]|par-fr-ping.vultr.com(108.61.209.127)"
    "Seattle, Washington[美东 华盛顿州 西雅图]|wa-us-ping.vultr.com(108.61.194.105)"
    "Silicon Valley, Ca[美西 加州 硅谷]|sjo-ca-us-ping.vultr.com(104.156.230.107)"
    "Los Angeles, Ca[美西 加州 洛杉矶]|lax-ca-us-ping.vultr.com(108.61.219.200)"
    "Chicago, Illinois[美东 芝加哥]|il-us-ping.vultr.com(107.191.51.12)"
    "Dallas, Texas[美中 德克萨斯州 达拉斯]|tx-us-ping.vultr.com(108.61.224.175)"
    "New York / New Jersey[美东 新泽西]|nj-us-ping.vultr.com(108.61.149.182)"
    "Atlanta, Georgiaa[美东 乔治亚州 亚特兰大]|ga-us-ping.vultr.com(108.61.193.166)"
    "Miami, Florida[美东 佛罗里达州 迈阿密]|fl-us-ping.vultr.com(104.156.244.232)"
    "Toronto, Canada[加拿大 多伦多]|tor-ca-ping.vultr.com(149.248.50.81)"
    "Stockholm[瑞典斯德哥尔摩]|sto-se-ping.vultr.com(70.34.194.86)"
    "Frankfurt[德国法兰福特]|fra-de-ping.vultr.com(108.61.210.117)"
    "Madrid[西班牙马德里]|mad-es-ping.vultr.com(208.76.222.30)"
    "Warsaw[波兰华沙]|waw-pl-ping.vultr.com(70.34.242.24)"
    "Mexico City[墨西哥墨西哥城]|mex-mx-ping.vultr.com(216.238.66.16)"
    "Honolulu[美国火奴鲁鲁/檀香山]|hon-hi-us-ping.vultr.com(208.72.154.76)"
    "Melbourne[澳大利亚墨尔本]|mel-au-ping.vultr.com(67.219.110.24)"
    "São Paulo[巴西圣保罗]|sao-br-ping.vultr.com(216.238.98.118)"
)

# 计算每个字段的最大宽度
max_location_width=0
max_host_width=0
max_ip_width=0
max_ping_width=10

for location_and_host in "${locations_and_hosts[@]}"; do
    location=$(echo $location_and_host | cut -d'|' -f1)
    ip_host=$(echo $location_and_host | cut -d'|' -f2)
    host=$(echo $ip_host | cut -d'(' -f1)
    ip=$(echo $ip_host | cut -d'(' -f2 | cut -d')' -f1)

    if [ ${#location} -gt $max_location_width ]; then
        max_location_width=${#location}
    fi
    if [ ${#host} -gt $max_host_width ]; then
        max_host_width=${#host}
    fi
    if [ ${#ip} -gt $max_ip_width ]; then
        max_ip_width=${#ip}
    fi
done

# 输出表头
printf "%-${max_location_width}s %-${max_host_width}s %-${max_ip_width}s %${max_ping_width}s\n" "Location" "Host" "IP" "Average Ping"
printf "%-${max_location_width}s %-${max_host_width}s %-${max_ip_width}s %${max_ping_width}s\n" "$(printf '%.0s-' {1..${max_location_width}})" "$(printf '%.0s-' {1..${max_host_width}})" "$(printf '%.0s-' {1..${max_ip_width}})" "$(printf '%.0s-' {1..${max_ping_width}})"

# 执行ping命令并显示结果
for location_and_host in "${locations_and_hosts[@]}"; do
    location=$(echo $location_and_host | cut -d'|' -f1)
    ip_host=$(echo $location_and_host | cut -d'|' -f2)
    ping_and_display "$location" "$ip_host"
done
# 执行ping命令并显示结果
























