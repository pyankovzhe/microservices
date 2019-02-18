module Sinatra
  module CommentApp
    module Helpers
      def comment_id val
        begin
          BSON::ObjectId.from_string(val)
        rescue BSON::ObjectId::Invalid
          nil
        end
      end
    end
  end
end
