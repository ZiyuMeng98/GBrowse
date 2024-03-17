# GBrowse displays genome data on web pages
# Install GBrowse
cd /opt/biosoft/
wget https://github.com/GMOD/GBrowse/archive/release-2.56.tar.gz -O /home/web/software/GBrowse-release-2.56.tar.gz
tar axf /home/web/software/GBrowse-release-2.56.tar.gz -C /opt/biosoft
cd /opt/biosoft/gbrowse-release-2.56
perl Makefile.PL
./Build installdeps

# Some Perl modules required for GBrowse installation may not be installed, including Bio::DB::BigFile and Bio::DB::Sam. They can be installed as follows.
# Install USCS kent and the Bio::DB::BigFile module
cd /opt/biosoft/
wget http://hgdownload.cse.ucsc.edu/admin/jksrc.archive/jksrc.v330.zip
# The latest kent cannot compile the required jkweb.a file
unzip jksrc.zip
cd kent/src
export MACHTYPE=X86_64
mkdir -p ~/BIN/X86_64
make CXXFLAGS=-fPIC CFLAGS cppFLAGS=-fPIC
cp .lib/x86_64/jkweb.a ./lib/
./Build installdeps

# When prompted with "Can't find the bigWig.h and jkweb.a files at these locations." during the installation of the Bio::DB::BigFile module, input the path /opt/biosoft/kent/src

# Compile samtools in non-default mode for installing the Bio::DB::Sam module
cd /opt/biosoft/samtools-0.1.19
make clean
make CXXFLAGS=-fPIC CFLAGS=-fPIC CPPFLAGS=-fPIC
./Build installdeps

# When installing the Bio::DB::Sam module, input the path /opt/biosoft/samtools-0.1.19

# Install build utilities
yum install make gcc gmp-devel

# Utilities for fetching components distributed in source code
yum install wget git

# Apache2
yum install httpd mod_fcgid fcgi-perl

# Various Perl modules
yum install perl-GD perl-Module-Build perl-CPAN perl-IO-String perl-Capture-Tiny perl-CGI-Session \
            perl-JSON perl-JSON-Any perl-libwww-perl perl-DBD-SQLite perl-Net-SMTP-SSL \
            perl-Crypt-SSLeay perl-Net-SSLeay perl-Template-Toolkit

# Bioperl
yum install perl-bioperl perl-Bio-Graphics

# Optionally...
yum install mysql-server mysql-libs perl-DBD-MySQL
yum install postgresql postgresql-server perl-DBD-Pg
yum install inkscape
yum install perl-GD-SVG

perl -MCPAN -e 'install Bio::Perl'

# Run Build.PL to check for missing dependencies
perl Build.PL
./Build test
# The failed tests can be ignored; manually install or use cpan to install the missing dependencies. The installation is successful if no dependencies are missing after perl Build.PL.
./Build install
