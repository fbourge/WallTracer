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

pkg load io

c = csv2cell("log.txt",";");

A = c(:,8);

H = countmembers(sort(unique(A)),A,500);

hf = figure (1, 'position',[0,0,700,700]);
bar(H);
set(gca,'XTickLabel',sort(unique(A)))



hold on;
xlabel ("Destination port");
ylabel ("Number of occurrences")
title ("TOP 6 of most recurrent IPV4 addresses in abusive incoming packets");
#set (hf, "visible", "off");
saveas (hf, "IPV4_incomingtraffic.png");
#print(hf,"hello.pdf","-pdflatex");