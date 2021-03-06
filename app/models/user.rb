class User < ApplicationRecord
    has_secure_password

    has_many :posts
    has_many :comments
    has_many :votes
    has_many :authorizations

    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, confirmation: true
    validates_confirmation_of :email
    validates :password, presence: true, confirmation: true
    validates_confirmation_of :password

    before_save :downcase_name

    def self.find_or_create_from_hash!(hash)
        unless @user = find_by(email: hash['info']['email'])
            @user = new(name: hash['info']['name'], email: hash['info']['email'], password: SecureRandom.hex(6))

            if !hash[:info][:image].empty?
                @user.image = hash[:info][:image]
            end

            @user.save
        end

        @user
    end

    def url_encoded_name
        if name.match(/\s/)
            name.gsub(' ', '-')
        end

        name.downcase
    end

    def display_formatted_name
        name.titlecase
    end

    private

    def downcase_name
        self.name.downcase!
    end
end
