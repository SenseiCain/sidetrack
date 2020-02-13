module PostTagHelper
    # REFERENCE ARTICLE - https://www.toptal.com/ruby-on-rails/rails-helper-bootstrap-carousel


    def display_post_tag
        # Render the actual post component
        # PostTag.new(self, post).html
    end

    class PostTag
        def initialize(view, post)
            # @view, @post = view, post
            # @uid = SecureRandom.hex(6)
        end

        def html
            # Joins components & renders parent div
        end

        private

        # attr_accessors :view, :post, :uid
        # delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

        def vote  
        end
        
        def vote_tag
            # Upvote & Downvote
            # Vote count
        end

        def info
        end

        def info_tag
            # Post title
            # Post categories that link to their filtered index
            # Comments - User - Created @
        end
    end
end