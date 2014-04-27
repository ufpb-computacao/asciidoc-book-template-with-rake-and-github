require 'rake/clean'

task :default => [:wip]

SOURCE_FILES = FileList['livro/livro.asc', 'livro/capitulos/*']
@RELEASE_DIR = 'releases/current'
@BOOK_SOURCE_DIR = 'livro'
@BOOK_SOURCE = 'livro/livro.asc'
@BOOK_TARGET = 'livro/livro.pdf'
@A2X_BIN = '~/ambiente/asciidoc/a2x.py'
WIP_ADOC = "#{@BOOK_SOURCE_DIR}/wip.adoc"
RELEASE_BOOK_SOURCE = "#{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/livro.asc"
RELEASE_BOOK  = "#{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/livro.pdf"
RELEASE_WIP_ADOC =  "#{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.adoc"
RELEASE_WIP_PDF  =  "#{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.pdf"
OPEN_PDF_CMD="xdg-open"

directory @RELEASE_DIR

CLEAN.include('releases')

desc "Sync, build and open wip file"
task :wip => ["sync", "wip:build", "wip:open"]

namespace "wip" do

  desc "Create new wip file from book source"
  task "new" do 
    cp "#{@BOOK_SOURCE}", "#{@BOOK_SOURCE_DIR}/wip.adoc"
  end

  file WIP_ADOC => "new" do
  end

  file RELEASE_WIP_PDF do
    system "#{@A2X_BIN} -v -f pdf #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.adoc"
  end
  
  desc "Open wip pdf"
  task "open" => RELEASE_WIP_PDF do |t|
      system "#{OPEN_PDF_CMD} #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.pdf"
  end

  desc "open docbook xml file"
  task "xml" do
    system "#{OPEN_PDF_CMD} #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.xml"
  end

  desc "build book from #{@RELEASE_DIR}"
  task :build => [WIP_ADOC, :sync] do
    system "#{@A2X_BIN} -v -f pdf -k #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/wip.adoc"
  end

end


desc "Sync, build and open book file"
task :book => [:clean, :archive, "book:build", "book:open"]


namespace "book" do

  desc "Build book"
  task :build => ['sync'] do
    system "#{@A2X_BIN} -v -f pdf -k #{@RELEASE_DIR}/#{@BOOK_SOURCE}"
  end

  desc "open pdf book"
  task "open" do
    system "#{OPEN_PDF_CMD} #{@RELEASE_DIR}/#{@BOOK_TARGET}"
  end

  desc "open docbook xml file"
  task "xml" do
    system "#{OPEN_PDF_CMD} #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}/livro.xml"
  end
end

desc "archive files from git"
task :archive => :clean do
  system "git archive --format=tar --prefix=#{@RELEASE_DIR}/ HEAD | (tar xf -) "
end

desc "local sync of the files to #{@RELEASE_DIR}"
task :sync => @RELEASE_DIR do |t|
  system "rsync -r --delete #{@BOOK_SOURCE_DIR}/ #{@RELEASE_DIR}/#{@BOOK_SOURCE_DIR}"
end

