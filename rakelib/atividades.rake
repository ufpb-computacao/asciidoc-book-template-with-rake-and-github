source_files = Rake::FileList.new("atividades/*.adoc")

desc "Generate docx files from asciidoc"
task :atividades => "atividades:docx"

namespace "atividades" do
  
  task :docx => source_files.ext(".docx")

  rule ".fodt" => ".adoc" do |t|
    sh "asciidoc -b odt -a lang=pt-BR #{t.source}"
  end

  rule ".docx" => ".fodt" do |t|
    sh "soffice --headless --invisible --convert-to docx --outdir atividades/ #{t.source}"
  end

end
  



