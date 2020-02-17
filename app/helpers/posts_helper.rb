module PostsHelper
    # REFERENCE ARTICLE - https://www.toptal.com/ruby-on-rails/rails-helper-bootstrap-carousel


    def display_post_tag(post)
        PostTag.new(self, post).html
    end

    class PostTag
        def initialize(view, post)
            @view, @post = view, post
            @uid = SecureRandom.hex(6)
        end

        def html
            # Joins components & renders parent div
            content = safe_join([vote, main])
            content_tag(:div, content, id: 'uid', class: 'row')
        end

        private

        attr_accessor :view, :post, :uid
        delegate :link_to, :content_tag, :image_tag, :raw, :safe_join, to: :view

        def vote
            content = safe_join([vote_tag('up'), count_tag, vote_tag('down')])
            content_tag(:div, content, class: 'col-md-1 d-flex flex-column align-items-center justify-content-between mx-0 px-0 py-1 border')
        end
        
        def count_tag
            # Upvote & Downvote
            # Vote count
            content_tag(:div, @post.votes.count)
        end

        def vote_tag(type)
            if type == 'up'
                content_tag(:span, nil, class: 'fas fa-angle-up')
            else
                content_tag(:span, nil, class: 'fas fa-angle-down')
            end
        end

        def main
            content = safe_join([title_tag, categories_tag, info_tag])
            content_tag(:div, content, class: 'col-md-11 border')
        end

        def title_tag
            # Post title
            content_tag(:h5, @post.title, class: 'my-0')
        end

        def categories_tag
            # Post categories that link to their filtered index
            content_div = @post.categories.map{|c| 
                content_tag :div, class: 'small px-1 py-0 mr-1 my-0 bg-info rounded text-white' do
                    link_to c.name, "/?query[categories]=#{c.id}", style: 'text-decoration: none; color: white'
                end
            }
            content_tag(:div, safe_join(content_div), class: 'd-flex')
        end

        def info_tag
            # Comments - User - Created @
            content = "#{@post.comments.count} Comments - #{@post.user.name} - #{format_date}"
            content_tag(:p, content, class: 'small my-0')
        end

        def format_date
            @date = @post.created_at.to_date

            if @date.between?(1.month.ago.to_date, Date.today)
                days = (Date.today - @date).to_i
                days.to_s + 'D ago'
            elsif @date.between?(1.year.ago.to_date, 1.month.ago.to_date)
                months = (Date.today - @date).to_i / 30
                months.to_s + 'M ago'
            else
                years = (Date.today - @date).to_i / 365
                years.to_s + 'Y ago'
            end
        end
    end
end
