# force the loading of Postgres adapter
Sequel.postgres

class Sequel::Postgres::Dataset

  def each &block
    block ||=
      Proc.new do |row|
        Enumerator.new do |e|
          e.yield row
        end
      end

    super &block
  end

end
