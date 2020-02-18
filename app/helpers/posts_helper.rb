include Rails.application.routes.url_helpers

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
            content = safe_join([vote, main])
            content_tag(:div, content, id: @uid, class: 'row m-0')
        end

        private

        attr_accessor :view, :post, :uid
        delegate :link_to, :content_tag, :image_tag, :raw, :safe_join, to: :view

        def vote
            content = safe_join([vote_tag('up'), count_tag, vote_tag('down')])
            content_tag(:div, content, class: 'col-md-1 d-flex flex-column align-items-center justify-content-between m-0 px-0 py-0 border')
        end
        
        def count_tag
           content_tag(:p, @post.votes.count, class: 'm-0 p-0')
        end

        def vote_tag(type)
            @content = ''

            if type == 'up'
                @content = image_tag('up-arrow.png')
            else
                @content = image_tag('down-arrow.png')
            end

            link_to root_path, class: 'vote_btn'do
                @content
            end
        end

        def main
            content = safe_join([title_tag, categories_tag, info_tag])
            inside = content_tag(:div, content, class: 'row px-2')
            content_tag(:div, inside, class: 'col-md-11 border justify-content-center')
        end

        def title_tag
            header_tag = content_tag(:p, @post.title, class: 'my-0 px-0')
            content_tag(:a, header_tag, class: 'my-0 px-0 col-md-12', style: 'text-decoration: none; color: inherit', href: post_path(@post))
        end

        def categories_tag
            content_div = @post.categories.map{|c| 
                content_tag :span, class: 'badge badge-transparent mr-1 text-info px-0' do
                    link_to c.name, "/?query[categories]=#{c.id}", style: 'text-decoration: none;', class: 'py-0'
                end
            }
            content_tag(:div, safe_join(content_div), class: 'col-md-12 my-0 px-0 d-flex')
        end

        def info_tag
            content = "#{@post.comments.count} Comments - #{@post.user.name} - #{format_date}"
            content_tag(:p, content, class: 'col-md-12 small my-0 px-0')
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
