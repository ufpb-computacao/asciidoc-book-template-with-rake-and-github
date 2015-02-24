desc "Build svg from dot files"
task :dot

desc "Build pdf from svg files"
task :svg

#task :sync => [:dot]

FileList['livro/images/**/*.dot'].each do |source|
  epsfile = source.ext('svg')
  file epsfile => source do |t|
    sh "dot -Tsvg -o #{t.name} #{t.source}"
  end
  task :dot => epsfile
end

FileList['livro/images/**/*.svg'].each do |source|
  targetFile = source.ext('pdf')
  file targetFile => source do |t|
    sh "inkscape -z -D -d 300 --export-pdf=#{t.name} #{t.source}"
  end
  task :svg => targetFile
end
