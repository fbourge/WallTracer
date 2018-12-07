#!/bin/bash
#logparser.sh

## Copyright (C) 2018 codecubix
##
##Licensed to the Apache Software Foundation (ASF) under one
##or more contributor license agreements.  See the NOTICE file
##distributed with this work for additional information
##regarding copyright ownership.  The ASF licenses this file
##to you under the Apache License, Version 2.0 (the
##"License"); you may not use this file except in compliance
##with the License.  You may obtain a copy of the License at
##
##  http://www.apache.org/licenses/LICENSE-2.0

##Unless required by applicable law or agreed to in writing,
##software distributed under the License is distributed on an
##"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
##KIND, either express or implied.  See the License for the
##specific language governing permissions and limitations
##under the License.

FILE=/var/log/kern.log
#FILE=test.txt


# Get SRC Address
get_srcAddr(){
	awk 'match($0, "SRC=") { print substr($0, RSTART+4, 15)}' | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
}

get_process(){
	awk 'BEGIN {RS = "\n"}
	{
	date = substr($0,0,15)
	gsub(" ",";",date)

	token = substr($0, match($0, "SRC=")+4, 15)
	match(token,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
	srcAddrIPv4 = substr(token,RSTART,RLENGTH)

	token = substr($0, match($0, "DST=")+4, 15)
	match(token,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
	dstAddrIPV4 = substr(token,RSTART,RLENGTH)

	token = substr($0, match($0, "LEN=")+4, 5)
	match(token,/^[0-9]+/)
	Fln = substr(token,RSTART,RLENGTH)

	token = substr($0, match($0, "SPT=")+4, 5)
	match(token,/^[0-9]+/)
	srcPort = substr(token,RSTART,RLENGTH)

	token = substr($0, match($0, "DPT=")+4, 5)
	match(token,/^[0-9]+/)
	dstPort = substr(token,RSTART,RLENGTH)

	printf "%s;%s;%s;%s;%s;%s\n", date, srcAddrIPv4, dstAddrIPV4, Fln, srcPort, dstPort
	}'
}

# match(srcAddr,/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/)
# dstAddrIPV4 = substr($0,RSTART,RLENGTH)
# dstAddr = match($0, "DST=")  length = match($0, "LEN=") srcPort = match($0, "SPT=") dstPort = match($0, "DPT=")

# Get Input denied lines
grep iptables_INPUT_denied $FILE | get_process
