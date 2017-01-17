if defined? Mongoid

  module Mongoid::Document
    alias :as_doc :as_document
  end

  class Mongoid::Criteria
    def as_doc
      to_a.map &:as_doc
    end
    alias_method :as_docs, :as_doc

    # can't seem to override Mongoid::Document::last, so put this
    # functionality here
    def last(n = 1)
      order(_id: -1).limit(n)
    end

    # see http://apidock.com/rails/ActiveRecord/Batches/find_in_batches
    def find_in_batches(opts = {}, &block)
      batch_size = opts[:batch_size] || 1000
      offset = opts[:start] || 0

      loop do
        docs = skip(offset).limit(batch_size).to_a

        if docs.empty?
          break
        else
          yield docs
          offset += batch_size
        end
      end
    end
  end

end
