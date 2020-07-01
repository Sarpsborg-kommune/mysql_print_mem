#!/bin/bash
# Source:  https://tech.labelleassiette.com/how-to-reduce-the-memory-usage-of-mysql-61ea7d1a9bd
#          Thomas Florelli
# Credits: Eduardo Franceschi

# Edit mysql to include authentication
mysql -u root -p -e "show variables; show status" | awk '
{
VAR[$1]=$2
}
END {
MAX_CONN = VAR["max_connections"]
MAX_USED_CONN = VAR["Max_used_connections"]
BASE_MEM=VAR["key_buffer_size"] + VAR["query_cache_size"] + VAR["innodb_buffer_pool_size"] + VAR["innodb_additional_mem_pool_size"] + VAR["innodb_log_buffer_size"]
MEM_PER_CONN=VAR["read_buffer_size"] + VAR["read_rnd_buffer_size"] + VAR["sort_buffer_size"] + VAR["join_buffer_size"] + VAR["binlog_cache_size"] + VAR["thread_stack"] + VAR["tmp_table_size"]
MEM_TOTAL_MIN=BASE_MEM + MEM_PER_CONN*MAX_USED_CONN
MEM_TOTAL_MAX=BASE_MEM + MEM_PER_CONN*MAX_CONN

printf "+--------------------------------+-------------------------------------+\n"
printf "| %40s | %15.3f MB |\n", "key_buffer_size", VAR["key_buffer_size"]/1048576
}'