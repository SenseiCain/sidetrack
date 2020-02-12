module PostsHelper
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

        raw("
            <p>
                <ul>
                    <li>Title: #{ post.title }</li>
                    <li>Description: #{ post.description }</li>
                    <li>Vote count: #{ post.votes.count }</li>
                    #{ comments_html}
                </ul>
            </p>
        ")
    end
end
