#GBrowse displays genome data on web pages
#install GBrowse
cd /opt /biosoft/
wget https://github.com/GMOD/GBrowse/archive/release-2.56.tar.gz -O /home/web/software/GBrowse-release-2.56.tar.gz
tar axf /home/web/software/GBrowse-release-2.56.tar.gz  -C /opt/biosof
cd /opt/biosoft/gbrowse-release-2.56
perl Makefile.PL
./Build installdeps
#安装GBrowse以来的Perl模块时可能有一部分模块无法安装，其中包括Bio:DB::BigFile和Bio::DB::Sam，可通过如下方法安装
#安装USCS kent，安装Bio::DB::BigFile模块
cd /opt/biosoft/
wget http://hgdownload.cse.ucsc.edu/admin/jksrc.zip
unzip jksrc.zip
cd kent/src 
export MACHTYPE=X86_64
mkdir -p ~/BIN/X86_64
make CXXFLAGS=-fPIC CFLAGS cppFLAGS=-fPIC
cp .lib/x86_64/jkweb.a ./lib/
./Build installdeps
#安装Bio:DB::BigFile模块提示”Can't find the bigWig.h and jkweb.a files ata this locations.”时。输入/opt/biosoft/kent/src路径
#非默认模式下编译samtools，安装Bio::DB::Sam模块
cd /opt/biosoft/samtools-0.1.19
make clean 
make CXXFLAGS=-fPIC CFLAGS=-fPIC CPPFLAGS=-fPIC
./Build installdeps
#安装Bio::DB::Sam模块时输入/opt/biosoft/samtools-0.1.19\路径

