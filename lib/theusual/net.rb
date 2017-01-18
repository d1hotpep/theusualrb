# Most of this code was copied from:
# http://www.rubydoc.info/github/net-ssh/net-ssh/Net/SSH/Connection/Session

if defined? Net::SSH

  class Net::SSH::Connection::Session

      # use a psuedo TTY so we can run sudo commands on more secured cloud instances
      def suexec(command, &block)
        open_channel do |channel|
          channel.request_pty

          # add sudo prefix if need be
          command = "sudo #{command}" unless /^sudo /.match command

          channel.exec(command) do |ch, success|
            raise "could not execute command: #{command.inspect}" unless success

            channel.on_data do |ch2, data|
              if block
                block.call(ch2, :stdout, data)
              else
                $stdout.print(data)
              end
            end

            channel.on_extended_data do |ch2, type, data|
              if block
                block.call(ch2, :stderr, data)
              else
                $stderr.print(data)
              end
            end
          end
        end
      end


      def suexec!(command, &block)
        block ||= Proc.new do |ch, type, data|
          ch[:result] ||= ""
          ch[:result] << data
        end

        channel = suexec(command, &block)
        channel.wait

        return channel[:result]
      end

  end

end
