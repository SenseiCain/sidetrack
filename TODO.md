STEP - 1
    *   Create models 
        /-   Users: name, email, password, providers, image
        /-   Posts: title, description, created_at
        /-   Category: name
        /-   Comments: description
        /-   Votes: need a way to denote 'up votes' & 'down votes'
    *   /Set up relations
    *   /Set up validations
    *   Create seed data
    *   TEST :)

STEP - 2
    *   Create Contollers
    *   ...

STEP - 3
    *   Set up views w/ basic forms
    *   ...

STEP - 4
    *   StandardAuthentication & Authorization

STEP - 5
    *   OmniAuth - Google & GitHub
    *   User & Identity models
        -   https://stackoverflow.com/questions/19486567/rails-oauth-multiple-providers
        -   http://blog.railsrumble.com/2010/10/08/intridea-omniauth/
    *   ...

STEP - 6
    *   Style
    *   ...


Latter steps
    *   Set up Asset pipeline - https://guides.rubyonrails.org/asset_pipeline.html
    *   Send upvotes without reloading page (js webhooks or something???)
    *   Create custom generators