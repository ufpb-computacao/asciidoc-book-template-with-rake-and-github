require 'yaml'

qrcode_dir = 'livro/images/qrcode'
qrcode_size = 4

desc "Build tables from qrcode specs"
task :qrcode
task :sync => :qrcode

FileList['livro/capitulos/videos/*.yaml'].each do |source|
  tableadoc = source.ext('adoc')
  file tableadoc => source do |t|
    table = YAML.load_file(source)
    spec = table.delete 'spec'
    cols = "1^"
    if spec then
      cols = spec['cols']
      qrcode_size = spec['qrsize'] or qrcode_size
    end
    code = ""
    header = "[cols=\"#{spec['cols']}\", frame=\"none\", grid=\"none\"]"
    code << header
    code << "\n|====\n"
    table.map do |label,media|

      if label == "end" then
        code << "| \n"
      else
        link = media[0]
        description = media[1]
        cellspec = media[2] or ""
        qrcode_file = "#{label}.png"
        sh "qrencode \"#{link}\" -o #{qrcode_dir}/#{qrcode_file} -s #{qrcode_size}"

        row = <<-eos
#{cellspec}| image:{qrcode_dir}/#{qrcode_file}[]

#{link}

#{description}
eos
        code << row

      end
    end
    code << "\n|====\n"
    puts code
    File.open(tableadoc, 'w') {|f| f.write(code) }




    #puts table
    #sh "echo name #{t.name} source: #{t.source}"
  end
  task :qrcode => tableadoc
end
