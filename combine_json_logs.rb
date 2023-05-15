# frozen_string_literal: true
require "optparse"
require "time"

# This class combines multiple log files with JSON entries
# It assumes that each entry begins with a timestamp in a specific format
class CombineJsonLogs
  def initialize
    @log_file_handlers = []
    @timestamps = []
    @logs = []
  end

  def main(args)
    open_all_log_files(args)
    read_first_line_from_each_file_and_init_timestamps
    combine_logs
  end

  private

  # Open all given files and store their file handlers
  def open_all_log_files(files)
    files.each { |file| @log_file_handlers << File.open(file) }
  end

  # Read the first line from each file and store the logs and their timestamps
  def read_first_line_from_each_file_and_init_timestamps
    @log_file_handlers.each do |file|
      log = file.gets
      @logs << log
      timestamp = extract_timestamp(log)
      @timestamps << timestamp
    end
  end

  # Combines all logs, sorting them by their timestamps
  def combine_logs
    until @log_file_handlers.empty?
      earliest = get_earliest_timestamp

      # loop in the reverse order to avoid index change when deleting elements
      @timestamps.reverse_each.with_index do |timestamp, index|
        if timestamp == earliest
          fetch_until_next_timestamp_from_file(@timestamps.length - 1 - index)
        end
      end
    end
  end

  # Get the earliest timestamp from the list
  def get_earliest_timestamp
    @timestamps.min
  end

  # Fetch log entries from the file until the next timestamp is found
  def fetch_until_next_timestamp_from_file(index)
    puts @logs[index]
    loop do
      log = read_new_log_line(index)

      # remove all data for this file if it is EOF
      if log.nil?
        remove_file_handler(index)
        return
      end

      timestamp = extract_timestamp(log)

      # update timestamp and log once a new timestamp is found
      if timestamp
        update_log_and_timestamp(index, log, timestamp)
        break
      # continue to print log if no timestamp is found (e.g. log is incomplete due to a multi-line query)
      else
        puts log
      end
    end
  end
end

# Reads a new line from the log file at the given index
def read_new_log_line(index)
  @log_file_handlers[index].gets
end

# Removes the file handler, the log and the timestamp at the given index.
def remove_file_handler(index)
  @logs.delete_at(index)
  @log_file_handlers.delete_at(index)
  @timestamps.delete_at(index)
end

# Extracts the timestamp from a log line. Returns nil if no timestamp found
def extract_timestamp(log)
  match = /(.*UTC)/.match(log[0..22])
  match ? Time.parse(match[1]) : nil
end

# Updates the log and the timestamp at the given index
def update_log_and_timestamp(index, log, timestamp)
  @logs[index] = log
  @timestamps[index] = timestamp
end

# Run the combiner if this file is the main script
if __FILE__ == $0
  combiner = CombineJsonLogs.new
  combiner.main(ARGV)
end
