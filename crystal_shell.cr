require "digest/md5"
require "file_utils"

CACHE_DIRECTORY = File.join(ENV["HOME"], ".cache", "crystal_shell")
PWD = Dir.current

def execute_eval(str)
  Process.exec \
    command: "crystal",
    args: ["eval", str],
    shell: true,
    chdir: PWD
end

def execute_target(filename)
  hash = Digest::MD5.hexdigest(File.read(filename))

  cache_file = File.join(CACHE_DIRECTORY, hash)
  if File.exists?(cache_file)
    Process.exec \
      command: cache_file,
      args: ARGV,
      shell: true,
      chdir: PWD
  else
    FileUtils.mkdir_p(CACHE_DIRECTORY)

    Process.fork do
      lock = File.join(CACHE_DIRECTORY, ".lock")

      while File.exists?(lock)
        sleep 0.33
      end

      begin
        File.touch(lock)
        File.new(lock).flock_exclusive do
          Process.run \
            command: "crystal",
            args: ["build", filename, "--release", "--no-debug", "-o", cache_file],
            shell: false,
            chdir: PWD
        end
      ensure
        File.delete(lock)
      end
    end

    Process.exec \
      command: "crystal",
      args: ["run", filename],
      shell: true,
      chdir: PWD
  end
end

case ARGV
when .any?
  script = ARGV.first

  case script
  when /^--/
    if script == "--prune"
      puts "Clearing binary cache"
      `rm -r #{CACHE_DIRECTORY}`
    elsif script == "--uninstall"
      puts "Uninstall crystal shell..."
      `rm -r #{CACHE_DIRECTORY}`
      File.delete("/usr/local/bin/crystal_shell")
      puts "Good bye!"
    else
      puts "UNKNOWN COMMAND: #{script}"
      Process.exit(1)
    end
  else
    execute_target(script)
  end

when .empty?
  code = [] of String

  Signal::INT.trap do
    if code.any?
      puts ""
      execute_eval code.join("\n");
    end

    Process.exit(0)
  end

  loop do
    print("> ")
    data = gets
    code << data if data
  end
end