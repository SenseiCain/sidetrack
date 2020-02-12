module PostsHelper
    def display_posts(posts)
        html = posts.map do |p|
            display_post p
        end.join('')

        raw(html)
    end

    def display_post(post)

        if post.comments.any?
            comments = post.comments.map do |c|
                "<li>#{ c.user.name } - #{ c.description }</li>"
            end.join('')

            comments_html = "
                <li style='list-style-type: none'>
                    <ul>
                        #{ comments }   
                    </ul>
                </li>"
        else
            comments_html = nil
        end

        "
            <div class='row'>
                <div class='col-md-1'>
                    <div class='row>
                        <h5 class='text-center'>#{ post.votes.count }</h5>
                    </div>
                </div>
                <div class='col-md-11'>
                    <h4>#{ post.title }</h4>
                    
                    <p> #{ post.comments.count } Comments - #{ post.user.name } - #{ post.created_at } </p>
                </div>
            </div>
        "
    end
end
