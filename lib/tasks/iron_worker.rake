require 'dotenv/tasks'
require 'zip'

namespace :iron_worker do
  desc "Upload worker code to Iron Worker"
  task :upload => :dotenv do
    folder = 'vendor/bin'
    exe = 'StringHasher.exe'
    worker_code = 'send_payload_to_string_hasher.sh'
    tmp_zip_file = 'tmp/worker.zip'

    begin
      Zip::File.open(tmp_zip_file, Zip::File::CREATE) do |zipfile|
        [exe, worker_code].each do |file|
          zipfile.add(file, folder + '/' + file)
        end
      end
      puts `iron worker upload \
            --zip #{tmp_zip_file} \
            --name #{ENV['IRON_WORKER_CODE_NAME']} \
            iron/mono \
            sh #{worker_code}`
    ensure
      File.delete(tmp_zip_file)
    end
  end
end
