module Hashable
  extend ActiveSupport::Concern

  included do
    before_save :generate_hashed_value
  end

  private
    def client
      @client ||= IronWorker::Client.new
    end

    def generate_hashed_value
      task_id = send_to_worker(self.original)
      wait_for_worker(task_id)
      log = client.tasks.log(task_id)
      self.hashed = hashed_value_from_log(log)
    end

    def hashed_value_from_log(log)
      last_line(log)[/^.*\s-HASHED->\s(.*)$/, 1]
    end

    def last_line(string)
      string.lines.last.chomp
    end

    def send_to_worker(string)
      client.tasks.create(ENV['IRON_WORKER_CODE_NAME'], string).id
    end

    def wait_for_worker(task_id, sleep=1)
      client.tasks.wait_for(task_id, sleep: sleep)
    end
end
