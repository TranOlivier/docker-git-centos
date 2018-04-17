FROM centos:latest

WORKDIR /git

RUN yum update && \
	yum -y groupinstall "Development Tools" && \
	yum -y install git epel-release dh-autoreconf curl-devel expat-devel gettext-devel openssl-devel perl-CPAN perl-devel zlib-devel && \
	yum -y install asciidoc xmlto docbook2X getopt wget

RUN ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

#COPY git-2.17.0.tar.gz .
 
#RUN tar -zxf git-2.17.0.tar.gz

#RUN cd git-2.17.0 && \
#	make configure && \
#	./configure --prefix=/usr && \
#	make all doc info && \
#	make install install-doc install-html install-info

RUN git clone https://github.com/git/git.git

WORKDIR git

RUN git checkout tags/$(git describe --tags $(git rev-list --tags --max-count=1))

RUN  make configure && \
        ./configure --prefix=/usr && \
        make all doc info && \
        make install install-doc install-html install-info


CMD ["git","--version"]
