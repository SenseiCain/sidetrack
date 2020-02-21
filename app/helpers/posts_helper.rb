include Rails.application.routes.url_helpers

module PostsHelper
    # REFERENCE ARTICLE - https://www.toptal.com/ruby-on-rails/rails-helper-bootstrap-carousel

    def display_post_tag(post, vote, user)
        main = PostTag.new(self, post, vote, user).html
        vote = VoteTag.new(self, post, vote, user).html
        content = safe_join([vote, main])
        @uid = SecureRandom.hex(6)
        content_tag(:div, content, id: @uid, class: 'row m-0 border')
    end

    def display_vote_tag(post, vote, user)
        @vote = VoteTag.new(self, post, vote, user).html
    end

    class PostTag
        def initialize(view, post, vote, user)
            @view, @post, @vote, @user = view, post, vote, user
        end

        def html
            main
        end

        private

        attr_accessor :view, :post, :uid
        delegate :link_to, :content_tag, :image_tag, :image_submit_tag, :hidden_field_tag, :raw, :safe_join, :form_for, to: :view

        def main
            content = safe_join([title_tag, categories_tag, info_tag])
            inside = content_tag(:div, content, class: 'row px-2 d-flex flex-column align-items-center m-0')
            content_tag(:div, inside, class: 'col-md-11 py-1 px-2')
        end

        def title_tag
            header_tag = content_tag(:p, @post.title, class: 'my-0 px-0')
            content_tag(:a, header_tag, class: 'my-0 px-0 col-md-12', style: 'text-decoration: none; color: inherit', href: post_path(@post))
        end

        def categories_tag
            if @post.categories.any?
                content_div = @post.categories.map{|c| 
                    content_tag :span, class: 'badge badge-transparent mr-2 text-info px-0' do
                        link_to c.name, "/?query[categories]=#{c.id}", style: 'text-decoration: none;', class: 'py-0'
                    end
                }
            else
                content_div = [content_tag(:div, '', class: 'col-md-12', style: 'height: 18px')]
            end

            content_tag(:div, safe_join(content_div), class: 'col-md-12 my-0 px-0 d-flex')
        end

        def info_tag
            comments = @post.comments.count.to_s + ' Comments - '
            user_link = link_to @user.name + ' - ', user_path(@user.url_encoded_name), class: "hovered"
            date = format_date
            content = safe_join([comments, user_link, date])
            content_tag(:p, content, class: 'col-md-12 small my-0 px-0 text-muted')
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

    class VoteTag
        def initialize(view, post, vote, user)
            @view, @post, @vote, @user = view, post, vote, user
        end

        def html
            vote
        end

        private

        attr_accessor :view, :post, :uid
        delegate :link_to, :content_tag, :image_tag, :image_submit_tag, :hidden_field_tag, :raw, :safe_join, :form_for, to: :view

        def vote
            content = safe_join([arrow_tag('up'), count_tag, arrow_tag('down')])
            content_tag(:div, content, class: 'col-md-1 d-flex flex-column align-items-center justify-content-between m-0 px-0 py-0 border-right')
        end
        
        def count_tag
           content_tag(:p, @post.rating, class: 'm-0 p-0')
        end

        def arrow_tag(type)
            if @user
                user_id = @user.id
            else
                user_id = nil
            end

            if type == 'up'
                status = true
                image = 'up-arrow.png'
            else
                status = false
                image = 'down-arrow.png'
            end

            content = safe_join([
                content_tag(:input, '', type: 'hidden', name: 'vote[status]', value: status),
                content_tag(:input, '', type: 'hidden', name: 'vote[user_id]', value: user_id),
                content_tag(:input, '', type: 'hidden', name: 'vote[post_id]', value: @post.id),
                image_submit_tag(image)
            ])

            content2 = form_for @vote do |f|
                content
            end

            content_tag(:div, content2, class: 'row d-flex flex-column align-items-center justify-content-center', style: 'height: 100%')
        end
    end

end